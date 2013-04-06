package crowd.impl.vkontakte
{
	import crowd.core.IJSApi;
	import crowd.core.ICrowdEnvironmentInitializer;
	import crowd.core.IRestApiInitializer;
	import crowd.core.ISocialFactory;
	import crowd.SocialTypes;
	import crowd.impl.vkontakte.VkontakteEnvironment;
	import crowd.impl.vkontakte.VkontakteJSApi;
	import crowd.impl.vkontakte.VkontakteRestApiInitializer;
	import crowd.impl.vkontakte.VkontakteInitData;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class VkontakteFactory implements ISocialFactory
	{
		private var _initData:VkontakteInitData;
		
		public function VkontakteFactory(initData:VkontakteInitData)
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
			return new VkontakteRestApiInitializer(_initData);
		}
		
		public function get soc_type():String 
		{
			return SocialTypes.VKONTAKTE;
		}
		
	}

}