package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	
	/**
	 * ...
	 * @author Demy
	 */
	public class Main extends Sprite 
	{
		private var context:IContext;
		
		public function Main()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			context = new Context()
				.install(MVCSBundle)
				.configure(AppConfig)
				.configure(new ContextView(this));
		}
		
	}
	
}