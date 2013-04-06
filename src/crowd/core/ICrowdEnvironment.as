package crowd.core
{
	import com.ramshteks.as3.vars_holder.IVarsHolder;

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