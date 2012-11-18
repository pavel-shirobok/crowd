package crowd.core.rest_api
{
	import crowd.core.environment.ICrowdEnvironment;
	import crowd.core.rest_api.synchronizer.RestApiSynchronizer;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface IRestApiInitializer extends IRestApi
	{
		function setSynchronizer(sync:RestApiSynchronizer):void
		function setEnvironment(env:ICrowdEnvironment):void;
	}
	
}