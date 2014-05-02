package rookie.core.render.gpu.factory 
{
	import rookie.core.render.gpu.base.RookieIndexBuffer;
	import rookie.core.render.gpu.base.RookieVertexBuffer;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class RookieBufferFactory 
	{
		public function RookieBufferFactory() 
		{
		}
		
		/**
		* 0___1
		* |   |   
		* |___|
		* 3   2
		*/
		public static function createBasicVertexBuffer(width:Number, height:Number):RookieVertexBuffer
		{
			var vertexData:Vector.<Number> = Vector.<Number>([
			//x, y, u, v
			-width,  height,  0,  0,
			//
			 width,  height,  1,  0,
			//
			 width, -height,  1,  1,
			//
			-width, -height,  0,  1]);
			var buffer:RookieVertexBuffer = new RookieVertexBuffer(4);
			buffer.data = vertexData;
			buffer.upload();
			return buffer;
		}
		
		public static function createBasicIndexBuffer():RookieIndexBuffer
		{
			var indexData:Vector.<uint> = Vector.<uint>([
			//
			0, 1, 2,
			//
			2, 3, 0]);
			var buffer:RookieIndexBuffer = new RookieIndexBuffer();
			buffer.data = indexData;
			buffer.upload();
			return buffer;
		}
	}
}