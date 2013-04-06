package crowd.core
{
	public interface IRestApi extends ISocialType
	{
		function getLoader():IRestApiLoader;
		function get defaultFormat():String;
	}

}