package crowd_framework.core.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class SystemErrorEvent extends Event 
	{
		private var _detail:String;
		
		public static const ERROR:String = "SystemErrorEvent-ERROR";
		
		public static const DETAIL_IO_ERROR:String = "SystemErrorEvent-IO_ERROR";
		public static const DETAIL_SECURITY_ERROR:String = "SystemErrorEvent-SECURITY_ERROR";
		public static const DETAIL_INVALID_DATA_FORMAT:String = "SystemErrorEvent-INVALID_DATA_FORMAT";
		
		public function SystemErrorEvent(detail:String) 
		{ 
			super(ERROR);
			_detail = detail;
		}
		
		public override function clone():Event 
		{ 
			return new SystemErrorEvent(detail);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SystemErrorEvent", "type"); 
		}
		
		public function get detail():String 
		{
			return _detail;
		}
		
	}
	
}