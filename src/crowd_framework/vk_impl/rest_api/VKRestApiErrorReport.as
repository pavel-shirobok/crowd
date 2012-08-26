package crowd_framework.vk_impl.rest_api 
{
	import crowd_framework.core.rest_api.IRestApiErrorReport;
	import crowd_framework.utils.Param;
	import ramshteks.as3.utils.data.Param;
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class VKRestApiErrorReport implements IRestApiErrorReport 
	{
		private var _code:int;
		private var _message:String;
		private var _params:Array;
		
		public function VKRestApiErrorReport(xml:XML) 
		{
			_code = int(xml.error_code);
			_message = String(xml.error_msg);
			_params = new Array();
			
			for each(var p:XML in xml.request_params.*) {
				_params.push(new Param(String(p.key), String(p.value)));
			}
		}
		
		public function get params():Array 
		{
			return _params;
		}
		
		public function get code():int 
		{
			return _code;
		}
		
		public function get message():String 
		{
			return _message;
		}
		
	}

}