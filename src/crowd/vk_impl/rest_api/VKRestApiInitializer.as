package crowd.vk_impl.rest_api
{
	import crowd.core.rest_api.AbstractRestApiInitializer;
	import crowd.core.rest_api.loaders.IRestApiLoader;
	import crowd.SocialTypes;
	import crowd.vk_impl.soc_init_data.VkontakteInitData;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class VKRestApiInitializer extends AbstractRestApiInitializer 
	{
		
		public function VKRestApiInitializer(initData:VkontakteInitData) 
		{
			super(initData);
		}
		
		override public function getLoader():IRestApiLoader 
		{
			return new VKLoader(synchronizer, initData as VkontakteInitData);
		}
		
		override public function get soc_type():String 
		{
			return SocialTypes.VKONTAKTE;
		} 
	}

}