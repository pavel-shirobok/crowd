package crowd_framework.core.environment 
{
	import com.ramshteks.as3.vars_holder.IVarsHolder;
	import crowd_framework.core.ISocialType;
	import crowd_framework.core.js_api.IJSApi;
	import crowd_framework.core.permissions.ISocialPermissions;
	import crowd_framework.core.request_builder.IRequestBuilder;
	import crowd_framework.core.rest_api.loaders.IRestApiLoader;
	
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
		function get permissions():ISocialPermissions;
	}
	
}