package crowd.utils.formatter
{
	import crowd.utils.Param;
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class XMLFormatter implements IFormatter 
	{
		
		public function XMLFormatter() 
		{
			
		}
		
		/* INTERFACE ramshteks.as3.crowd.interfaces.data.IFormatter */
		
		public function getString(data:Array):String 
		{
			var result:String = '<?xml version="1.0" encoding="utf-8" ?><data>';
			
			for each(var p:Param in data) {
				result += "<" + p.param_name + " value=\"" + p.param_value + "\"/>";
			}
			result += "</data>";
			return ((new XML(result)).*).toString();
		}
		
	}

}