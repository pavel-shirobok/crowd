package crowd.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class LogEvent extends Event 
	{
		private var _message:String;
		public static const LOG_MESSAGE:String = "log_message";
		
		public function LogEvent(type:String, message:String) 
		{ 
			super(type, bubbles, cancelable);
			_message = message;
			
		} 
		
		public override function clone():Event 
		{ 
			return new LogEvent(type, message);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LogEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get message():String 
		{
			return _message;
		}
		
	}
	
}