package controllers 
{
	import models.GameModel;
	import robotlegs.bender.bundles.mvcs.Command;
	import views.events.GameStageEvent;
	
	/**
	 * ...
	 * @author Demy
	 */
	public class ChangeScoresCommand extends Command 
	{
		[Inject]
		public var event:GameStageEvent;
		
		[Inject]
		public var model:GameModel;
		
		public function ChangeScoresCommand() 
		{
		}
		
		override public function execute():void 
		{
			if (event.type == GameStageEvent.GOAL)
			{
				model.addScores();
			}
			if (event.type == GameStageEvent.FALSE_GOAL)
			{
				model.substructScores();
			}
		}
	}

}