package crowd_framework 
{
	import com.ramshteks.as3.debug.Assert;
	import com.ramshteks.as3.StringUtils;
	import com.ramshteks.as3.vars_holder.FlashVarsHolder;
	import com.ramshteks.as3.vars_holder.IVarsHolder;
	import com.ramshteks.as3.vars_holder.XMLVarsHolder;
	import crowd_framework.core.environment.ICrowdEnvironment;
	import crowd_framework.core.environment.ICrowdEnvironmentInitializer;
	import crowd_framework.core.events.JSApiErrorEvent;
	import crowd_framework.core.js_api.IJSApi;
	import crowd_framework.core.soc_factory.ISocialFactory;
	import crowd_framework.core.soc_init_data.ICrowdInitData;
	import crowd_framework.mailru_impl.soc_factory.MailRuFactory;
	import crowd_framework.SocialTypes;
	import crowd_framework.vk_impl.soc_factory.VKFactory;
	import crowd_framework.vk_impl.soc_init_data.VkontakteInitData;
	import flash.display.Stage;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class Crowd extends EventDispatcher
	{
		private static var _environment:ICrowdEnvironment;
		
		private var _debugFilePath:String = "debug_data.xml";
		private var _realFlashVars:FlashVarsHolder;
		private var _alreadyStarted:Boolean = false;
		private var _log_to_trace:Boolean;
		private var _initdataHolder:Array = [];
		private var _loader:URLLoader;
		private var _stage:Stage;
		private var _soc_type:String = '';
		
		private var _debug_mode:Boolean = false;
		
		public function Crowd(log_to_trace:Boolean = true) {
			_log_to_trace = log_to_trace;
		}
		
		public function registerSocialInitData(initData:ICrowdInitData):void {
			Assert.isIncorrect(_alreadyStarted, "Crowd framework alrady started");
			Assert.isNull(_initdataHolder[initData.soc_type], "For '" + initData.soc_type + "' init data already registered");
			
			_initdataHolder[initData.soc_type] = initData;
		}
		
		public function startCrowd(stage:Stage):void {
			Assert.isIncorrect(_alreadyStarted, "Crowd framework alrady started");
			
			_stage = stage;
			_alreadyStarted = true;
			
			_realFlashVars = new FlashVarsHolder(stage);
			_soc_type = SocialTypes.getSocialTypeByFlashVars(_realFlashVars);
			if (_soc_type == SocialTypes.UNKNOW) {
				startAsStandalone();
			}else {
				startAsInRealSocialNetwork();
			}
			
		}
		
		private function startAsStandalone():void 
		{
			dispatchLog("run as standalone");
			
			_debug_mode = true;
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onCommonLoadingError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onCommonLoadingError);
			_loader.load(new URLRequest(_debugFilePath));
		}
		
		private function startAsInRealSocialNetwork():void 
		{
			dispatchLog("run as in real social network");
			
			var initData:ICrowdInitData = _initdataHolder[_soc_type];
			
			var factory:ISocialFactory = getSocialFactoryByType(_soc_type, initData);
			var env:ICrowdEnvironmentInitializer = factory.getEnvironmentInitializer();
			
			if (env == null) {
				dispatchError(StringUtils.printf("Unsupported social type '%s%'", _soc_type));
				return;
			}
			
			env.setFlashVarsHolder(new FlashVarsHolder(_stage));
			
			var js:IJSApi = factory.getJSApi();
			
			js.addEventListener(Event.CONNECT, onJSConnect);
			js.addEventListener(JSApiErrorEvent.CONNECT_FAILED, onJSConnectFailed);
			
			_environment = env;
			
			env.setJSApi(js);
			
			var js_inits:* = factory.getJSApi()
			
			js.init(factory.getJSApiInitParams());
			dispatchLog("init js");
		}
		
		private function onJSConnectFailed(e:JSApiErrorEvent):void 
		{
			dispatchError(StringUtils.printf("JS connection crash with message '%m%'", e.message));
		}
		
		private function onJSConnect(e:Event):void 
		{
			dispatchComplete();
		}
		
		private function onCommonLoadingError(e:ErrorEvent):void {
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, "Error loading debug file. Type:" + e.type));
		}
		
		private function onComplete(e:Event):void {
			var xml:XML;
			
			try {
				xml = new XML(_loader.data);
			}catch (e:Error) {
				dispatchError("Debug-XML parsing error, maybe xml not xml? ;)");
				return;
			}
			
			var default_soc_type:String = xml.@default;
			if (!checkForSupporting(default_soc_type)) {
				dispatchError("Default social type '" + default_soc_type + "' not supporting. Maybe later? ;)");
				return;
			}
			
			var xml_socData:XMLList = xml.child(default_soc_type);
			
			if (xml_socData.toXMLString().length == 0) {
				dispatchError("Default soc_type not found in debug xml. See root attributes 'default'");
				return;
			}
			
			var initData:ICrowdInitData = _initdataHolder[default_soc_type];
			if (initData == null) {
				dispatchError("Init data for '" + default_soc_type + "' not defined. Use Crowd#registerSocialInitData method");
				return;
			}
			
			var socFactory:ISocialFactory = getSocialFactoryByType(default_soc_type, initData);
			if (socFactory == null) {
				dispatchError("No social factory for type '" + default_soc_type + "'");
				return;
			}
			
			dispatchLog("default social type '" + default_soc_type + "'");
			
			var envIniter:ICrowdEnvironmentInitializer = socFactory.getEnvironmentInitializer();
			
			envIniter.setFlashVarsHolder(new XMLVarsHolder(xml_socData));
			envIniter.setJSApi(initData.mock_js);
			
			_environment = envIniter as ICrowdEnvironment;
			
			dispatchComplete();
		}
		
		private function checkForSupporting(soc_type:String):Boolean {
			return (soc_type == SocialTypes.MAILRU) || (SocialTypes.VKONTAKTE == soc_type);
		}
		
		public function getSocialFactoryByType(soc_type:String, initData:ICrowdInitData):ISocialFactory {
			var result:ISocialFactory;
			switch(soc_type) {
				case SocialTypes.VKONTAKTE:
					result = new VKFactory(initData as VkontakteInitData);
					break;
				case SocialTypes.MAILRU:
					result = new MailRuFactory();
					break;
			}
			
			return result;
		}
		
		private function dispatchLog(...log:Array):void {
			if (_log_to_trace) {
				trace("[crowd log] " + log.join(" "));
			}
		}
		
		private function dispatchComplete():void {
			//dispatchLog("init complete, crowd ready to use");
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function dispatchError(message:String = ""):void {
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, message));
		}
		
		public function get debugFilePath():String {
			return _debugFilePath;
		}
		
		public function set debugFilePath(value:String):void {
			_debugFilePath = value;
		}
		
		static public function get environment():ICrowdEnvironment {
			return _environment;
		}
	}

}