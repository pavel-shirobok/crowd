package crowd.core
{
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface ISocialPermissions 
	{
		function check(...permissions:Array):Boolean;
		function get allowed():Array;
	}
}