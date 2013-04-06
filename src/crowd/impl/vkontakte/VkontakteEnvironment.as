package crowd.impl.vkontakte
{
	import com.ramshteks.as3.StringUtils;
	import crowd.core.environment.ISocialData;
	import com.adobe.crypto.MD5;
	import com.ramshteks.as3.vars_holder.IVarsHolder;
	import crowd.core.environment.ICrowdEnvironmentInitializer;
	import crowd.core.permissions.ISocialPermissions;
	import crowd.core.request_builder.IRequestBuilder;
	import crowd.core.js_api.IJSApi;
	import crowd.SocialTypes;
	import crowd.utils.formatter.IFormatter;
	import crowd.utils.formatter.XMLFormatter;
	import crowd.utils.NetUtil;
	import crowd.utils.Param;
	import crowd.impl.vkontakte.VkontaktePermissions;
	import crowd.impl.vkontakte.VkontakteInitData;
	import flash.errors.IllegalOperationError;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author 
	 */
	public class VkontakteEnvironment implements ICrowdEnvironmentInitializer, IRequestBuilder, ISocialData, ISocialPermissions
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
		
		private var _permissionsMap:Array = initPermissionsMap();
		
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
			return formatter.getString(Param.fromObject({sid:_sid, secret:_secret, viewer_id:_user_id}));
		}
		
		public function getAPIRequest(params:Object):URLRequest 
		{
			var n_params:Object = getStandardParams();// .concat(Param.fromObject(params));
			
			for (var key:String in params) {
				n_params[key] = params[key];
			}
			
			var sig:String = NetUtil.getSignature(n_params, _user_id, _secret);
			
			n_params["sig"] = sig;
			n_params["sid"] = _sid;
			var req_vars:URLVariables = new URLVariables();
			
			Param.copyObjectToUrlVariables(n_params, req_vars);
			
			var req:URLRequest = NetUtil.getPostURLRequest(_api_url);
			req.data = req_vars;

			return req;
		}
		
		private function getStandardParams():Object {
			return {v:"3.0",format:formatFromInitData(), api_id:_application_id};
		}
		
		private function formatFromInitData():String {
			return _initData.rest_api_format.toUpperCase();
		}
		
		public function getAuthVariables():URLVariables 
		{
			return new URLVariables(StringUtils.printf("uid=%uid%&auth_key=%key%&soc_type=%type%", _user_id, _auth_key, SocialTypes.VKONTAKTE));// "uid=" + _user_id + "&auth_key=" + _auth_key + "&soc_type=" + );
		}
		
		////////////////////////////////////////////////////////////////
		//{ Permissions
		////////////////////////////////////////////////////////////////
		
		public function check(...permissions:Array):Boolean 
		{
			var flag:int = getPermissionFlags();
			
			var result:Boolean = true;
			
			for each(var perm_req:String in permissions) {
				var req_flag:int = _permissionsMap.indexOf(perm_req);
				if (req_flag == -1) throw new IllegalOperationError("Unknow permission flag '" + perm_req + "'");
				
				if ((flag & req_flag) == 0) {
					result = false;
					break;
				}
			}
			
			return result;
		}
		
		public function get allowed():Array 
		{
			var flag:int = getPermissionFlags();
			var allowed:Array = [];
			
			for (var flag_in_map:String in _permissionsMap) {
				var str_flag:String = _permissionsMap[flag_in_map];
				var flag_in_map_int:int = int(parseInt(flag_in_map));
				if ((flag & flag_in_map_int) != 0) {
					allowed.push(str_flag);
				}
			}
			
			return allowed;
		}
		
		public function get permissions():ISocialPermissions 
		{
			return this;
		}
		
		private function getPermissionFlags():int 
		{
			var permissions_flag_string:String = flash_vars.getVar("api_settings");
			return parseInt(permissions_flag_string);
		}
		
		private function initPermissionsMap():Array {
			var map:Array = [];
			
			map[0x000001] = VkontaktePermissions.NOTICE;
			map[0x000002] = VkontaktePermissions.FRIENDS;
			map[0x000004] = VkontaktePermissions.PHOTO;
			map[0x000008] = VkontaktePermissions.AUDIO;
			map[0x000010] = VkontaktePermissions.VIDEO;
			map[0x000020] = VkontaktePermissions.OFFER;
			map[0x000040] = VkontaktePermissions.QUESTIONS;
			map[0x000080] = VkontaktePermissions.WIKI;
			map[0x000100] = VkontaktePermissions.ADDING_LINK_TO_LEFT_MENU;
			map[0x000200] = VkontaktePermissions.ADDING_LINK_TO_USERS_WALLS;
			map[0x000400] = VkontaktePermissions.USER_STATUSES;
			map[0x000800] = VkontaktePermissions.NOTE;
			map[0x002000] = VkontaktePermissions.EXTENDED_WALLS_METHODS;
			map[0x008000] = VkontaktePermissions.ADVERT_CABINET;
			map[0x020000] = VkontaktePermissions.DOCUMENT;
			map[0x040000] = VkontaktePermissions.GROUPS;
			map[0x080000] = VkontaktePermissions.ANSWER_NOTICE;
			map[0x100000] = VkontaktePermissions.STATISTICS;
			
			return map;
		}
		//}
		
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