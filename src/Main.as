package 
{
	import crowd_framework.core.ISocialType;
	import crowd_framework.Crowd;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var sc:ISocialType;
			
			new Crowd()
			// entry point
		}
		
	}
	
}