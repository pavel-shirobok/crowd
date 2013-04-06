package crowd.core
{
	import crowd.core.ISocialType;
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