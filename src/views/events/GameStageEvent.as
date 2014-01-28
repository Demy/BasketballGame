package views.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Demy
	 */
	public class GameStageEvent extends Event 
	{
		public static const GOAL:String = "goal";
		public static const FALSE_GOAL:String = "false goal";
		public static const BALL_STOPPED:String = "ball stopped";
		
		public function GameStageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new GameStageEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameStageEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}