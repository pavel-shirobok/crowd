package crowd.impl.vkontakte
{
	import crowd.core.js_api.AbstractJSApiDispatcher;
	import crowd.core.js_api.IJSApi;
	import crowd.SocialTypes;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class VkontakteJSApi extends AbstractJSApiDispatcher implements IJSApi 
	{
		private var _sendingLC: LocalConnection;
		private var _connectionName: String;
		private var _receivingLC: LocalConnection;
		
		private var _isInited:Boolean = false;
		
		public function VkontakteJSApi() { };
		
		public function call(methodName:String, ...params):* {
			if (!_isInited) {
				dispatchCallError("Not inited connection");
				return;
			}
			
			try {
				var p:Array = params as Array;
				p.unshift(methodName);
				p.unshift("callMethod");
				p.unshift(in_name);
				_sendingLC.send.apply(null, p);
			}catch (e:Error) {
				dispatchCallError(e.message);
			}
		}
		
		public function init(...flashVars):void {
			if (_isInited) return;
			try{
				if (typeof(flashVars[0]) == 'string') {
					_connectionName = flashVars[0];
				} else {
					_connectionName = flashVars[0].lc_name;
				}
			}catch (e:Error) {
				dispatchConnectionError("incorrect arguments: " + flashVars);
				return;
			}
			
			
			if (_connectionName == null || _connectionName == "") {
				dispatchConnectionError("Connection name is not defined");
				return;
			}
			
			_sendingLC = getLocalConnection();
			_sendingLC.addEventListener(StatusEvent.STATUS, onInitStatus);
			_sendingLC.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			_receivingLC = getLocalConnection();
			_receivingLC.client = getClientObject();
			
			try {
				_receivingLC.connect(out_name);
			} catch (error:Error) {
				dispatchConnectionError("_receivingLC.connect with exception: " + error.message);
				return;
			}
			
			try{
				_sendingLC.send(in_name, "initConnection");
			} catch (error:Error) {
				dispatchConnectionError("_sendingLC.send with exception: " + error.message);
				return;
			}
		}
		
		/* INTERFACE crowd.core.js_api.IJSApi */
		
		public function get soc_type():String 
		{
			return SocialTypes.VKONTAKTE;
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void {
			dispatchConnectionError("_sendingLC.send with onSecurityError: " + e.text);
		}
		
		private function onInitStatus(e:StatusEvent):void {
			_sendingLC.removeEventListener(StatusEvent.STATUS, onInitStatus);
			
			if (e.level == "error") {
				dispatchConnectionError("onInitStatus with level=error code=" + e.code);
				return;
			}
			_isInited = true;
			dispatchSuccessConnect();
			//dispatchEvent(new SJSEvent(SJSEvent.CONNECT));
		}
		
		private function callback(callbackName:String, ...params):void {
			dispatchCallback(callbackName, params);
		}
		
		private function get in_name():String {
			return "_in_" + _connectionName;
		}
		
		private function get out_name():String {
			return "_out_" + _connectionName;
		}
		
		private function getLocalConnection():LocalConnection {
			var lc:LocalConnection = new LocalConnection();
			lc.allowDomain("*");
			return lc;
		}
		
		private function getClientObject():Object {
			return {
				onBalanceChanged: function(...params):void {
					callback("onBalanceChanged", params)
				},
				onSettingsChanged:  function(...params):void {
					callback("onSettingsChanged", params)
				},
				onLocationChanged:  function(...params):void {
					callback("onLocationChanged", params)
				},
				onWindowResized:  function(...params):void {
					callback("onWindowResized", params)
				},
				onApplicationAdded:  function(...params):void {
					callback("onApplicationAdded", params)
				},
				onWindowBlur:  function(...params):void {
					callback("onWindowBlur", params)
				},
				onWindowFocus:  function(...params):void {
					callback("onWindowFocus", params)
				},
				onWallPostSave:  function(...params):void {
					callback("onWallPostSave", params)
				},
				onWallPostCancel:  function(...params):void {
					callback("onWallPostCancel", params)
				},
				onProfilePhotoSave:  function(...params):void {
					callback("onProfilePhotoSave", params)
				},
				onProfilePhotoCancel:  function(...params):void {
					callback("onProfilePhotoCancel", params)
				},
				onMerchantPaymentSuccess:  function(...params):void {
					callback("onMerchantPaymentSuccess", params)
				},
				onMerchantPaymentCancel:  function(...params):void {
					callback("onMerchantPaymentCancel", params)
				},
				onMerchantPaymentFail:  function(...params):void {
					callback("onMerchantPaymentFail", params)
				},
				apiCallback:  function(...params):void {
					callback("apiCallback", params)
				},
				customEvent:  function(...params):void {
					callback("customEvent", params)
				}
			  };
		}
	}

}