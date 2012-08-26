package crowd_framework.utils 
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
		
		public static function getSignature(params:Array,user_id:String, secret:String):String 
		{
			params.sort();
			return MD5.hash(user_id+params.join("")+secret);
		}
		
	}

}