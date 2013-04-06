package crowd.impl.odnoklassniki
{	
	import crowd.core.IJSApi;
	import crowd.core.MockJS;
	import crowd.core.ICrowdInitData;
	import crowd.RestApiFormat;
	import crowd.SocialTypes;
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class OdnoklassnikiInitData implements ICrowdInitData 
	{
		private var _secret:String;
		private var _rest_api_format:String = RestApiFormat.XML_FORMAT;
		private var _mock_js:IJSApi;
		
		public function OdnoklassnikiInitData(secret:String) 
		{
			_secret = secret;
			_mock_js = new MockJS(soc_type);
		}
		
		public function get request_per_second_limit():int 
		{
			return 3;
		}
		
		public function get rest_api_format():String 
		{
			return _rest_api_format;
		}
		
		public function set rest_api_format(value:String):void 
		{
			_rest_api_format = value;
		}
		
		public function set mock_js(value:IJSApi):void 
		{
			_mock_js = value;
		}
		
		public function get mock_js():IJSApi 
		{
			return _mock_js;
		}
		
		public function get soc_type():String 
		{
			return SocialTypes.ODNOKLASSNIKI;
		}
		
		public function get secret():String 
		{
			return _secret;
		}
		
	}

}