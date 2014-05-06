package rookie.core.render.gpu.factory 
{
	import rookie.core.render.gpu.base.RookieIndexBuffer;
	import rookie.core.render.gpu.base.RookieShader;
	import rookie.core.render.gpu.base.RookieVertexBuffer;
	import rookie.global.RookieEntry;
	/**
	 * ...
	 * @author Warmly
	 */
	public class RookieRenderFactory 
	{
		public function RookieRenderFactory() 
		{
		}
		
		public static function setBasicRenderState():void
		{
			var vertexBuffer:RookieVertexBuffer = RookieBufferFactory.createBasicVertexBuffer();
			var indexBuffer:RookieIndexBuffer = RookieBufferFactory.createBasicIndexBuffer();
			var shader:RookieShader = RookieShaderFactory.createBasicShader();
			RookieEntry.renderManager.setVertexBuffer(vertexBuffer);
			RookieEntry.renderManager.setIndexBuffer(indexBuffer);
			RookieEntry.renderManager.setShader(shader);
			RookieEntry.renderManager.setDepthTest();
		}
	}
}