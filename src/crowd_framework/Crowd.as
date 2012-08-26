package crowd_framework 
{
	import com.ramshteks.as3.debug.Assert;
	import com.ramshteks.as3.vars_holder.FlashVarsHolder;
	import crowd_framework.core.soc_factory.ISocialFactory;
	import crowd_framework.core.soc_init_data.ICrowdInitData;
	import crowd_framework.core.SocialTypes;
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
		private var _debugFilePath:String;
		private var _realFlashVars:FlashVarsHolder;
		private var _alreadyStarted:Boolean = false;
		private var _log_to_trace:Boolean;
		private var _initdataHolder:Array = [];
		private var _loader:URLLoader;
		
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
			
			_alreadyStarted = true;
			
			_realFlashVars = new FlashVarsHolder(stage);
			
			if (SocialTypes.getSocialTypeByFlashVars(_realFlashVars) == SocialTypes.UNKNOW) {
				startAsStandalone();
			}else {
				startAsInRealSocialNetwork();
			}
			
		}
		
		private function startAsStandalone():void 
		{
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onCommonLoadingError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onCommonLoadingError);
			_loader.load(new URLRequest(_debugFilePath));
		}
		
		private function onCommonLoadingError(e:ErrorEvent):void 
		{
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, "Error loading debug file. Type:" + e.type));
		}
		
		private function onComplete(e:Event):void 
		{
			/*var xml:XML = _loader.xmlData;
			var default_soc_type:String = xml.@default;
			var xml_socData:XMLList = xml.child(default_soc_type);
			
			
			
			if (xml_socData.toXMLString().length == 0) {
				dispatchError(StringUtils.printf("Default soc_type not found in debug xml. See root attributes 'default'"));
				return;
			}
			
			/*var envIniter:ICrowdEnvironmentInitializer = SocialQualifier.getEnvironmentByName(_initData, default_soc);
			if (envIniter == null) {
				dispatchError(StringUtils.printf("Unknown social type: %s%", default_soc));
				return;
			}
			
			envIniter.parseVars(new XMLVarsHolder(xml_socData));
			envIniter.setJSInstance(_initData.mock_js);
			_environment = envIniter;*/
		}
		
		private function startAsInRealSocialNetwork():void 
		{
			
		}
		
		private function dispatchLog(...log:Array):void {
			if (_log_to_trace) {
				trace(log.join(" "));
				//dispatchEvent(new LogEvent(log));
			}
		}
		
		private function dispatchComplete():void {
			//dispatchLog("init complete, crowd ready to use");
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function dispatchError(message:String = ""):void {
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, message));
		}
		
		public function get debugFilePath():String 
		{
			return _debugFilePath;
		}
		
		public function set debugFilePath(value:String):void 
		{
			_debugFilePath = value;
		}
	}

}