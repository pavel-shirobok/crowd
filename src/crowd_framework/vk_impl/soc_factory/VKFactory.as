package crowd_framework.vk_impl.soc_factory 
{
	import crowd_framework.core.js_api.IJSApi;
	import crowd_framework.core.environment.ICrowdEnvironmentInitializer;
	import crowd_framework.core.rest_api.IRestApiInitializer;
	import crowd_framework.core.soc_factory.ISocialFactory;
	import crowd_framework.SocialTypes;
	import crowd_framework.vk_impl.environment.VkontakteEnvironment;
	import crowd_framework.vk_impl.js_api.VkontakteJSApi;
	import crowd_framework.vk_impl.rest_api.VKRestApiInitializer;
	import crowd_framework.vk_impl.soc_init_data.VkontakteInitData;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class VKFactory implements ISocialFactory 
	{
		private var _initData:VkontakteInitData;
		
		public function VKFactory(initData:VkontakteInitData) 
		{
			_initData = initData;
			
		}
		
		public function getEnvironmentInitializer():ICrowdEnvironmentInitializer 
		{
			return new VkontakteEnvironment(_initData);
		}
		
		public function getJSApi():IJSApi 
		{
			return new VkontakteJSApi();
		}
		
		public function getJSApiInitParams():* 
		{
			return _initData.flash_vars;
		}
		
		/* INTERFACE crowd_framework.core.soc_factory.ISocialFactory */
		
		public function getRestApiInitializer():IRestApiInitializer 
		{
			return new VKRestApiInitializer();
		}
		
		public function get soc_type():String 
		{
			return SocialTypes.VKONTAKTE;
		}
		
	}

}