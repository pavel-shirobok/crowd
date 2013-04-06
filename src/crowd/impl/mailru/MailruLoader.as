package crowd.impl.mailru
{
	import com.adobe.serialization.json.JSON;
	import crowd.core.rest_api.IRestApiErrorReport;
	import crowd.core.rest_api.loaders.AbstractRestApiLoader;
	import crowd.core.rest_api.loaders.RestApiErrorReport;
	import crowd.core.rest_api.synchronizer.RestApiSynchronizer;
	import crowd.impl.mailru.MailruInitData;
	import crowd.RestApiFormat;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class MailruLoader extends AbstractRestApiLoader
	{
		private var _loader:URLStream;
		private var _data:String = "";
		
		//XML OR JSON
		private var _result:*;
		
		public function MailruLoader(synchronizer:RestApiSynchronizer, initData:MailruInitData)
		{
			super(synchronizer, initData);
			
			_loader = new URLStream();
			_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_loader.addEventListener(ProgressEvent.PROGRESS, onProgress)
		}
		
		override protected function realLoad(req:URLRequest):void 
		{
			_loader.load(req);
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
			//#2000 security error dirty hack, thank you mail.ru, adobe inc., and all over the world
		}
		
		private function onHttpStatus(e:HTTPStatusEvent):void 
		{
			onComplete();
		}
		
		private function onComplete():void 
		{
			var request_data:URLVariables = request.data as URLVariables;
			var format:String = request_data["format"];
			format = format.toLowerCase();
			
			var data:String = getData();
			var error:IRestApiErrorReport = getApiErrorReportIfErrorWas(data, format);
			
			if (error != null) {
				dispatchApiError(error);
				return;
			}

			var json:Object;
			var xml:XML;
			
			switch(format) {
				case RestApiFormat.JSON_FORMAT:
					json = JSON.decode(data, true);
					_result = json;
					break;
					
				case RestApiFormat.XML_FORMAT:
					xml = new XML(data);
					_result = xml;
					break;
			}
			
			dispatchComplete();
		}
		
		private function getApiErrorReportIfErrorWas(result:*, format:String):IRestApiErrorReport 
		{
			//при определенных условиях, вне зависимости от переданных параметрах на скрипт mail.ru
			//возвращает ошибку в json, поэтому приходится сначала пробовать в json, а если не вышло в xml
			var json:Object;
			try{
				json = JSON.decode(result);
			
				if (json["error"]!=null){
					return parseAsJson(json, format);
				}
			}catch (error:Error) {
				var xml:XML = new XML(result);
				if ("" != String(xml.error_code)) {
					return parseAsXML(xml);
				}
			}
			
			return null;
		}
		
		private function parseAsJson(json:Object, format:String):IRestApiErrorReport 
		{
			var result:IRestApiErrorReport;
			var code:int = int(json.error.error_code);
			var message:String = String(json.error.error_msg);
			
			result = new RestApiErrorReport(soc_type, format, JSON.encode(json), code, message);
			
			for each(var p:* in json.error.request_params) {
				result.params[String(p.key)] = String(p.value);
			}
			
			return result;
		}
		
		private function parseAsXML(xml:XML):IRestApiErrorReport 
		{
			var result:IRestApiErrorReport;
			var code:int = int(xml.error_code);
			var message:String = String(xml.error_msg);
			
			result = new RestApiErrorReport(soc_type, RestApiFormat.XML_FORMAT, xml.toXMLString(), code, message);
			
			for each(var p:XML in xml.request_params.*) {
				result.params[String(p.key)] = String(p.value);
			}
			
			return result;
		}
		
		private function getData():String {
			if (_data == "") {
				_data = _loader.readMultiByte(_loader.bytesAvailable, "utf8");
			}
			return _data;
		}
		
		override public function get data():* 
		{
			return _result;
		}
		
	}

}