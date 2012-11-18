package crowd.core.environment
{
	import com.ramshteks.as3.vars_holder.IVarsHolder;
	import crowd.core.js_api.IJSApi;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface ICrowdEnvironmentInitializer extends ICrowdEnvironment
	{
		function setJSApi(js_api:IJSApi):void;
		function setFlashVarsHolder(vars:IVarsHolder):void;
	}
	
}