package crowd.impl.mailru
{
	import com.ramshteks.as3.StringUtils;
	import com.ramshteks.as3.vars_holder.IVarsHolder;

	import crowd.SocialTypes;
	import crowd.core.ICrowdEnvironmentInitializer;
	import crowd.core.IJSApi;
	import crowd.core.IRequestBuilder;
	import crowd.core.ISocialData;
	import crowd.core.ISocialPermissions;
	import crowd.utils.NetUtil;
	import crowd.utils.Param;
	import crowd.utils.formatter.IFormatter;
	import crowd.utils.formatter.XMLFormatter;

	import flash.net.URLRequest;
	import flash.net.URLVariables;

	/**
	 * ...
	 * @author 
	 */
	public class MailruEnvironment implements ICrowdEnvironmentInitializer, IRequestBuilder, ISocialData , ISocialPermissions
	{
		private var _initData:MailruInitData;
		
		private var _application_id:String;
		private var _user_id:String;
		private var _referrer:String;
		
		private var _window_id:String;
		private var _api_url:String = "http://www.appsmail.ru/platform/api";
		private var _session_key:String;
		private var _sig:String;
		private var _is_app_user:String;
		
		private var _javascript:IJSApi;
		
		private var _flashVarsHolder:IVarsHolder;
		
		public function MailruEnvironment(init:MailruInitData)
		{
			_initData = init;
		}
		
		public function setJSApi(js_api:IJSApi):void 
		{
			_javascript = js_api;
		}
		
		public function setFlashVarsHolder(vars:IVarsHolder):void {
			_application_id = vars.getVar("app_id");
			_is_app_user = vars.getVar("is_app_user");
			_referrer = vars.getVar("referer_type");
			_window_id = vars.getVar("window_id");
			
			_user_id = vars.getVar("vid");
			_session_key = vars.getVar("session_key");
			_sig = vars.getVar("sig");
			_flashVarsHolder = vars;
		}
		
		public function getAPIRequest(params:Object):URLRequest 
		{
			var n_params:Object = getStandardParams();
			
			for (var key:String in params) {
				n_params[key] = params[key];
			}
			
			var sig:String = NetUtil.getSignature(n_params, _user_id, _initData.secret);
			
			n_params["sig"] = sig;
			
			var req_vars:URLVariables = new URLVariables();
			
			Param.copyObjectToUrlVariables(n_params, req_vars);
			
			var req:URLRequest = NetUtil.getPostURLRequest(_api_url);
			req.data = req_vars;

			return req;
		}
		
		private function getStandardParams():Object 
		{
			return { app_id:"_application_id", format:formatFromInitData(), session_key:_session_key };
		}
		
		private function formatFromInitData():String {
			return _initData.rest_api_format.toUpperCase();
		}
		
		public function getAuthVariables():URLVariables 
		{
			var req_str:String = StringUtils.printf("soc_type=%s%&uid=%u%&auth=%a%", soc_type, _user_id, "TEST");//TODO выяснить что передавать
			return new URLVariables(req_str);
		}
		
		public function get socialData():ISocialData 
		{
			return this as ISocialData;
		}
		
		public function get application_id():String 
		{
			return _application_id;
		}
		
		public function get user_id():String 
		{
			return _user_id;
		}
		
		public function get referrer():String 
		{
			return _referrer;
		}
		
		public function get api_url():String 
		{
			return _api_url;
		}
		
		public function getLocalData(formatter:IFormatter = null):String 
		{
			if (formatter == null) formatter = new XMLFormatter();
			return formatter.getString([new Param("session_key", _session_key), new Param("sig", _sig), new Param("vid", _user_id)]);
		}
		
		public function check(...permissions:Array):Boolean 
		{
			var soc_permissions:Array = getPermissions();
			
			for each(var perm:String in permissions) {
				if (soc_permissions.indexOf(perm) == -1) return false;
			}
			
			return true;
		}
		
		private function getPermissions():Array 
		{
			return flash_vars.getVar("ext_perm").split(",");
		}
		
		public function get permissions():ISocialPermissions 
		{
			return this;
		}
		
		public function get allowed():Array 
		{
			return getPermissions();
		}
		
		public function get request_builder():IRequestBuilder 
		{
			return this as IRequestBuilder;
		}
		
		public function get js_api():IJSApi 
		{
			return _javascript as IJSApi;
		}
		
		public function get social_data():ISocialData 
		{
			return this as ISocialData;
		}
		
		public function get flash_vars():IVarsHolder 
		{
			return _flashVarsHolder;
		}
		
		public function get soc_type():String 
		{
			return SocialTypes.MAILRU;
		}
		
		public function get flashVars():IVarsHolder 
		{
			return _flashVarsHolder;
		}
		
	}

}