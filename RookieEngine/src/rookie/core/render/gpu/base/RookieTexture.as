package rookie.core.render.gpu.base 
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import rookie.core.time.SysTimeManager;
	import rookie.global.RookieEntry;
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	import rookie.tool.math.RookieMath;
	import rookie.namespace.Rookie;
	import rookie.tool.namer.NameBase;
	use namespace Rookie;
	/**
	 * ...
	 * @author Warmly
	 */
	public class RookieTexture extends NameBase
	{
		private var _texture:Texture;
		private var _bitmapData:BitmapData;
		private var _context3D:Context3D;
		private var _width:Number;
		private var _height:Number;
		private var _innerWidth:Number;
		private var _innerHeight:Number;
		private var _lastUsedTime:Number;
		
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
			_innerWidth = value.width;
			_innerHeight = value.height;
			_width = RookieMath.nextPowerOfTwo(_innerWidth);
			_height = RookieMath.nextPowerOfTwo(_innerHeight);
			_texture = _context3D.createTexture(_width, _height, Context3DTextureFormat.BGRA, true);
		}
		
		public function dispose():void
		{
			if (_texture)
			{
				_texture.dispose();
			}
			if (_bitmapData)
			{
				_bitmapData.dispose();
			}
		}
		
		public function get texture():Texture 
		{
			updateLastUsedTime();
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
		
		public function get innerWidth():Number 
		{
			return _innerWidth;
		}
		
		public function get innerHeight():Number 
		{
			return _innerHeight;
		}
		
		public function get lastUsedTime():Number 
		{
			return _lastUsedTime;
		}
		
		private function updateLastUsedTime():void
		{
			_lastUsedTime = SysTimeManager.sysTime;
		}
	}
}