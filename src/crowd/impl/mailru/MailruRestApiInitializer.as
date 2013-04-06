package crowd.impl.mailru
{
	import crowd.core.rest_api.AbstractRestApiInitializer;
	import crowd.core.rest_api.loaders.IRestApiLoader;
	import crowd.core.soc_init_data.ICrowdInitData;
	import crowd.impl.mailru.MailruInitData;
	import crowd.SocialTypes;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class MailruRestApiInitializer extends AbstractRestApiInitializer
	{
		
		public function MailruRestApiInitializer(initData:MailruInitData)
		{
			super(initData);
		}
		
		override public function getLoader():IRestApiLoader 
		{
			return new MailruLoader(synchronizer, initData as MailruInitData);
		}
		
		override public function get soc_type():String 
		{
			return SocialTypes.MAILRU;
		}
	}

}