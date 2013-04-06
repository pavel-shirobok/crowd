package crowd.impl.odnoklassniki
{
	import crowd.core.rest_api.AbstractRestApiInitializer;
	import crowd.impl.odnoklassniki.OdnoklassnikiInitData;
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