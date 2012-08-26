package crowd_framework.vk_impl.environment 
{
	import com.ramshteks.as3.StringUtils;
	import crowd_framework.core.environment.ISocialData;
	import com.adobe.crypto.MD5;
	import com.ramshteks.as3.vars_holder.IVarsHolder;
	import crowd_framework.core.environment.ICrowdEnvironmentInitializer;
	import crowd_framework.core.request_builder.IRequestBuilder;
	import crowd_framework.core.js_api.IJSApi;
	import crowd_framework.SocialTypes;
	import crowd_framework.utils.formatter.IFormatter;
	import crowd_framework.utils.formatter.XMLFormatter;
	import crowd_framework.utils.NetUtil;
	import crowd_framework.utils.Param;
	import crowd_framework.vk_impl.soc_init_data.VkontakteInitData;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author 
	 */
	public class VkontakteEnvironment implements ICrowdEnvironmentInitializer, IRequestBuilder, ISocialData
	{
		//ISocialData
		private var _api_url:String;
		private var _application_id:String;
		private var _user_id:String;
		private var _referrer:String;
		
		//Vk specified
		private var _secret:String;
		private var _auth_key:String;
		private var _sid:String;
		
		private var _initData:VkontakteInitData;
		
		private var _flashVarsHolder:IVarsHolder;
		
		//JS API
		private var _javaScript:IJSApi;
		
		public function VkontakteEnvironment(initData:VkontakteInitData) 
		{
			_initData = initData;
		}
		
		public function setJSApi(js_api:IJSApi):void 
		{
			_javaScript = js_api;
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
		
		public function setFlashVarsHolder(vars:IVarsHolder):void 
		{
			_flashVarsHolder = vars;
			
			_application_id = vars.getVar("api_id");
			_api_url = vars.getVar("api_url");
			
			_user_id = vars.getVar("viewer_id");
			_sid = vars.getVar("sid");
			_secret = vars.getVar("secret");
			_referrer = vars.getVar("referrer");
			
			var private_key:String = vars.getVar("private_key");
			if (private_key != "") {
				_auth_key = MD5.hash(_application_id + "_" + _user_id + "_" + private_key);
			}else {
				_auth_key = vars.getVar("auth_key");
			}
		}
		
		public function get request_builder():IRequestBuilder 
		{
			
			return this as IRequestBuilder;
		}
		
		public function get js_api():IJSApi 
		{
			return _javaScript as IJSApi;
		}
		
		public function get social_data():ISocialData 
		{
			return this as ISocialData;
		}
		
		public function get soc_type():String 
		{
			return SocialTypes.VKONTAKTE;
		}
		
		public function getLocalData(formatter:IFormatter = null):String 
		{
			if (formatter == null) formatter = new XMLFormatter();
			return formatter.getString([new Param("sid", _sid), new Param("secret", _secret), new Param("viewer_id", _user_id)]);
		}
		
		public function getAPIRequest(params:Object):URLRequest 
		{
			
			var req:URLRequest = NetUtil.getPostURLRequest(_api_url);
			
			var n_params:Array = getStandardParams().concat(Param.fromObject(params));
			
			var sig:String = NetUtil.getSignature(n_params, _user_id, _secret);
			
			n_params.push(new Param("sig", sig));
			n_params.push(new Param("sid", _sid));
			
			req.data = new URLVariables(n_params.join("&"));
			
			return req;
		}
		
		private function getStandardParams():Array {
			return [new Param("v", "3.0"), new Param("format", "XML"),new Param("api_id", _application_id)];
		}
		
		public function getAuthVariables():URLVariables 
		{
			return new URLVariables(StringUtils.printf("uid=%uid%&auth_key=%key%&soc_type=%type%", _user_id, _auth_key, SocialTypes.VKONTAKTE));// "uid=" + _user_id + "&auth_key=" + _auth_key + "&soc_type=" + );
		}
		
		public function get flash_vars():IVarsHolder 
		{
			return _flashVarsHolder;
		}
		
		public function get socialData():ISocialData 
		{
			return this as ISocialData;
		}
		
		public function get javascriptApi():IJSApi 
		{
			return _javaScript as IJSApi;
		}
		
		public function get flashVars():IVarsHolder 
		{
			return _flashVarsHolder;
		}
		
	}
}