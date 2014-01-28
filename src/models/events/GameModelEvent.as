package models.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Demy
	 */
	public class GameModelEvent extends Event 
	{
		public static const CHANGE_MODE:String = "change mode";
		public static const ANGLE_SET:String = "angle set";
		public static const POWER_SET:String = "power set";
		public static const SCORES_CHANGED:String = "scores changed";
		
		public function GameModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}