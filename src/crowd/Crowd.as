package crowd
{
	//{imports
	import com.ramshteks.as3.*;
	import com.ramshteks.as3.debug.*;
	import com.ramshteks.as3.vars_holder.*;
	import crowd.*;
	import crowd.core.environment.*;
	import crowd.core.events.*;
	import crowd.core.js_api.*;
	import crowd.core.rest_api.*;
	import crowd.core.rest_api.synchronizer.*;
	import crowd.core.soc_factory.*;
	import crowd.core.soc_init_data.*;
	import crowd.mailru_impl.soc_factory.*;
	import crowd.mailru_impl.soc_init_data.*;
	import crowd.ok_impl.soc_factory.OKFactory;
	import crowd.ok_impl.soc_init_data.OdnoklassnikiInitData;
	import crowd.vk_impl.soc_factory.*;
	import crowd.vk_impl.soc_init_data.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	//}
	
	//{events - metatags
	[Event(name = "complete", type = "flash.events.Event")]
	[Event(name = "error"   , type = "flash.events.ErrorEvent")]
	[Event(name = "log_message", type="crowd.core.events.LogEvent")]
	//}
	
	/**
	 * Crowd - class  of the classes in over the world and all time since current moment
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class Crowd extends EventDispatcher {
		public static const Owner:String = "@Owner@";
		
		//{statics
		private static var _environment:ICrowdEnvironment;
		private static var _syncronizer:RestApiSynchronizer;
		private static var _rest_api:IRestApi;
		private static var _soc_type:String = '';
		private static var _debug_mode:Boolean = false;
		//}
		//{privates
		private var _debugFilePath:String = "debug_data.xml";
		private var _realFlashVars:FlashVarsHolder;
		private var _alreadyStarted:Boolean = false;
		private var _log_to_trace:Boolean;
		private var _initdataHolder:Array = [];
		private var _loader:URLLoader;
		private var _stage:Stage;
		//}
		
		//{public methods
		public function Crowd(log_to_trace:Boolean = true) {
			_log_to_trace = log_to_trace;
		}
		
		public function addInitData(initData:ICrowdInitData):void {
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
				try{
					startAsInRealSocialNetwork();
				}catch (e:Error) {
					dispatchLog(e.name, e.message)
				}
			}
			
		}
		//}
		
		//{private methods
		private function startAsStandalone():void {
			dispatchLog("run as standalone");
			
			_debug_mode = true;
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onCommonLoadingError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onCommonLoadingError);
			_loader.load(new URLRequest(_debugFilePath));
		}
		
		private function startAsInRealSocialNetwork():void {
			dispatchLog("run as in real social network");
			
			dispatchLog("initing start logic");
			var initData:ICrowdInitData = _initdataHolder[_soc_type];
			var factory:ISocialFactory = getSocialFactoryByType(_soc_type, initData);
			var env:ICrowdEnvironmentInitializer = factory.getEnvironmentInitializer();
			
			if (env == null) {
				dispatchError(StringUtils.printf("Unsupported social type '%s%'", _soc_type));
				return;
			}
			
			env.setFlashVarsHolder(cleanVars(factory.soc_type, _realFlashVars));
			
			dispatchLog("initing synchronizer");
			_syncronizer = constructSynchronizer(initData);
			
			dispatchLog("initing rest api");
			var rest_api_initializer:IRestApiInitializer = factory.getRestApiInitializer()
			rest_api_initializer.setEnvironment(_environment);
			rest_api_initializer.setSynchronizer(_syncronizer);

			dispatchLog("initing js api");
			var js:IJSApi = factory.getJSApi();
			js.addEventListener(Event.CONNECT, onJSConnect);
			js.addEventListener(JSApiErrorEvent.CONNECT_FAILED, onJSConnectFailed);
			env.setJSApi(js);
			_environment = env;
			
			var jsMessage:String = "connecting js to environment";
			if (_environment.soc_type == SocialTypes.MAILRU) {
				jsMessage += "Note: If initing stops on this step, it may mean, that it is not installed System.allowDomain";
			}
			dispatchLog(jsMessage);
			js.init(factory.getJSApiInitParams());
		}
		
		private function onJSConnectFailed(e:JSApiErrorEvent):void {
			dispatchError(StringUtils.printf("JS connection crash with message '%m%'", e.message));
		}
		
		private function onJSConnect(e:Event):void {
			dispatchLog("Init complete: Crowd ready to rock!");
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
			
			var factory:ISocialFactory = getSocialFactoryByType(default_soc_type, initData);
			if (factory == null) {
				dispatchError("No social factory for type '" + default_soc_type + "'");
				return;
			}
			
			dispatchLog("default social type '" + default_soc_type + "'");
			_syncronizer = constructSynchronizer(initData);
			
			var varsHolder:IVarsHolder = cleanVars(factory.soc_type, new XMLVarsHolder(xml_socData));
			
			var envIniter:ICrowdEnvironmentInitializer = factory.getEnvironmentInitializer();
			envIniter.setFlashVarsHolder(varsHolder);
			envIniter.setJSApi(initData.mock_js);
			
			_soc_type = envIniter.soc_type;
			_environment = envIniter as ICrowdEnvironment;
			
			var rest_api_initializer:IRestApiInitializer = factory.getRestApiInitializer()
			rest_api_initializer.setEnvironment(_environment);
			rest_api_initializer.setSynchronizer(_syncronizer);
			
			_rest_api = rest_api_initializer;
			
			dispatchLog("Init complete: Crowd ready to rock!");
			dispatchComplete();
		}
		
		private function checkForSupporting(soc_type:String):Boolean {
			return (soc_type == SocialTypes.MAILRU) || (SocialTypes.VKONTAKTE == soc_type) || (SocialTypes.ODNOKLASSNIKI == soc_type);
		}
		
		private function getSocialFactoryByType(soc_type:String, initData:ICrowdInitData):ISocialFactory {
			var result:ISocialFactory;
			
			switch(soc_type) {
				case SocialTypes.VKONTAKTE:
					result = new VKFactory(initData as VkontakteInitData);
					break;
				/*@MAIL_RU_ACTIVED@*/
				case SocialTypes.MAILRU:
					result = new MailRuFactory(initData as MailRuInitData);
					break;//*/
				
				/*@OK_ACTIVE@*/
				case SocialTypes.ODNOKLASSNIKI:
					return new OKFactory(initData as OdnoklassnikiInitData);
					break;//*/
			}
			
			return result;
		}
		
		private function cleanVars(soc_type:String, varsHolder:IVarsHolder):IVarsHolder {
			/*@INSTALL_LICENSE@
			var overridable:OverridableVarHolder = new OverridableVarHolder(varsHolder);
			
			switch(soc_type) {
				case SocialTypes.VKONTAKTE:
					overridable.overrideVar("api_id", "@VK_APP_IP@");
					break;
				case SocialTypes.MAILRU:
					overridable.overrideVar("app_id", "@MM_APP_ID@");
					break;
				default:
					throw new Error("Unknown soc_type = '"+soc_type+"'");
			}
			
			varsHolder = overridable;
			//*/
			
			return varsHolder;
		}
		
		private function dispatchLog(...log:Array):void {
			if (_log_to_trace) {
				var str:String = "[crowd log] " + log.join(" ");
				trace(str);
				dispatchEvent(new LogEvent(LogEvent.LOG_MESSAGE, str));
			}
		}
		
		private function dispatchComplete():void {
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function dispatchError(message:String = ""):void {
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, message));
		}
		
		private function constructSynchronizer(initData:ICrowdInitData):RestApiSynchronizer {
			return new RestApiSynchronizer(1 / initData.request_per_second_limit * 1000);
		}
		//}
		
		//{setters and getters
		public function get debugFilePath():String {
			return _debugFilePath;
		}
		
		public function set debugFilePath(value:String):void {
			_debugFilePath = value;
		}
		
		static public function get environment():ICrowdEnvironment {
			return _environment;
		}
		
		static public function get rest_api():IRestApi {
			return _rest_api;
		}
		
		public static function get isDebugMode():Boolean {
			return _debug_mode;
		}
		
		static public function get soc_type():String {
			return _soc_type;
		}
		//}
	}

}