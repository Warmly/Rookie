package rookie.core.render.gpu.base 
{
	import flash.display3D.IndexBuffer3D;
	import rookie.global.RookieEntry;
	import rookie.namespace.Rookie;
	import flash.display3D.Context3D;
	use namespace Rookie;
	/**
	 * ...
	 * @author Warmly
	 */
	public class RookieIndexBuffer 
	{
		private var _data:Vector.<uint>;
		private var _buffer:IndexBuffer3D;
		private var _length:uint;
		private var _context3D:Context3D;
		
		public function RookieIndexBuffer() 
		{
			_context3D = RookieEntry.renderManager.context3D;
		}
		
		public function upload():void
		{
			_buffer.uploadFromVector(_data, 0, _data.length);
		}
		
		public function set data(value:Vector.<uint>):void 
		{
			_data = value;
			_length = value.length;
			_buffer = _context3D.createIndexBuffer(_data.length);
		}
		
		public function get buffer():IndexBuffer3D 
		{
			return _buffer;
		}
		
		public function get length():uint 
		{
			return _length;
		}
	}
}