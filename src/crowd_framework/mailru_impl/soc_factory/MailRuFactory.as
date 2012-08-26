package crowd_framework.mailru_impl.soc_factory 
{
	import crowd_framework.core.js_api.IJSApi;
	import crowd_framework.core.environment.ICrowdEnvironmentInitializer;
	import crowd_framework.core.soc_factory.ISocialFactory;
	import crowd_framework.SocialTypes;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class MailRuFactory implements ISocialFactory 
	{
		
		public function MailRuFactory() 
		{
			
		}
		
		/* INTERFACE crowd_framework.core.soc_factory.ISocialFactory */
		
		public function getEnvironmentInitializer():ICrowdEnvironmentInitializer 
		{
			return null;
		}
		
		public function getJSApi():IJSApi 
		{
			return null;
		}
		
		/* INTERFACE crowd_framework.core.soc_factory.ISocialFactory */
		
		public function getJSApiInitParams():* 
		{
			return null;
		}
		
		public function get soc_type():String 
		{
			return SocialTypes.MAILRU;
		}
		
	}

}