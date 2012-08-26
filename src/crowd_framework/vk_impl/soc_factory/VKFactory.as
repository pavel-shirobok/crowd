package crowd_framework.vk_impl.soc_factory 
{
	import crowd_framework.core.js_api.IJSApi;
	import crowd_framework.core.environment.ICrowdEnvironmentInitializer;
	import crowd_framework.core.soc_factory.ISocialFactory;
	import crowd_framework.core.SocialTypes;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class VKFactory implements ISocialFactory 
	{
		
		public function VKFactory() 
		{
			
		}
		
		public function getEnvironmentInitializer():ICrowdEnvironmentInitializer 
		{
			return null;
		}
		
		public function getJSApi():IJSApi 
		{
			return null;
		}
		
		public function get soc_type():String 
		{
			return SocialTypes.VKONTAKTE;
		}
		
	}

}