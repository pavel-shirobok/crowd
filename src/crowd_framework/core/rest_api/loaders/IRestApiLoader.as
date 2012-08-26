package crowd_framework.core.rest_api.loaders 
{
	import crowd_framework.core.ISocialType;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
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