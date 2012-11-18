package crowd.core.soc_factory
{
	import crowd.core.environment.ICrowdEnvironmentInitializer;
	import crowd.core.ISocialType;
	import crowd.core.js_api.IJSApi;
	import crowd.core.rest_api.IRestApiInitializer;
	
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