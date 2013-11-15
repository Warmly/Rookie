package core.scene
{
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

		public function SanguoCamera()
		{
		}

		public function setup(x:Number, y:Number, width:Number, height:Number):void
		{
			_rect = new Rectangle(x, y, width, height);
			_xInScene = x;
			_yInScene = y;
			_width = width;
			_height = height;
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
	}
}
