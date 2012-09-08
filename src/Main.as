package 
{
	import com.adobe.utils.ArrayUtil;
	import crowd_framework.core.ISocialType;
	import crowd_framework.Crowd;
	import crowd_framework.mailru_impl.soc_init_data.MailRuInitData;
	import crowd_framework.vk_impl.permissions.VKPermissions;
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
			
			_crowd.addInitData(new VkontakteInitData(stage));
			_crowd.addInitData(new MailRuInitData("sdfsdf"));
			
			_crowd.debugFilePath = "debug_data.xml";
			
			_crowd.addEventListener(Event.COMPLETE, onCrowdComplete);
			_crowd.addEventListener(ErrorEvent.ERROR, onCrowdError);
			_crowd.startCrowd(stage);
		}
		
		private function onCrowdComplete(e:Event):void 
		{
			trace(e);
			
			/*trace("rewuest builder", Crowd.environment.request_builder);
			trace("js_api", Crowd.environment.js_api);
			trace("flash_vars", Crowd.environment.flash_vars);
			trace("soc_type", Crowd.environment.soc_type);
			trace("social_data", Crowd.environment.social_data);*/
		}
		
		private function onCrowdError(e:ErrorEvent):void 
		{
			trace(e);
		}
		
	}
	
}