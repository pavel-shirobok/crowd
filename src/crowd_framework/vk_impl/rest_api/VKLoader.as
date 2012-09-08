package crowd_framework.vk_impl.rest_api 
{
	import crowd_framework.core.events.SystemErrorEvent;
	import crowd_framework.core.rest_api.IRestApiErrorReport;
	import crowd_framework.core.rest_api.loaders.AbstractRestApiLoader;
	import crowd_framework.core.rest_api.synchronizer.RestApiSynchronizer;
	import crowd_framework.SocialTypes;
	import crowd_framework.vk_impl.soc_init_data.VkontakteInitData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class VKLoader extends AbstractRestApiLoader
	{
		private var _loader:URLLoader;
		private var _xmlData:XML;
		
		public function VKLoader(synchronizer:RestApiSynchronizer, initData:VkontakteInitData) 
		{
			super(synchronizer, initData);
			
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_loader.addEventListener(ProgressEvent.PROGRESS, onProgress)
		}
		
		private function onProgress(e:ProgressEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function onComplete(e:Event):void 
		{
			//TODO make this complete
			/*var xml:XML = XMLChecker.getXML(_loader.data);
			
			try {
				xml = new XML(_loader.data)
			}
			
			if (xml == null) {
				dispatchSystemError(SystemErrorEvent.DETAIL_INVALID_DATA_FORMAT);
				return;
			}
			
			var apiError:ApiError = checkForApiError(xml);
			if (apiError != null) {
				dispatchApiError(apiError);
				return;
			}
			
			_xmlData = xml;*/
			dispatchComplete();
		}
		
		override public function get data():* 
		{
			return _loader.data;
		}
		
		private function checkForApiError(xml:XML):IRestApiErrorReport {
			if (String(xml.error_code) != "") {
				//TODO return new VkontakteApiError(xml);
			}
			return null;
		}
		
		override protected function realLoad(req:URLRequest):void 
		{
			_loader.load(req);
		}
	}

}