package crowd.impl.mailru
{
	import crowd.SocialTypes;
	import crowd.core.AbstractRestApiInitializer;
	import crowd.core.IRestApiLoader;

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