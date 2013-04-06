package crowd.impl.odnoklassniki
{
	import crowd.SocialTypes;
	import crowd.core.AbstractRestApiInitializer;

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