package rookie.core.render.gpu.blend 
{
	import flash.display3D.Context3DBlendFactor;
	/**
	 * ...
	 * @author Warmly
	 */
	public class RookieBlendMode 
	{
		public static const NORMAL:int = 0;
		public static const ALPHA:int = 1;
		
		public static const BLEND_MODES:Array =
		[
		[Context3DBlendFactor.ONE, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA],
		[Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA]
		];
		
		public function RookieBlendMode() 
		{
		}
	}
}