package crowd_framework.mailru_impl.soc_factory 
{
	import crowd_framework.core.js_api.IJSApi;
	import crowd_framework.core.environment.ICrowdEnvironmentInitializer;
	import crowd_framework.core.rest_api.IRestApiInitializer;
	import crowd_framework.core.soc_factory.ISocialFactory;
	import crowd_framework.mailru_impl.environment.MailRuEnvironment;
	import crowd_framework.mailru_impl.rest_api.MailRuRestApiInitializer;
	import crowd_framework.mailru_impl.soc_init_data.MailRuInitData;
	import crowd_framework.SocialTypes;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class MailRuFactory implements ISocialFactory 
	{
		private var _initData:MailRuInitData;
		
		public function MailRuFactory(initData:MailRuInitData) 
		{
			_initData = initData;
			
		}
		
		public function getEnvironmentInitializer():ICrowdEnvironmentInitializer 
		{
			return new MailRuEnvironment(_initData);
		}
		
		public function getJSApi():IJSApi 
		{
			return null;
		}
		
		public function getJSApiInitParams():* 
		{
			return null;
		}
		
		/* INTERFACE crowd_framework.core.soc_factory.ISocialFactory */
		
		public function getRestApiInitializer():IRestApiInitializer 
		{
			return new MailRuRestApiInitializer();
		}
		
		public function get soc_type():String 
		{
			return SocialTypes.MAILRU;
		}
		
	}

}