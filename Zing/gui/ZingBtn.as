package gui 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingBtn extends Sprite
	{
		private var _mc:MovieClip;
		
		public function ZingBtn(mc:*) 
		{
			//var cls:Class = getDefinitionByName(res) as Class;
			//_mc = new cls() as MovieClip;
			_mc = mc as MovieClip;
			addChild(_mc)
			
			addEventListener(MouseEvent.ROLL_OVER, onOver);
			addEventListener(MouseEvent.ROLL_OUT, onOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		private function onOver(e:MouseEvent):void
		{
			_mc.gotoAndStop(2);
		}
		
		private function onOut(e:MouseEvent):void
		{
			_mc.gotoAndStop(1);
		}
		
		private function onDown(e:MouseEvent):void
		{
			_mc.gotoAndStop(3);
		}
		
		private function onUp(e:MouseEvent):void
		{
			_mc.gotoAndStop(2);
		}
	}
}