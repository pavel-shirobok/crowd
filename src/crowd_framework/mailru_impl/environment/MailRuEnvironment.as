package crowd_framework.mailru_impl.environment 
{
	import com.ramshteks.as3.StringUtils;
	import com.ramshteks.as3.vars_holder.IVarsHolder;
	import crowd_framework.core.environment.ICrowdEnvironmentInitializer;
	import crowd_framework.core.environment.ISocialData;
	import crowd_framework.core.js_api.IJSApi;
	import crowd_framework.core.permissions.ISocialPermissions;
	import crowd_framework.core.request_builder.IRequestBuilder;
	import crowd_framework.mailru_impl.soc_init_data.MailRuInitData;
	import crowd_framework.SocialTypes;
	import crowd_framework.utils.formatter.IFormatter;
	import crowd_framework.utils.formatter.XMLFormatter;
	import crowd_framework.utils.NetUtil;
	import crowd_framework.utils.Param;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author 
	 */
	public class MailRuEnvironment implements ICrowdEnvironmentInitializer, IRequestBuilder, ISocialData , ISocialPermissions
	{
		private var _initData:MailRuInitData;
		
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
		
		public function MailRuEnvironment(init:MailRuInitData) 
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
			var req:URLRequest = NetUtil.getPostURLRequest(_api_url);
			
			var n_params:Array = getStandardParams().concat(Param.fromObject(params));
			
			var sig:String = NetUtil.getSignature(n_params,_user_id, _initData.secret);
			
			n_params.push(new Param("sig", sig));
			
			req.data = new URLVariables(n_params.join("&"));
			return req;
		}
		
		private function getStandardParams():Array 
		{
			return [new Param("format", "xml"),new Param("app_id", _application_id), new Param("session_key", _session_key)];
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