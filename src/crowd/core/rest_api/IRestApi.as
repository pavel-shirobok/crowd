package crowd.core.rest_api
{
	import crowd.core.ISocialType;
	import crowd.core.rest_api.loaders.IRestApiLoader;
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