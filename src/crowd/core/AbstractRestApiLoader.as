package crowd.core
{
	import crowd.events.RestApiErrorEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;

	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class AbstractRestApiLoader extends EventDispatcher implements IRestApiLoader
	{
		private var _soc_type:String;
		private var _synchronizer:RestApiSynchronizer;
		private var _req:URLRequest;
		private var _initData:ICrowdInitData;
		
		public function AbstractRestApiLoader(synchronizer:RestApiSynchronizer, initData:ICrowdInitData):void {
			_initData = initData;
			_synchronizer = synchronizer;
			_soc_type = initData.soc_type;
		}
		
		protected function dispatchComplete():void {
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function dispatchApiError(apiError:IRestApiErrorReport):void {
			dispatchEvent(new RestApiErrorEvent(RestApiErrorEvent.API_ERROR, apiError));
		}
		
		public function load(req:URLRequest):void 
		{
			_req = req;
			addEventListener(Event.SELECT, onSelectLoader)
			_synchronizer.putInQueue(this);
		}
		
		protected function onSelectLoader(e:Event):void 
		{
			removeEventListener(Event.SELECT, onSelectLoader);
			realLoad(request);
		}
		
		protected function realLoad(req:URLRequest):void 
		{
			throw new Error("need to implement")
		}
		
		public function get data():* 
		{
			throw new Error("need to implement")
		}
		
		public function get soc_type():String 
		{
			return _soc_type;
		}
		
		public function get request():URLRequest 
		{
			return _req;
		}
	}

}