package views 
{
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Demy
	 */
	public interface IGame extends IEventDispatcher
	{
		function throwBall(newVelocityX:Number, newVelocityY:Number):void;
		function get ballPlace():Point;
	}
	
}