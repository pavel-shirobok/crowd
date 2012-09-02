package crowd_framework.core.rest_api.loaders 
{
	import crowd_framework.core.ISocialType;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")] 
	[Event(name="ioError", type="flash.events.IOErrorEvent")] 
	[Event(name="progress", type="flash.events.ProgressEvent")] 
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface IRestApiLoader extends IEventDispatcher, ISocialType
	{
		function load(req:URLRequest):void;
		function get data():*;
	}
	
}