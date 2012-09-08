package crowd_framework.core.permissions 
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