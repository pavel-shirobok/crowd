package crowd_framework.core.soc_init_data 
{
	import crowd_framework.core.environment.ISocialData;
	import crowd_framework.core.ISocialType;
	import crowd_framework.core.js_api.IJSApi;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface ICrowdInitData extends ISocialType
	{
		function set mock_js(v:IJSApi):void;
		function get mock_js():IJSApi;
	}
	
}