package views 
{
	import robotlegs.bender.bundles.mvcs.Mediator;
	import views.events.GameStageEvent;
	
	/**
	 * ...
	 * @author Demy
	 */
	public class GameStageMediator extends Mediator 
	{
		[Inject]
		public var view:GameStage;
		
		public function GameStageMediator() 
		{
		}
		
		override public function initialize():void 
		{
			addViewListener(GameStageEvent.BALL_STOPPED, handleStageEvent);
			addViewListener(GameStageEvent.GOAL, handleStageEvent);
			addViewListener(GameStageEvent.FALSE_GOAL, handleStageEvent);
		}
		
		private function handleStageEvent(e:GameStageEvent):void 
		{
			dispatch(e);
		}
		
	}

}