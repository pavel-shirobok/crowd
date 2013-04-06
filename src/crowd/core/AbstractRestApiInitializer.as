package crowd.core
{
	import crowd.core.rest_api.*;
	import crowd.core.ICrowdEnvironment;
	import crowd.core.IRestApiLoader;
	import crowd.core.RestApiSynchronizer;
	import crowd.core.ICrowdInitData;
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class AbstractRestApiInitializer implements IRestApiInitializer 
	{
		private var _synchronizer:RestApiSynchronizer;
		private var _environment:ICrowdEnvironment;
		private var _initData:ICrowdInitData;
		
		public function AbstractRestApiInitializer(initData:ICrowdInitData){
			_initData = initData;
		}
		
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
		
		public function get defaultFormat():String 
		{
			return _initData.rest_api_format;
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
		
		protected function get initData():ICrowdInitData 
		{
			return _initData;
		}
		
	}

}