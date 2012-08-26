package crowd_framework.core 
{
	import crowd_framework.core.environment.ICrowdEnvironment;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface IEnvironmentInjectable 
	{
		function set inject_environment(env:ICrowdEnvironment):void
	}
	
}