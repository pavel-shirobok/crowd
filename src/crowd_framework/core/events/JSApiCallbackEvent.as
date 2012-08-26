package crowd_framework.core.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class JSApiCallbackEvent extends Event 
	{
		private var _methodName:String;
		private var _params:Object;
		public static const CALLBACK:String = "SJSCallbackEvent-CALLBACK";
		
		public function JSApiCallbackEvent(type:String, methodName:String, params:Object) 
		{ 
			super(type);
			_params = params;
			_methodName = methodName;
		} 
		
		public override function clone():Event 
		{ 
			return new JSApiCallbackEvent(type, methodName, params);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SJSCallbackEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get methodName():String 
		{
			return _methodName;
		}
		
		public function get params():Object 
		{
			return _params;
		}
		
	}
	
}