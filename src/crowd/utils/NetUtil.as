package crowd.utils
{
	import com.adobe.crypto.MD5;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class NetUtil 
	{
		public static function getPostURLRequest(url:String):URLRequest {
			var req:URLRequest = new URLRequest(url);
			req.method = URLRequestMethod.POST;
			return req;
		}
		
		public static function getSignature(params_obj:Object, user_id:String, secret:String):String 
		{
			var array:Array = new Array();
			
			for (var key:String in params_obj) {
				array.push(key + "=" + params_obj[key]);
			}
			
			array.sort();
			
			return MD5.hash(user_id+array.join("")+secret);
		}
		
	}

}