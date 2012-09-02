package crowd_framework.core.rest_api 
{
	import crowd_framework.core.environment.ICrowdEnvironment;
	import crowd_framework.core.rest_api.synchronizer.RestApiSynchronizer;
	
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