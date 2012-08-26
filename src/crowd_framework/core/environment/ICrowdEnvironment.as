package crowd_framework.core.environment 
{
	import com.ramshteks.as3.vars_holder.IVarsHolder;
	import crowd_framework.core.ISocialType;
	import crowd_framework.core.js_api.IJSApi;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface ICrowdEnvironment extends ISocialType
	{
		
		function get request_builder():IRequestBuilder;
		function get js_api():IJSApi;
		function get social_data():ISocialData;
		function get flash_vars():IVarsHolder;
		
	}
	
}