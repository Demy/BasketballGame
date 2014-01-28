package controllers 
{
	import models.GameModel;
	import robotlegs.bender.bundles.mvcs.Command;
	
	/**
	 * ...
	 * @author Demy
	 */
	public class SetArrowModeCommand extends Command 
	{
		[Inject]
		public var model:GameModel;
		
		public function SetArrowModeCommand() 
		{
		}
		
		override public function execute():void 
		{
			model.isControlMode = true;
		}
	}

}