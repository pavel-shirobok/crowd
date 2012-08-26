package crowd_framework.core.events 
{

	import crowd_framework.core.rest_api.IRestApiErrorReport;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class RestApiErrorEvent extends Event 
	{
		private var _apiError:IRestApiErrorReport;
		public static const API_ERROR:String = "APIErrorEvent-API_ERROR";
		public function RestApiErrorEvent(type:String, apiError:IRestApiErrorReport) 
		{ 
			super(type);
			_apiError = apiError;			
		} 
		
		public override function clone():Event 
		{ 
			return new RestApiErrorEvent(type, _apiError);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("APIErrorEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get apiError():IRestApiErrorReport 
		{
			return _apiError;
		}
		
	}
	
}