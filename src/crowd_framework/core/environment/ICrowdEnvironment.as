package crowd_framework.core.environment 
{
	import com.ramshteks.utils.IVarsHolder;
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