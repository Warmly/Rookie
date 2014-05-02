package rookie.core.render.gpu.base 
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import rookie.global.RookieEntry;
	import rookie.namespace.Rookie;
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	import rookie.tool.math.RookieMath;
	use namespace Rookie;
	/**
	 * ...
	 * @author Warmly
	 */
	public class RookieTexture 
	{
		private var _texture:Texture;
		private var _bitmapData:BitmapData;
		private var _context3D:Context3D;
		private var _width:Number;
		private var _height:Number;
		
		public function RookieTexture() 
		{
			_context3D = RookieEntry.renderManager.context3D;
		}
		
		public function upload():void
		{
			_texture.uploadFromBitmapData(_bitmapData);
		}
		
		public function set bitmapData(value:BitmapData):void 
		{
			_bitmapData = value;
			_width = value.width;
			_height = value.height;
			_texture = _context3D.createTexture(RookieMath.nextPowerOfTwo(_width), RookieMath.nextPowerOfTwo(_height), Context3DTextureFormat.BGRA, true);
		}
		
		public function get texture():Texture 
		{
			return _texture;
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