package crowd.core
{
	import crowd.core.IRestApiLoader;

	import flash.events.Event;
	import flash.utils.setInterval;

	/**
	 * ...
	 * @author Shirobok Pavel aka ramshteks
	 */
	public class RestApiSynchronizer 
	{
		private var _stack:Vector.<IRestApiLoader> = new Vector.<IRestApiLoader>();
		public function RestApiSynchronizer(delay:int = 333) 
		{
			setInterval(checkQueue, delay);
		}
		
		private function checkQueue():void 
		{
			if (_stack.length == 0) return;
			
			var loader:IRestApiLoader = _stack.shift();
			startLoader(loader);
		}

		//noinspection JSMethodCanBeStatic
		private function startLoader(loader:IRestApiLoader):void
		{
			loader.dispatchEvent(new Event(Event.SELECT));
		}
		
		public function putInQueue(loader:IRestApiLoader):void {
			if (_stack.length != 0) {
				_stack.push(loader);
			}else {
				startLoader(loader);
			}
		}
		
	}

}