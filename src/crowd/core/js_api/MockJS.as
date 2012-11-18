package crowd.core.js_api
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class MockJS extends EventDispatcher implements IJSApi 
	{
		private var _soc_type:String;
		
		public function MockJS(soc_type:String) 
		{
			_soc_type = soc_type;
		}
		
		public function init(...param):void 
		{
			trace("init", param.join(" p:"));
		}
		
		public function call(methodName:String, ...params:Array):* 
		{
			trace("MockJS call:", methodName, params);
		}
		
		/* INTERFACE crowd.core.js_api.IJSApi */
		
		public function get soc_type():String 
		{
			return _soc_type;
		}

	}

}