package crowd_framework.mailru_impl.rest_api 
{
	import crowd_framework.core.rest_api.AbstractRestApiInitializer;
	import crowd_framework.core.rest_api.loaders.IRestApiLoader;
	import crowd_framework.SocialTypes;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class MailRuRestApiInitializer extends AbstractRestApiInitializer 
	{
		
		public function MailRuRestApiInitializer() 
		{
			super();
			
		}
		
		override public function getLoader():IRestApiLoader 
		{
			return null;
		}
		
		override public function get soc_type():String 
		{
			return SocialTypes.MAILRU;
		}
	}

}