package crowd.ok_impl.js_api 
{
	import crowd.core.js_api.AbstractJSApiDispatcher;
	import crowd.core.js_api.IJSApi;
	import crowd.SocialTypes;
	import flash.events.AsyncErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class OdnoklassnikiJSApi extends AbstractJSApiDispatcher implements IJSApi
	{
		
		private var _lc:LocalConnection;
		private var _connectionName:String;
		private const NAME_PREFIX:String = "_api_";
		private const PROXY_PREFIX:String = "_proxy_"
		
		public function OdnoklassnikiJSApi() 
		{
			//super();
		}
		
		public function init(...flash_vars):void 
		{
			var var_name:String = "apiconnection";
			if (flash_vars[0] == null) {
				dispatchConnectionError("incorrect arguments: flash vars object equals null");
				return;
			}
			var fl_vars:Object = flash_vars[0];
			if (fl_vars[var_name] == undefined) {
				dispatchConnectionError("incorrect arguments: _connection name specified as 'undefined'");
				return;
			}
			
			_connectionName = fl_vars[var_name];

			try{
				_lc = new LocalConnection();
				_lc.allowDomain("*");
				_lc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecError);
				_lc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
				_lc.addEventListener(StatusEvent.STATUS, onStatus);
				
				_lc.client = getClientObject();
				
				_lc.connect(NAME_PREFIX + _connectionName);
			}catch (e:Error) {
				dispatchConnectionError("init local connection error with message:" + e.message);
			}
		}
		
		private function onStatus(e:StatusEvent):void 
		{
			//trace(e);
			if (e.level != StatusEvent.STATUS) {
				dispatchConnectionError("recieved non-status level in onStatus handler");
			}
		}
		
		private function onAsyncError(e:AsyncErrorEvent):void 
		{
			dispatchConnectionError("recieved AsyncErrorEvent: " + e.error?e.error.message:e.text);
		}
		
		private function onSecError(e:SecurityErrorEvent):void 
		{
			dispatchConnectionError("recieved security error " + e.text);
		}
		
		public function call(methodName:String, ...params:Array):* 
		{
			try{
				_lc.send(PROXY_PREFIX + _connectionName, methodName, params);
			}catch (exc:Error) {
				dispatchCallError("call method was excepted with message: " + exc.message + " and id: " + exc.errorID);
			}
		}
		
		public function get soc_type():String 
		{
			return SocialTypes.ODNOKLASSNIKI;
		}
		
		private function establishConnection():void {
			dispatchSuccessConnect();
		}
		
		private function callback(callbackName:String, methodName:String, result:String, params:String):void {
			//Alert.show("cb:"+callbackName+params.toString());
			dispatchCallback(callbackName, params);
		}
		
		private var _clientObject:Object = null;
		private function getClientObject():Object {
			if (_clientObject == null) {
				_clientObject = {
					establishConnection:establishConnection,
					
					apiCallBack: function(methodName:String, result:String, params:String):void {
						callback("apiCallBack", methodName, result, params);
					}
				};
			}
			return _clientObject;
		}
		
	}

}