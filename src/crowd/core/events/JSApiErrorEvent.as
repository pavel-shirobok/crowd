package crowd.core.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class JSApiErrorEvent extends Event 
	{
		private var _message:String;
		
		public static const CONNECT_FAILED:String = "SJSErrorEvent-CONNECT_FAILED";
		static public const CALL_FAILED:String = "SJSErrorEvent-CALL_FAILED";
		
		public function JSApiErrorEvent(type:String, message:String) 
		{ 
			super(type);
			_message = message;
			
		} 
		
		public override function clone():Event 
		{ 
			return new JSApiErrorEvent(type, message);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SJSErrorEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get message():String 
		{
			return _message;
		}
		
	}
	
}