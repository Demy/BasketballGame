package views 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import views.events.ThrowParamsEvent;
	
	/**
	 * ...
	 * @author Demy
	 */
	public class MainStageView extends Sprite 
	{
		static public const MAX_THROW_POWER:Number = 100;
		private var game:IGame;
		private var arrow:ControlArrow;
		private var points:ScoresView;
		
		public function MainStageView():void 
		{
			super();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function addGameView():void 
		{
			if (contains(game)) removeChild(game);
			game = new GameStage();
			addChild(game as DisplayObject);
		}
		
		public function addPointsView():void 
		{
			points = new ScoresView();
			points.x = 20;
			points.y = 20;
			addChild(points);
		}
		
		public function showArrow():void 
		{
			var ball:Point = game.ballPlace;
			
			if (!arrow) arrow = new ControlArrow();
			arrow.minAngle = ball.x > stage.stageWidth / 4 ? -90 : 0;
			arrow.maxAngle = ball.x < stage.stageWidth * 3 / 4 ? 90 : 0;
			arrow.isRotating = true;
			arrow.percents = 0;
			arrow.angle = 0;
			arrow.x = ball.x;
			arrow.y = ball.y;
			addChild(arrow);
			
			addEventListener(Event.ENTER_FRAME, animate);
			stage.addEventListener(MouseEvent.CLICK, setControlValue);			
		}
		
		public function setScores(value:int):void
		{
			points.value = value;
		}
		
		public function throwBall(throwAngle:Number, throwPower:Number):void 
		{
			var angle:Number = (90 - Math.abs(throwAngle)) * Math.PI / 180;
			var vecY:Number = throwPower * Math.sin(angle);
			var vecX:Number = Math.sqrt(throwPower * throwPower - vecY * vecY) * (throwAngle > 0 ? 1 : -1);
			game.throwBall(vecX, vecY);	
			
			if (contains(arrow)) removeChild(arrow);
		}
		
		private function animate(e:Event):void 
		{
			if (arrow.isRotating)
			{
				arrow.updateRotation();
			}
			else
			{
				arrow.updateColorFilling();
			}
		}
		
		private function setControlValue(e:MouseEvent):void 
		{
			if (arrow.isRotating)
			{
				arrow.isRotating = false;
				dispatchEvent(new ThrowParamsEvent(ThrowParamsEvent.SET_ANGLE, arrow.angle));
			}
			else
			{
				var throwPower:Number = arrow.percents * MAX_THROW_POWER / 100;
				if (hasEventListener(Event.ENTER_FRAME)) 
				{
					removeEventListener(Event.ENTER_FRAME, animate);
					stage.removeEventListener(MouseEvent.CLICK, setControlValue);
				}
				dispatchEvent(new ThrowParamsEvent(ThrowParamsEvent.SET_POWER, throwPower));
			}
		}
	}

}