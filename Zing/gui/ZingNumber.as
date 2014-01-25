package gui 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingNumber extends Sprite 
	{
		private var _number:Number;
		private var _cls:Class;
			
		public function ZingNumber() 
		{
			_cls = getDefinitionByName("digit") as Class;
		}
		
		public function set number(val:Number):void
		{
			removeChildren();
			var arr:Array = String(val).match(/\d/igx);
			var length:int = arr.length;
			for (var i:int = 0; i < length; i++)
			{
				var index:int = int(arr[i]) + 1;
				var mc:MovieClip = new _cls() as MovieClip;
				mc.gotoAndStop(index);
				mc.x = i * 30;
				addChild(mc);
			}
		}
	}
}