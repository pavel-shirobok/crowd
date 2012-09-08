package crowd_framework.mailru_impl.rest_api 
{
	import crowd_framework.core.rest_api.IRestApiErrorReport;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class MailRuRestApiErrorReport implements IRestApiErrorReport 
	{
		private var _code:int;
		private var _message:String;
		private var _params:Array;
		private var _format;
		private var _rawErrorString;
		private var _soc_type;
		
		public function MailRuRestApiErrorReport(error_answer:String) 
		{
			//TODO make
			/*var xml:XML = new XML(error_answer);
			_code = int(xml.error_code);
			_message = String(xml.error_msg);
			_params = new Array();*/
		}
		
		/* INTERFACE crowd_framework.core.rest_api.IRestApiErrorReport */
		
		public function toString():String 
		{
			throw new Error("No implementation yet")
		}
		
		/* INTERFACE crowd_framework.core.rest_api.IRestApiErrorReport */
		
		public function get format():String 
		{
			return _format;
		}
		
		public function get rawErrorString():String 
		{
			return _rawErrorString;
		}
		
		public function get soc_type():String 
		{
			return _soc_type;
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
		
	}

}