package crowd_framework.vk_impl.rest_api 
{
	import crowd_framework.core.rest_api.AbstractRestApiInitializer;
	import crowd_framework.core.rest_api.loaders.IRestApiLoader;
	import crowd_framework.SocialTypes;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class VKRestApiInitializer extends AbstractRestApiInitializer 
	{
		
		public function VKRestApiInitializer() 
		{
			super();
		}
		
		override public function getLoader():IRestApiLoader 
		{
			return new VKLoader(synchronizer);
		}
		
		override public function get soc_type():String 
		{
			return SocialTypes.VKONTAKTE;
		} 
	}

}