package crowd_framework.core.request_builder 
{
	import crowd_framework.core.ISocialType;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface IRequestBuilder extends ISocialType
	{
		function getAPIRequest(params:Object):URLRequest;
		function getAuthVariables():URLVariables;
	}
	
}