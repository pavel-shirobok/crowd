package crowd.impl.odnoklassniki
{
	import com.ramshteks.as3.vars_holder.IVarsHolder;

	import crowd.SocialTypes;
	import crowd.core.ICrowdEnvironmentInitializer;
	import crowd.core.IJSApi;
	import crowd.core.IRequestBuilder;
	import crowd.core.ISocialData;
	import crowd.core.ISocialPermissions;
	import crowd.utils.Param;
	import crowd.utils.formatter.IFormatter;
	import crowd.utils.formatter.XMLFormatter;

	import flash.net.URLRequest;
	import flash.net.URLVariables;

	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class OdnoklassnikiEnvironment  implements ICrowdEnvironmentInitializer, IRequestBuilder, ISocialData , ISocialPermissions
	{
		private var _init:OdnoklassnikiInitData;
		private var _flash_vars:IVarsHolder;
		private var _js_api:IJSApi;
		
		private var _application_key:String;
		private var _logged_user_id:String;
		private var _api_server:String;
		private var _session_key:String;
		private var _session_secret_key:String;
		private var _referrer:String;
		private var _auth_sig:String;
		private var _sig:String;
		
		public function OdnoklassnikiEnvironment(init:OdnoklassnikiInitData) 
		{
			_init = init;
		}
		
		public function setJSApi(js_api:IJSApi):void 
		{
			_js_api = js_api;
		}
		
		public function setFlashVarsHolder(vars:IVarsHolder):void 
		{
			_application_key = vars.getVar("application_key");
			
			_logged_user_id = vars.getVar("logged_user_id");
			_session_key = vars.getVar("session_key");
			_session_secret_key = vars.getVar("session_secret_key");
			_referrer = vars.getVar("referer");
			_auth_sig = vars.getVar("auth_sig");
			_sig = vars.getVar("sig");	
			_flash_vars = vars;
		}
		
		public function getAPIRequest(params:Object):URLRequest 
		{
			return null;
		}
		
		public function getAuthVariables():URLVariables 
		{
			return null;
		}
		
		public function get application_id():String 
		{
			return _application_key;
		}
		
		public function get user_id():String 
		{
			return _logged_user_id;
		}
		
		public function get referrer():String 
		{
			return _referrer;
		}
		
		public function get api_url():String 
		{
			return _api_server;
		}
		
		public function getLocalData(formatter:IFormatter = null):String 
		{
			if (formatter == null) formatter = new XMLFormatter();
			return formatter.getString([Param.fromRaw("session_key", _session_key), 
										Param.fromRaw("session_secret_key", _session_secret_key), 
										Param.fromRaw("auth_sig", _auth_sig),
										Param.fromRaw("sig", _sig)]);
		}
		
		public function get allowed():Array 
		{
			return null;
		}
		
		public function check(...permissions:Array):Boolean 
		{
			return false;
		}
		
		public function get request_builder():IRequestBuilder 
		{
			return this as IRequestBuilder;
		}
		
		public function get js_api():IJSApi 
		{
			return _js_api;
		}
		
		public function get social_data():ISocialData 
		{
			return this as ISocialData;
		}
		
		public function get flash_vars():IVarsHolder 
		{
			return _flash_vars;
		}
		
		public function get permissions():ISocialPermissions 
		{
			return this as ISocialPermissions;
		}
		
		public function get soc_type():String 
		{
			return SocialTypes.ODNOKLASSNIKI;
		}
		
	}

}