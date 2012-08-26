package crowd_framework.core.js_api 
{
	import crowd_framework.core.events.JSApiCallbackEvent;
	import crowd_framework.core.events.JSApiErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class AbstractJSApiDispatcher extends EventDispatcher 
	{
		
		protected final function dispatchSuccessConnect():void {
			dispatchEvent(new Event(Event.CONNECT));
		}
		
		protected final function dispatchConnectionError(message:String):void {
			dispatchEvent(new JSApiErrorEvent(JSApiErrorEvent.CONNECT_FAILED, message));
		}
		
		protected final function dispatchCallError(message:String):void {
			dispatchEvent(new JSApiErrorEvent(JSApiErrorEvent.CALL_FAILED, message));
		}
		
		protected final function dispatchCallback(callBackName:String, params:Object):void {
			dispatchEvent(new JSApiCallbackEvent(JSApiCallbackEvent.CALLBACK, callBackName, params));
		}
		
		
	}

}