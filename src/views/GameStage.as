package views 
{
	import Box2D.Common.Math.b2Vec2;
	import com.actionsnippet.qbox.QuickBox2D;
	import com.actionsnippet.qbox.QuickObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import views.events.GameStageEvent;
	
	/**
	 * ...
	 * @author Demy
	 */
	public class GameStage extends MovieClip implements IGame
	{
		private const METERS:int = 30;
		private const BALL_RADIUS:Number = 30;
		private const NET_WIDTH:Number = 100;
		private const NET_SIDE_WIDTH:Number = 10;
		private const NET_HEIGHT:Number = 7;
		private const WALL_WIDTH:Number = 15;
		
		private var ball:QuickObject;
		private var net:QuickObject;
		private var sim:QuickBox2D;
		private var isAiming:Boolean;
		private var isAimingUsidedown:Boolean;
		
		public function GameStage() 
		{
			super();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			sim = new QuickBox2D(this);

			sim.createStageWalls();
			
			ball = sim.addCircle( { 
				x:(WALL_WIDTH + BALL_RADIUS) / METERS, 
				y:(getGroundLevel() - BALL_RADIUS) / METERS, 
				radius:BALL_RADIUS / METERS, 
				restitution:0.6, 
				angularDamping: 5, 
				mouseEnabled: false,
				skin: BallSkin 
			} );
			
			net = createNet();
			
			sim.start();
			
			isAiming = false;
			isAimingUsidedown = false;
			
			sim.addEventListener(QuickBox2D.STEP, onStep);
		}
		
		private function createNet():QuickObject 
		{
			var leftSide:QuickObject = sim.addBox( { 
				x: NET_SIDE_WIDTH / (2 * METERS), 
				y: NET_HEIGHT / (2 * METERS), 
				width: NET_SIDE_WIDTH / METERS, 
				height: NET_HEIGHT / METERS, 
				density: 0 
			} );
			var rightSide:QuickObject = sim.addBox( { 
				x: (NET_WIDTH - NET_SIDE_WIDTH / 2) / METERS, 
				y: NET_HEIGHT / (2 * METERS), 
				width: NET_SIDE_WIDTH / METERS, 
				height: NET_HEIGHT / METERS, 
				density: 0 
			} );
				
			return sim.addGroup( { 
				objects: [leftSide, rightSide], 
				x: (stage.stageWidth - NET_WIDTH - WALL_WIDTH) / METERS, 
				y: (stage.stageHeight / 3) / METERS, 
				density: 0, 
				skin: NetSkin 
			} );
		}
		
		private function onStep(e:Event):void 
		{
			setAiming();
			
			var velocity:b2Vec2 = ball.body.GetLinearVelocity();
			var groundLvl:Number = getGroundLevel() - BALL_RADIUS;
			if (velocity.Length() < 0.1 && 
				Math.round(ball.y * METERS) == groundLvl) 
				stopBall();
		}
		
		private function setAiming():void 
		{
			if (ball.x < net.x) 
			{
				isAiming = false;
				isAimingUsidedown = false;
			}
			else
			{
				if (!isAiming && ball.y < net.y) isAiming = true;
				if (!isAimingUsidedown && ball.y > net.y) isAimingUsidedown = true;
			}
			if (isAiming && (ball.x >= net.x && ball.y > net.y))
			{
				isAiming = false;
				dispatchEvent(new GameStageEvent(GameStageEvent.GOAL));
			}
			if (isAimingUsidedown && (ball.x >= net.x && ball.y < net.y))
			{
				isAimingUsidedown = false;
				dispatchEvent(new GameStageEvent(GameStageEvent.FALSE_GOAL));
			}
		}
		
		private function stopBall():void 
		{
			dispatchEvent(new GameStageEvent(GameStageEvent.BALL_STOPPED));
			sim.stop();
			sim.removeEventListener(QuickBox2D.STEP, onStep);
		}
		
		public function throwBall(newVelocityX:Number, newVelocityY:Number):void
		{
			sim.start();
			if (!hasEventListener(QuickBox2D.STEP)) sim.addEventListener(QuickBox2D.STEP, onStep);
			
			var velocity:b2Vec2 = ball.body.GetLinearVelocity();
			velocity.x += newVelocityX;
			velocity.y += newVelocityY;
			ball.body.SetLinearVelocity(velocity);
		}
		
		public function get ballPlace():Point
		{
			return new Point(ball.x * METERS, ball.y * METERS);
		}
		
		private function getGroundLevel():Number 
		{
			return stage.stageHeight - WALL_WIDTH;
		}
		
	}

}