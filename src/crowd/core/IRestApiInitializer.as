package crowd.core
{
	public interface IRestApiInitializer extends IRestApi
	{
		function setSynchronizer(sync:RestApiSynchronizer):void
		function setEnvironment(env:ICrowdEnvironment):void;
	}
}