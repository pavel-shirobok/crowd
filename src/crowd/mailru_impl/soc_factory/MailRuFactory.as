package crowd.mailru_impl.soc_factory
{
	import crowd.core.environment.ICrowdEnvironmentInitializer;
	import crowd.core.js_api.IJSApi;
	import crowd.core.rest_api.IRestApiInitializer;
	import crowd.core.soc_factory.ISocialFactory;
	import crowd.mailru_impl.environment.MailRuEnvironment;
	import crowd.mailru_impl.js_api.MailruJSApi;
	import crowd.mailru_impl.rest_api.MailRuRestApiInitializer;
	import crowd.mailru_impl.soc_init_data.MailRuInitData;
	import crowd.SocialTypes;
	
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
			return new MailruJSApi();
		}
		
		public function getJSApiInitParams():* 
		{
			return ["flash-app", _initData.secret];
		}
		
		public function getRestApiInitializer():IRestApiInitializer 
		{
			return new MailRuRestApiInitializer(_initData);
		}
		
		public function get soc_type():String 
		{
			return SocialTypes.MAILRU;
		}
		
	}

}