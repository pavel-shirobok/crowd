package crowd.core.rest_api.loaders
{
	import crowd.core.rest_api.IRestApiErrorReport;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class RestApiErrorReport implements IRestApiErrorReport 
	{
		private var _params:Array = [];
		private var _message:String;
		private var _code:int;
		private var _soc_type:String;
		private var _format:String;
		private var _rawError:String;
		
		public function RestApiErrorReport(soc_type:String, format:String, rawError:String, code:int, message:String) 
		{
			_rawError = rawError;
			_message = message;
			_code = code;
			_format = format;
			_soc_type = soc_type;
			
		}
		
		public function get code():int 
		{
			return _code;
		}
		
		public function get message():String 
		{
			return _message;
		}
		
		public function get params():Array 
		{
			return _params;
		}
		
		public function toString():String 
		{
			var str:String = "Report soc_type='" + soc_type + "'\n";
			str += "format = '" + format + "'\n";
			str += "code = '" + code + "'\n";
			str += "message = '" + message + "'\n";
			str += "params: \n";
			for (var key:String in params) {
				str += " * '" + key + "' = '" + params[key] + "'\n";
			}
			
			return str;
		}
		
		public function get rawErrorString():String 
		{
			return _rawError;
		}
		
		public function get format():String 
		{
			return _format;
		}
		
		public function get soc_type():String 
		{
			return _soc_type;
		}
		
	}

}