package crowd_framework.core.soc_factory 
{
	import crowd_framework.core.environment.ICrowdEnvironmentInitializer;
	import crowd_framework.core.ISocialType;
	import crowd_framework.core.js_api.IJSApi;
	import crowd_framework.core.rest_api.IRestApiInitializer;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface ISocialFactory extends ISocialType
	{
		function getEnvironmentInitializer():ICrowdEnvironmentInitializer;
		function getJSApi():IJSApi;
		function getJSApiInitParams():*;
		function getRestApiInitializer():IRestApiInitializer;
	}
	
}