package crowd_framework.vk_impl.rest_api 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class VkontakteLoader extends BaseAPILoaderDispatcher implements ApiLoader
	{
		private var _loader:URLLoader;
		private var _xmlData:XML;
		
		public function VkontakteLoader() 
		{
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void 
		{
			dispatchSystemError(SystemErrorEvent.SECURITY_ERROR);
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			dispatchSystemError(SystemErrorEvent.IO_ERROR);
		}
		
		private function onComplete(e:Event):void 
		{
			var xml:XML = XMLChecker.getXML(_loader.data);
			
			if (xml == null) {
				dispatchSystemError(SystemErrorEvent.INVALID_DATA_FORMAT);
				return;
			}
			
			var apiError:ApiError = checkForApiError(xml);
			if (apiError != null) {
				dispatchApiError(apiError);
				return;
			}
			
			_xmlData = xml;
			dispatchComplete();
		}
		
		private function checkForApiError(xml:XML):ApiError {
			if (String(xml.error_code) != "") {
				return new VkontakteApiError(xml);
			}
			return null;
		}
		
		public function load(req:URLRequest):void 
		{
			//trace(req.url);
			_loader.load(req);
		}
		
		public function get xmlData():XML 
		{
			return _xmlData;
		}
		
		public function get type():String {
			return SocialTypes.VKONTAKTE;
		}
		
	}

}