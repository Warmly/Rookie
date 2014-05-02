package rookie.core.render.gpu.factory 
{
	import flash.display.BitmapData;
	import rookie.core.render.gpu.base.RookieTexture;
	import rookie.namespace.Rookie;
	import flash.display3D.Context3D;
	import rookie.global.RookieEntry;
	use namespace Rookie;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class RookieTextureFactory 
	{
		public function RookieTextureFactory() 
		{
		}
		
		public static function createBasicTexture(bmd:BitmapData):RookieTexture
		{
			var texture:RookieTexture = new RookieTexture();
			texture.bitmapData = bmd;
			texture.upload();
			return texture;
		}
	}
}