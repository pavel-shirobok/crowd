package crowd_framework.vk_impl.soc_init_data 
{
	import crowd_framework.core.ISocialType;
	import crowd_framework.core.js_api.IJSApi;
	import crowd_framework.core.soc_init_data.ICrowdInitData;
	import crowd_framework.SocialTypes;
	import flash.display.Stage;
	/**
	 * ...
	 * @author 
	 */
	public class VkontakteInitData implements ICrowdInitData
	{
		private var _flash_vars:Object;
		private var _mock_js:IJSApi;

		public function VkontakteInitData(stage:Stage) 
		{
			_flash_vars = stage.loaderInfo.parameters;
		}
		
		/* INTERFACE crowd_framework.core.soc_init_data.ICrowdInitData */
		
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