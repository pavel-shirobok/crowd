package crowd.ok_impl.rest_api 
{
	import crowd.core.rest_api.AbstractRestApiInitializer;
	import crowd.ok_impl.soc_init_data.OdnoklassnikiInitData;
	import crowd.SocialTypes;
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class OdnoklassnikiRestApiInitializer extends AbstractRestApiInitializer 
	{
		private var _initData:OdnoklassnikiInitData;
		
		public function OdnoklassnikiRestApiInitializer(initData:OdnoklassnikiInitData) 
		{
			super(_initData);
			_initData = initData;
		}
		
		
		
		override public function get soc_type():String 
		{
			return SocialTypes.ODNOKLASSNIKI;
		}
		
	}

}