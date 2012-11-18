package crowd.mailru_impl.rest_api
{
	import crowd.core.rest_api.AbstractRestApiInitializer;
	import crowd.core.rest_api.loaders.IRestApiLoader;
	import crowd.core.soc_init_data.ICrowdInitData;
	import crowd.mailru_impl.soc_init_data.MailRuInitData;
	import crowd.SocialTypes;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class MailRuRestApiInitializer extends AbstractRestApiInitializer 
	{
		
		public function MailRuRestApiInitializer(initData:MailRuInitData) 
		{
			super(initData);
		}
		
		override public function getLoader():IRestApiLoader 
		{
			return new MailruLoader(synchronizer, initData as MailRuInitData);
		}
		
		override public function get soc_type():String 
		{
			return SocialTypes.MAILRU;
		}
	}

}