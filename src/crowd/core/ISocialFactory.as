package crowd.core
{
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