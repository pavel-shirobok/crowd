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

		static public const UNKNOWN:String = "unknown";
		
		public static function getSocialTypeByFlashVars(flashvars:IVarsHolder):String {
			if (isVkontakteFlashVars(flashvars)) return VKONTAKTE;
			if (isMailruFlashVars(flashvars)) return MAILRU;
			if (isOdnoklassnikiFlashvars(flashvars)) return ODNOKLASSNIKI;
			
			return SocialTypes.UNKNOWN;
		}

		public static function isSupportingSocialType(soc_type:String):Boolean {
			return soc_type == MAILRU || VKONTAKTE == soc_type || ODNOKLASSNIKI == soc_type;
		}

		private static function isOdnoklassnikiFlashvars(flashvars:IVarsHolder):Boolean {
			return flashvars.hasValue("logged_user_id") && flashvars.hasValue("apiconnection");
		}

		private static function isMailruFlashVars(flashvars:IVarsHolder):Boolean {
			return flashvars.hasValue("oid") && flashvars.hasValue("vid");
		}

		private static function isVkontakteFlashVars(flashvars:IVarsHolder):Boolean {
			return flashvars.hasValue("api_id") && flashvars.hasValue("viewer_id");
		}
	}

}