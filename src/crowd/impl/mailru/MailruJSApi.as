package crowd.impl.mailru
{
	import com.ramshteks.as3.StringUtils;
	import crowd.core.js_api.AbstractJSApiDispatcher;
	import crowd.core.js_api.IJSApi;
	import crowd.SocialTypes;
	import flash.external.ExternalInterface;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class MailruJSApi extends AbstractJSApiDispatcher implements IJSApi
	{
		private const IC_MAILRU_RECEIVE:String = 'mailruReceive';
		private const IC_MAILRU_INIT:String = 'mailru.init';
		private const IC_MAILRU_EVENT:String = 'mailruEvent';
		
		private var INIT_CALLBACK:int = -1;
		private const OTHER_CALLBACK:int = 2;
		
		private var _flashId:String;
		private var _privateKey:String;
		private var _inited:Boolean = false;
		
		public function MailruJSApi() { }
		
		public function init(...param):void 
		{
			var params:Array;
			try{
				params= param[0] as Array;
				_flashId = params[0];
				_privateKey = params[1];	
			}catch (e:Error) {
				dispatchConnectionError("incorrect arguments: " + param);
				return;
			}
			
			if (_flashId == null || _flashId == "" || _privateKey == "" || _privateKey == null) {
				dispatchConnectionError("flash id or private key is not defined");
				return;
			}
			
			if (!ExternalInterface.available) {
				dispatchConnectionError("ExternalInterface is not available");
				return;
			}
			
			ExternalInterface.marshallExceptions = true;
			
			try{
				ExternalInterface.addCallback(IC_MAILRU_RECEIVE, callBackReceiver);
			}catch (e:Error) {
				dispatchConnectionError(StringUtils.printf("callback '%call%' is not installed", IC_MAILRU_RECEIVE));
				return;
			}
			
			try {
				INIT_CALLBACK = CALL_ID;
				ExternalInterface.call(getJSString(IC_MAILRU_INIT), [_privateKey, _flashId], INIT_CALLBACK);
			}catch (e:Error) {
				dispatchConnectionError(StringUtils.printf("JavaScript call '%call%' failed: %mess%", IC_MAILRU_INIT, e.message));
				return;
			}
		}
		
		private function callBackReceiver(cbid:Number, data:Object):void 
		{
			if (cbid == INIT_CALLBACK) {
				onApiLoaded(data);
			}
		}
		
		private function onApiLoaded (...args) : void {
			try {
				ExternalInterface.addCallback(IC_MAILRU_RECEIVE, null);
			}catch (e:Error) {
				dispatchConnectionError(StringUtils.printf("onApiLoaded: failed to removing callback of '%call%'", IC_MAILRU_RECEIVE));
				return;
			}
			
			try{
				ExternalInterface.addCallback(IC_MAILRU_EVENT, eventReceiver);
			}catch (e:Error) {
				dispatchConnectionError(StringUtils.printf("onApiLoaded: failed to adding callback of %call%", IC_MAILRU_EVENT));
				return;
			}
			dispatchSuccessConnect();
		}
		
		private function eventReceiver ( name : String, data : Object ) : void {
			dispatchCallback(name, data);
		}
		
		public function call(methodName:String, ...args):* 
		{
			var res:*;
			try {
				res = ExternalInterface.call(getJSString(methodName), args, CALL_ID);
			}catch (e:Error) {
				dispatchCallError(StringUtils.printf("ExternalInterface.call error code=%code%",e.errorID));
			}
			return res;
		}		
		
		public function get soc_type():String 
		{
			return SocialTypes.MAILRU;
		}
		
		private function getJSString(method:String):String {
			var objectName:String = (method.match(/(.*)\.[^.]+$/) || [0, 'window'])[1];
			return '' +
			'(function(args, cbid){ ' +  
			'if(typeof ' + method + ' != "function"){ ' +
			'	if(cbid) { document.getElementById("'+ _flashId+ '").mailruReceive(cbid, ' + method + '); }' +
			'	else { return '+ method+ '; }' +
			'}' +  			
			'if(cbid) {' + 
			'	args.unshift(function(value){ ' + 
			'		document.getElementById("'+ _flashId+ '").mailruReceive(cbid, value) ' +
			'	}); ' + 
			'};' +
			'return '+ method+ '.apply('+ objectName+ ', args) ' + 
			'})';
		}
		
		private function get CALL_ID():int 
		{
			return Math.round (Math.random() * int.MAX_VALUE);
		}
		
	}

}