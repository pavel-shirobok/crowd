package crowd_framework.mailru_impl.rest_api 
{
	import crowd_framework.core.events.SystemErrorEvent;
	import crowd_framework.core.rest_api.loaders.AbstractRestApiLoader;
	import crowd_framework.core.rest_api.syncronizer.RestApiSynchronizer;
	import crowd_framework.SocialTypes;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLStream;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class MailruLoader extends AbstractRestApiLoader
	{
		private var _loader:URLStream;
		private var _data:String = "";
		
		public function MailruLoader(synchronizer:RestApiSynchronizer) 
		{
			super(SocialTypes.MAILRU, synchronizer);
			
			_loader = new URLStream();
			_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void 
		{
			dispatchSystemError(SystemErrorEvent.DETAIL_SECURITY_ERROR);
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			//#2000 security error dirty hack, thank you mail.ru, adobe inc., and all over the world
		}
		
		private function onHttpStatus(e:HTTPStatusEvent):void 
		{
			if (e.status == 200) {
				onComplete();
				return;
			}
			
			try {
				var apiError:MailRuRestApiErrorReport = new MailRuRestApiErrorReport(getData());
				dispatchApiError(apiError)
			}catch (e:Error) {
				dispatchSystemError(SystemErrorEvent.DETAIL_IO_ERROR);
			}
		}
		
		private function onComplete():void 
		{
			/*var data:String = getData();
			var xml:XML = XMLChecker.getXML(data);
			
			if (xml == null) {
				dispatchSystemError(SystemErrorEvent.DETAIL_INVALID_DATA_FORMAT);
			}
			
			_xmlData = xml;*/
			dispatchComplete();
		}
		private function getData():String {
			if (_data == "") {
				_data = _loader.readMultiByte(_loader.bytesAvailable, "utf8");
			}
			return _data;
		}
		/*
		
		
		public function load(req:URLRequest):void 
		{
			_loader.load(req);
		}
		
		public function get xmlData():XML 
		{
			return _xmlData;
		}
		
		public function get type():String {
			return SocialTypes.MAILRU;
		}
		*/
	}

}