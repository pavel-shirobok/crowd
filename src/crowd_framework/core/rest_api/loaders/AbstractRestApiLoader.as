package crowd_framework.core.rest_api.loaders 
{
	import crowd_framework.core.events.RestApiErrorEvent;
	import crowd_framework.core.events.SystemErrorEvent;
	import crowd_framework.core.rest_api.IRestApiErrorReport;
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
		public function AbstractRestApiLoader(soc_type:String):void {
			_soc_type = soc_type;
		}
		
		protected function dispatchComplete():void {
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function dispatchSystemError(detail:String):void {
			dispatchEvent(new SystemErrorEvent(detail))
		}
		
		protected function dispatchApiError(apiError:IRestApiErrorReport):void {
			dispatchEvent(new RestApiErrorEvent(RestApiErrorEvent.API_ERROR, apiError));
		}
		
		public function load(req:URLRequest):void 
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
	}

}