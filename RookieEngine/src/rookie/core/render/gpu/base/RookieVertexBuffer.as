package rookie.core.render.gpu.base 
{
	import flash.display3D.Context3D;
	import rookie.global.RookieEntry;
	import rookie.namespace.Rookie;
	import flash.display3D.VertexBuffer3D;
	use namespace Rookie;
	/**
	 * ...
	 * @author Warmly
	 */
	public class RookieVertexBuffer 
	{
		private var _data:Vector.<Number>;
		private var _buffer:VertexBuffer3D;
		private var _lengthPerVertex:uint;
		private var _length:uint;
		private var _context3D:Context3D;
		
		public function RookieVertexBuffer(lengthPerVertex:uint) 
		{
			_context3D = RookieEntry.renderManager.context3D;
			_lengthPerVertex = lengthPerVertex;
		}
		
		public function upload():void
		{
			_buffer.uploadFromVector(_data, 0, _data.length / _lengthPerVertex);
		}
		
		public function set data(value:Vector.<Number>):void 
		{
			_data = value;
			_length = value.length;
			_buffer = _context3D.createVertexBuffer(_data.length / _lengthPerVertex, _lengthPerVertex);
		}
		
		public function get buffer():VertexBuffer3D 
		{
			return _buffer;
		}
		
		public function get lengthPerVertex():uint 
		{
			return _lengthPerVertex;
		}
		
		public function get length():uint 
		{
			return _length;
		}
	}
}