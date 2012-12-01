package crowd
{
	import com.ramshteks.as3.vars_holder.IVarsHolder;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class SocialTypes 
	{
		public static const VKONTAKTE:String = "vkontakte";
		public static const MAILRU:String = "mailru";
		public static const ODNOKLASSNIKI:String = "odnoklassniki";

		static public const UNKNOW:String = "unknow";
		
		public static function getSocialTypeByFlashVars(flashvars:IVarsHolder):String {
			if (flashvars.hasValue("api_id") && flashvars.hasValue("viewer_id")) return VKONTAKTE;
			if (flashvars.hasValue("oid") && flashvars.hasValue("vid")) return MAILRU;
			if (flashvars.hasValue("logged_user_id") && flashvars.hasValue("apiconnection")) return ODNOKLASSNIKI;
			
			return SocialTypes.UNKNOW;
		}
		
	}

}