package crowd.impl.mailru
{
	import crowd.core.environment.ICrowdEnvironmentInitializer;
	import crowd.core.js_api.IJSApi;
	import crowd.core.rest_api.IRestApiInitializer;
	import crowd.core.soc_factory.ISocialFactory;
	import crowd.impl.mailru.MailruEnvironment;
	import crowd.impl.mailru.MailruJSApi;
	import crowd.impl.mailru.MailruRestApiInitializer;
	import crowd.impl.mailru.MailruInitData;
	import crowd.SocialTypes;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class MailruFactory implements ISocialFactory
	{
		private var _initData:MailruInitData;
		
		public function MailruFactory(initData:MailruInitData)
		{
			_initData = initData;
		}
		
		public function getEnvironmentInitializer():ICrowdEnvironmentInitializer 
		{
			return new MailruEnvironment(_initData);
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
			return new MailruRestApiInitializer(_initData);
		}
		
		public function get soc_type():String 
		{
			return SocialTypes.MAILRU;
		}
		
	}

}