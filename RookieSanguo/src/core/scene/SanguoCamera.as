package core.scene
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 定义一个矩形区域，对应舞台的宽高
	 * @author Warmly
	 */
	public class SanguoCamera
	{
		private var _xInScene:Number = 0;
		private var _yInScene:Number = 0;
		private var _width:Number = 0;
		private var _height:Number = 0;
		private var _focus:Point = new Point();

		public function SanguoCamera()
		{
		}
        
		public function setup(focusX:Number, focusY:Number, width:Number, height:Number):void
		{
			_width = width;
			_height = height;
			moveFocus(focusX, focusY);
		}

		public function move(x:Number, y:Number):void
		{
			_xInScene = x;
			_yInScene = y;
			_focus.x = _xInScene + _width * 0.5;
			_focus.y = _yInScene + _height * 0.5;
		}
		
		public function moveFocus(x:Number, y:Number):void
		{
			_xInScene = x - _width * 0.5;
			_yInScene = y - _height * 0.5;
			_focus.x = x;
			_focus.y = y;
		}
        
		/**
	     * 左上角在场景的X坐标
	     */
		public function get xInScene():Number
		{
			return _xInScene;
		}
        
		/**
	     * 左上角在场景的Y坐标
	     */
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
		
		/**
	     * 焦点
	     */
		public function get focus():Point
		{
			return _focus;
		}
	}
}
