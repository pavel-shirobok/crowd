package crowd.core
{
	import crowd.core.ISocialType;
	import crowd.utils.formatter.IFormatter;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface ISocialData extends ISocialType
	{
		function get application_id():String;
		function get user_id():String;
		function get referrer():String;
		function get api_url():String;
		
		
		function getLocalData(formatter:IFormatter = null):String;
	}
	
}