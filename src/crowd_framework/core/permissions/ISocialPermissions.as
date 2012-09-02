package crowd_framework.core.permissions 
{
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface ISocialPermissions 
	{
		function checkPermission(permission:String):Boolean;
		function get allowed():Array;
	}
}