package crowd.vk_impl.soc_factory
{
	import crowd.core.js_api.IJSApi;
	import crowd.core.environment.ICrowdEnvironmentInitializer;
	import crowd.core.rest_api.IRestApiInitializer;
	import crowd.core.soc_factory.ISocialFactory;
	import crowd.SocialTypes;
	import crowd.vk_impl.environment.VkontakteEnvironment;
	import crowd.vk_impl.js_api.VkontakteJSApi;
	import crowd.vk_impl.rest_api.VKRestApiInitializer;
	import crowd.vk_impl.soc_init_data.VkontakteInitData;
	
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
		
		/* INTERFACE crowd.core.soc_factory.ISocialFactory */
		
		public function getRestApiInitializer():IRestApiInitializer 
		{
			return new VKRestApiInitializer(_initData);
		}
		
		public function get soc_type():String 
		{
			return SocialTypes.VKONTAKTE;
		}
		
	}

}