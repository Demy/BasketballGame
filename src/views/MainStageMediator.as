package views 
{
	import models.GameModel;
	import models.events.GameModelEvent;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import views.events.ThrowParamsEvent;
	
	/**
	 * ...
	 * @author Demy
	 */
	public class MainStageMediator extends Mediator 
	{
		[Inject]
		public var view:MainStageView;
		[Inject]
		public var model:GameModel;
		
		public function MainStageMediator() 
		{
		}
		
		override public function initialize():void 
		{
			view.addGameView();
			view.addPointsView();
			
			addContextListener(GameModelEvent.CHANGE_MODE, changeMode);
			addContextListener(GameModelEvent.SCORES_CHANGED, updateScores);
			
			addViewListener(ThrowParamsEvent.SET_ANGLE, setParams);
			addViewListener(ThrowParamsEvent.SET_POWER, setParams);
		}
		
		private function changeMode(e:GameModelEvent):void 
		{
			if (model.isControlMode)
			{
				view.showArrow();
			}
			else
			{
				view.throwBall(model.throwAngle, model.throwPower);
			}
		}
		
		private function updateScores(e:GameModelEvent):void 
		{
			view.setScores(model.scores);
		}
		
		private function setParams(e:ThrowParamsEvent):void 
		{
			if (e.type ==  ThrowParamsEvent.SET_ANGLE)
			{
				model.throwAngle = e.value;
			}
			else
			{
				model.throwPower = e.value;
				model.isControlMode = false;
			}
		}
		
	}

}