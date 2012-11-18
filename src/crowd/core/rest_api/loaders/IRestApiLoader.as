package crowd.core.rest_api.loaders
{
	import crowd.core.ISocialType;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")] 
	[Event(name="ioError", type="flash.events.IOErrorEvent")] 
	[Event(name="progress", type="flash.events.ProgressEvent")] 
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="APIErrorEvent-API_ERROR", type="crowd.core.events.RestApiErrorEvent")]
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface IRestApiLoader extends IEventDispatcher, ISocialType
	{
		function load(req:URLRequest):void;
		function get request():URLRequest;
		function get data():*;
	}
	
}