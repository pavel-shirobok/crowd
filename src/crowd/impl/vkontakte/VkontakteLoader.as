package crowd.impl.vkontakte
{
	import com.adobe.serialization.json.JSON;
	import crowd.core.rest_api.IRestApiErrorReport;
	import crowd.core.rest_api.loaders.AbstractRestApiLoader;
	import crowd.core.rest_api.loaders.RestApiErrorReport;
	import crowd.core.rest_api.synchronizer.RestApiSynchronizer;
	import crowd.RestApiFormat;
	import crowd.impl.vkontakte.VkontakteInitData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class VkontakteLoader extends AbstractRestApiLoader
	{
		private var _loader:URLLoader;
		private var _xmlData:XML;
		
		//XML or JSON
		private var _result:*;
		
		public function VkontakteLoader(synchronizer:RestApiSynchronizer, initData:VkontakteInitData)
		{
			super(synchronizer, initData);
			
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onComplete);
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
			dispatchEvent(e);
		}
		
		private function onComplete(e:Event):void 
		{
			var request_data:URLVariables = request.data as URLVariables;
			var format:String = request_data["format"];
			format = format.toLowerCase();
			
			var json:Object;
			var xml:XML;
			
			switch(format) {
				case RestApiFormat.JSON_FORMAT:
					json = JSON.decode(String(_loader.data), false);
					_result = json;
					break;
					
				case RestApiFormat.XML_FORMAT:
					xml = new XML(_loader.data);
					_result = xml;
					break;
			}
			
			var apiError:IRestApiErrorReport = getApiErrorReportIfErrorWas(xml!=null?xml:json, format);
			if (apiError != null) {
				dispatchApiError(apiError);
				return;
			}
			
			dispatchComplete();
		}
		
		override public function get data():* 
		{
			return _result;
		}
		
		private function getApiErrorReportIfErrorWas(data:*, format:String):IRestApiErrorReport {
			var json:Object = data;
			var xml:XML = data as XML;
			
			switch(format) {
				case RestApiFormat.XML_FORMAT:
					if ("" != String(xml.error_code)) {
						return parseAsXML(xml);
					}
					break;
					
				case RestApiFormat.JSON_FORMAT:
					if (json["error"]!=null){
						return parseAsJson(json);
					}
					break;
			}
			
			return null;
		}
		
		private function parseAsJson(json:Object):IRestApiErrorReport 
		{
			var result:IRestApiErrorReport;
			var code:int = int(json.error.error_code);
			var message:String = String(json.error.error_msg);
			
			result = new RestApiErrorReport(soc_type, RestApiFormat.JSON_FORMAT, JSON.encode(json), code, message);
			
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
	}

}