package crowd.core
{
	import crowd.core.ICrowdEnvironmentInitializer;
	import crowd.core.ISocialType;
	import crowd.core.IJSApi;
	import crowd.core.IRestApiInitializer;
	
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