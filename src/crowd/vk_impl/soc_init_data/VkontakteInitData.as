package crowd.vk_impl.soc_init_data
{
	import crowd.core.ISocialType;
	import crowd.core.js_api.IJSApi;
	import crowd.core.js_api.MockJS;
	import crowd.core.soc_init_data.ICrowdInitData;
	import crowd.RestApiFormat;
	import crowd.SocialTypes;
	import flash.display.Stage;
	/**
	 * ...
	 * @author 
	 */
	public class VkontakteInitData implements ICrowdInitData
	{
		private var _flash_vars:Object;
		private var _mock_js:IJSApi
		private var _rest_api_format:String = RestApiFormat.XML_FORMAT;

		public function VkontakteInitData(stage:Stage) 
		{
			_flash_vars = stage.loaderInfo.parameters;
			_mock_js = new MockJS(soc_type);
		}
		
		/* INTERFACE crowd.core.soc_init_data.ICrowdInitData */
		
		public function get rest_api_format():String 
		{
			return _rest_api_format;
		}
		
		public function set rest_api_format(value:String):void 
		{
			_rest_api_format = value;
		}
		
		/* INTERFACE crowd.core.soc_init_data.ICrowdInitData */
		
		public function get request_per_second_limit():int 
		{
			return 3;
		}
		
		/* INTERFACE crowd.core.soc_init_data.ICrowdInitData */
		
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
			return SocialTypes.VKONTAKTE;
		}
		
		
		public function get flash_vars():Object 
		{
			return _flash_vars;
		}		
	}

}