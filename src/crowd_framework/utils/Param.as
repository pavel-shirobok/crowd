package crowd_framework.utils 
{
	import flash.net.URLVariables;
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class Param
	{
		public static function fromRaw(key:String, value:String):Param {
			return new Param(key, value);
		}
		
		public static function fromObject(src:Object):Array {
			var res:Array = new Array();
			for (var k:String in src) res.push(fromRaw(k, src[k]));
			return res;
		}
		
		public static function copyObjectToUrlVariables(src:Object, dest:URLVariables):void {
			for (var key:String in src) {
				dest[key] = src[key];
			}
		}
		
		private var _param_name:String;
		private var _param_value:String;
		
		public function Param(param_name:String, param_value:String) 
		{
			_param_name = param_name;
			_param_value = param_value;
		}
		
		public function get param_name():String { return _param_name; }
		
		public function get param_value():String { return _param_value; }
		
		public function get pair():String { return _param_name + "=" + _param_value; }
		
		public function toString():String 
		{
			return pair;
		}
		
	}

}