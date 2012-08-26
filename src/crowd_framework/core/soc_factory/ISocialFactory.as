package crowd_framework.core.soc_factory 
{
	import crowd_framework.core.environment.ICrowdEnvironmentInitializer;
	import crowd_framework.core.ISocialType;
	import crowd_framework.core.js_api.IJSApi;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface ISocialFactory extends ISocialType
	{
		function getEnvironmentInitializer():ICrowdEnvironmentInitializer;
		function getJSApi():IJSApi;
		function getJSApiInitParams():*;
	}
	
}