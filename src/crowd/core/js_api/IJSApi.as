package crowd.core.js_api
{
	import crowd.core.ISocialType;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface IJSApi extends ISocialType, IEventDispatcher
	{
		function init(...param):void;
		function call(methodName:String, ...params:Array):*;
	}
	
}