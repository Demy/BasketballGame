package views 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Demy
	 */
	public class ControlArrow extends Sprite 
	{
		private const ROTATION_STEP:Number = 3;
		private const COLOR_STEP:Number = 3;
		
		private var _minAngle:Number;
		private var _maxAngle:Number;
		private var skin:ControlArrowSkin;
		private var _isRotating:Boolean;
		private var isMovingUp:Boolean;
		private var isColorRising:Boolean;
		
		public function ControlArrow(minAngle:Number = -80, maxAngle:Number = 80) 
		{
			_maxAngle = maxAngle;
			_minAngle = minAngle;
			
			skin = new ControlArrowSkin();
			addChild(skin);
			
			isRotating = true;
			isMovingUp = false;
			isColorRising = true;
		}
		
		public function updateRotation():void
		{
			if (!_isRotating) return;
			if (skin.rotation < _minAngle) isMovingUp = false;
			if (skin.rotation > _maxAngle) isMovingUp = true;
			skin.rotation += (isMovingUp ? -1 : 1) * ROTATION_STEP;
		}
		
		public function get angle():Number
		{
			return skin.rotation;
		}
		
		public function set angle(value:Number):void
		{
			skin.rotation = value;
		}
		
		public function updateColorFilling():void
		{
			if (percents > 100 - COLOR_STEP) isColorRising = false;
			if (percents < COLOR_STEP) isColorRising = true;
			percents += (isColorRising ? 1 : -1) * COLOR_STEP;
		}
		
		public function get percents():Number
		{
			return 100 - 100 * skin.colorMeter.layerMask.y / skin.colorMeter.layerMask.height;
		}
		
		public function set percents(value:Number):void
		{
			skin.colorMeter.layerMask.y = (100 - value) * skin.colorMeter.layerMask.height / 100;
		}
		
		public function get isRotating():Boolean 
		{
			return _isRotating;
		}
		
		public function set isRotating(value:Boolean):void 
		{
			_isRotating = value;
		}
		
		public function set minAngle(value:Number):void 
		{
			_minAngle = value;
		}
		
		public function set maxAngle(value:Number):void 
		{
			_maxAngle = value;
		}
		
	}

}