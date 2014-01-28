package models 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import models.events.GameModelEvent;
	/**
	 * ...
	 * @author Demy
	 */
	public class GameModel 
	{
        [Inject]
        public var eventDispatcher:IEventDispatcher;
		
		private const SCORE:int = 100;
		private var _scores:int;
		private var _isControlMode:Boolean;
		private var _throwAngle:Number;
		private var _throwPower:Number;
		
		public function GameModel() 
		{
			_scores = 0;
			_isControlMode = false;
		}
		
		public function get scores():int 
		{
			return _scores;
		}
		
		public function get isControlMode():Boolean 
		{
			return _isControlMode;
		}
		
		public function set isControlMode(value:Boolean):void 
		{
			_isControlMode = value;
			eventDispatcher.dispatchEvent(new GameModelEvent(GameModelEvent.CHANGE_MODE));
		}
		
		public function get throwAngle():Number 
		{
			return _throwAngle;
		}
		
		public function set throwAngle(value:Number):void 
		{
			_throwAngle = value;
			eventDispatcher.dispatchEvent(new GameModelEvent(GameModelEvent.ANGLE_SET));
		}
		
		public function get throwPower():Number 
		{
			return _throwPower;
		}
		
		public function set throwPower(value:Number):void 
		{
			_throwPower = value;
			eventDispatcher.dispatchEvent(new GameModelEvent(GameModelEvent.POWER_SET));
		}
		
		public function addScores():void 
		{
			_scores += SCORE;
			eventDispatcher.dispatchEvent(new GameModelEvent(GameModelEvent.SCORES_CHANGED));
		}
		
		public function substructScores():void
		{
			_scores -= SCORE;
			eventDispatcher.dispatchEvent(new GameModelEvent(GameModelEvent.SCORES_CHANGED));			
		}
		
	}

}