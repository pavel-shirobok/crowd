package 
{
	import crowd_framework.core.ISocialType;
	import crowd_framework.Crowd;
	import crowd_framework.vk_impl.soc_init_data.VkontakteInitData;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class Main extends Sprite 
	{
		private var _crowd:Crowd;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var sc:ISocialType;
			
			_crowd = new Crowd(true);
			_crowd.registerSocialInitData(new VkontakteInitData(stage));
			_crowd.debugFilePath = "debug_data.xml";
			_crowd.addEventListener(Event.COMPLETE, onCrowdComplete);
			_crowd.addEventListener(ErrorEvent.ERROR, onCrowdError);
			_crowd.startCrowd(stage);
			
		}
		
		private function onCrowdComplete(e:Event):void 
		{
			trace(e);
			trace(Crowd.environment);
		}
		
		private function onCrowdError(e:ErrorEvent):void 
		{
			trace(e);
		}
		
	}
	
}