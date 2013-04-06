package crowd.core
{
	import crowd.core.ISocialType;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public interface IRestApiErrorReport extends ISocialType
	{
		function get format():String;
		
		function get code():int;
		
		function get message():String;
		
		function get params():Array;
		
		function get rawErrorString():String;
		
		function toString():String;
	}
	
}