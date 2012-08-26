package crowd_framework.core.rest_api 
{
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public interface IRestApiErrorReport 
	{
		function get code():int;
		function get message():String;
		
		function get params():Array;
	}
	
}