package crowd.ok_impl.soc_factory 
{
	import com.ramshteks.as3.vars_holder.IVarsHolder;
	import crowd.core.environment.ICrowdEnvironmentInitializer;
	import crowd.core.js_api.IJSApi;
	import crowd.core.rest_api.IRestApiInitializer;
	import crowd.core.soc_factory.ISocialFactory;
	import crowd.ok_impl.environment.OdnoklassnikiEnvironment;
	import crowd.ok_impl.js_api.OdnoklassnikiJSApi;
	import crowd.ok_impl.rest_api.OdnoklassnikiRestApiInitializer;
	import crowd.ok_impl.soc_init_data.OdnoklassnikiInitData;
	import crowd.SocialTypes;
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class OKFactory implements ISocialFactory 
	{
		private var _initData:OdnoklassnikiInitData;
		private var _flash_vars:IVarsHolder;
		
		public function OKFactory(initData:OdnoklassnikiInitData, flash_vars:IVarsHolder) 
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