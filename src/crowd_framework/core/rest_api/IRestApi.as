package crowd_framework.core.rest_api 
{
	import crowd_framework.core.ISocialType;
	import crowd_framework.core.rest_api.loaders.IRestApiLoader;
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public interface IRestApi extends ISocialType
	{
		function getLoader():IRestApiLoader;
		function get defaultFormat():String;
	}

}