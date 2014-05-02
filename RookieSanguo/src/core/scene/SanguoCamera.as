package core.scene
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author Warmly
	 */
	public class SanguoCamera
	{
		private var _rect:Rectangle;
		private var _xInScene:Number;
		private var _yInScene:Number;
		private var _width:Number;
		private var _height:Number;
		private var _focus:Point;

		public function SanguoCamera()
		{
		}

		public function setup(x:Number, y:Number, width:Number, height:Number):SanguoCamera
		{
			_rect = new Rectangle(x, y, width, height);
			_xInScene = x;
			_yInScene = y;
			_width = width;
			_height = height;
			_focus = new Point(_xInScene + _width * 0.5, _yInScene +_height * 0.5);
			return this;
		}

		public function move(x:Number, y:Number):void
		{
			_xInScene = x;
			_yInScene = y;
		}
		
		public function get rect():Rectangle
		{
			return _rect;
		}

		public function get xInScene():Number
		{
			return _xInScene;
		}

		public function get yInScene():Number
		{
			return _yInScene;
		}

		public function get width():Number
		{
			return _width;
		}

		public function get height():Number
		{
			return _height;
		}
		
		public function get focus():Point
		{
			return _focus;
		}
	}
}
