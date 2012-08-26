package crowd_framework.core.rest_api 
{
	import crowd_framework.core.rest_api.loaders.IRestApiLoader;
	import crowd_framework.core.environment.ICrowdEnvironment;
	import crowd_framework.core.rest_api.syncronizer.RestApiSynchronizer;
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class AbstractRestApiInitializer implements IRestApiInitializer 
	{
		private var _synchronizer:RestApiSynchronizer;
		private var _environment:ICrowdEnvironment;
		
		public function AbstractRestApiInitializer(){}
		
		public function setSynchronizer(sync:RestApiSynchronizer):void 
		{
			_synchronizer = sync;
		}
		
		public function setEnvironment(env:ICrowdEnvironment):void 
		{
			_environment = env;
		}
		
		public function getLoader():IRestApiLoader 
		{
			throw new Error("need to implement")
		}
		
		public function get soc_type():String 
		{
			throw new Error("need to implement")
		}
		
		protected function get synchronizer():RestApiSynchronizer 
		{
			return _synchronizer;
		}
		
		protected function get environment():ICrowdEnvironment 
		{
			return _environment;
		}
		
	}

}