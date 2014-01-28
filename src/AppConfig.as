package  
{
	import controllers.ChangeScoresCommand;
	import controllers.SetArrowModeCommand;
	import models.GameModel;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import views.GameStage;
	import views.events.GameStageEvent;
	import views.GameStageMediator;
	import views.MainStageMediator;
	import views.MainStageView;
	
	/**
	 * ...
	 * @author Demy
	 */
	public class AppConfig implements IConfig 
	{
		[Inject]
		public var injector:IInjector;

		[Inject]
		public var mediatorMap:IMediatorMap;

		[Inject]
		public var commandMap:IEventCommandMap;

		[Inject]
		public var contextView:ContextView;

		
		public function AppConfig() 
		{
			
		}
		
		/* INTERFACE robotlegs.bender.framework.api.IConfig */
		
		public function configure():void 
		{
			injector.map(GameModel).asSingleton();
			
			mediatorMap.map(MainStageView).toMediator(MainStageMediator);
			mediatorMap.map(GameStage).toMediator(GameStageMediator);
			
			commandMap.map(GameStageEvent.BALL_STOPPED).toCommand(SetArrowModeCommand);
			commandMap.map(GameStageEvent.GOAL).toCommand(ChangeScoresCommand);
			commandMap.map(GameStageEvent.FALSE_GOAL).toCommand(ChangeScoresCommand);
			
			contextView.view.addChild(new MainStageView());
		}
		
	}

}