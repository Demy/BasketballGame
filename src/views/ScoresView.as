package views 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Demy
	 */
	public class ScoresView extends Sprite 
	{
		private var currentValue:int;
		private var field:TextField;
		
		public function ScoresView(currentValue:int = 0) 
		{
			field = new TextField();
			field.defaultTextFormat = new TextFormat("Tahoma", 24, 0x808080);
			addChild(field);
			
			value = currentValue
		}
		
		public function get value():int 
		{
			return currentValue;
		}
		
		public function set value(points:int):void 
		{
			currentValue = points;
			field.text = "Очки: " + points;
			field.autoSize = TextFieldAutoSize.LEFT;
		}
		
	}

}