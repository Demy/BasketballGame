package views.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Demy
	 */
	public class ThrowParamsEvent extends Event 
	{
		public static const SET_ANGLE:String = "set angle";
		public static const SET_POWER:String = "set power";
		
		private var _value:Number;
		
		public function ThrowParamsEvent(type:String, value:Number, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_value = value;
			super(type, bubbles, cancelable);
		}
		
		public function get value():Number 
		{
			return _value;
		}
		
	}

}