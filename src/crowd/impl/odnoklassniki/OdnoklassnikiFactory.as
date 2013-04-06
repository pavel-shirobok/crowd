package crowd.impl.odnoklassniki
{
	import com.ramshteks.as3.vars_holder.IVarsHolder;
	import crowd.core.environment.ICrowdEnvironmentInitializer;
	import crowd.core.js_api.IJSApi;
	import crowd.core.rest_api.IRestApiInitializer;
	import crowd.core.soc_factory.ISocialFactory;
	import crowd.impl.odnoklassniki.OdnoklassnikiEnvironment;
	import crowd.impl.odnoklassniki.OdnoklassnikiJSApi;
	import crowd.impl.odnoklassniki.OdnoklassnikiRestApiInitializer;
	import crowd.impl.odnoklassniki.OdnoklassnikiInitData;
	import crowd.SocialTypes;
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class OdnoklassnikiFactory implements ISocialFactory
	{
		private var _initData:OdnoklassnikiInitData;
		private var _flash_vars:IVarsHolder;
		
		public function OdnoklassnikiFactory(initData:OdnoklassnikiInitData, flash_vars:IVarsHolder)
		{
			_flash_vars = flash_vars;
			_initData = initData;
		}
		
		public function getEnvironmentInitializer():ICrowdEnvironmentInitializer 
		{
			return new OdnoklassnikiEnvironment(_initData);
		}
		
		public function getJSApi():IJSApi 
		{
			return new OdnoklassnikiJSApi();
		}
		
		public function getJSApiInitParams():* 
		{
			return [_flash_vars.getVar("apiconnection")];
		}
		
		public function getRestApiInitializer():IRestApiInitializer 
		{
			return new OdnoklassnikiRestApiInitializer(_initData);
		}
		
		public function get soc_type():String 
		{
			return SocialTypes.ODNOKLASSNIKI;
		}
		
	}

}