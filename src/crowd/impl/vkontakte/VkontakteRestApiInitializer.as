package crowd.impl.vkontakte
{
	import crowd.core.AbstractRestApiInitializer;
	import crowd.core.IRestApiLoader;
	import crowd.SocialTypes;
	import crowd.impl.vkontakte.VkontakteInitData;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class VkontakteRestApiInitializer extends AbstractRestApiInitializer
	{
		
		public function VkontakteRestApiInitializer(initData:VkontakteInitData)
		{
			super(initData);
		}
		
		override public function getLoader():IRestApiLoader 
		{
			return new VkontakteLoader(synchronizer, initData as VkontakteInitData);
		}
		
		override public function get soc_type():String 
		{
			return SocialTypes.VKONTAKTE;
		} 
	}

}