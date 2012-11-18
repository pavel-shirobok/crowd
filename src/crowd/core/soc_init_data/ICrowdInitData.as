package crowd.core.soc_init_data
{
	import crowd.core.environment.ISocialData;
	import crowd.core.ISocialType;
	import crowd.core.js_api.IJSApi;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface ICrowdInitData extends ISocialType
	{
		function get request_per_second_limit():int;
		
		function get rest_api_format():String;
		function set rest_api_format(v:String):void;
		
		function set mock_js(v:IJSApi):void;
		function get mock_js():IJSApi;
	}
	
}