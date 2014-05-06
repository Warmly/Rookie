package rookie.core.render.gpu 
{
	import flash.display.BitmapData;
	import rookie.core.render.gpu.factory.RookieBufferFactory;
	import rookie.core.render.gpu.factory.RookieShaderFactory;
	import rookie.core.render.gpu.factory.RookieTextureFactory;
	import rookie.core.render.gpu.ImgGpuBase;
	import rookie.core.render.RenderManager;
	import rookie.core.resource.ResUrl;
	import rookie.global.RookieEntry;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ImgGpu extends ImgGpuBase
	{
		protected var _renderReady:Boolean;
		
		public function ImgGpu(resUrl:ResUrl) 
		{
			_renderReady = false;
			super(resUrl);
		}
		
		public function selfStartRender():void
		{
			RookieEntry.renderManager.addToQueue(this);
		}
		
		override protected function onImgDataLoaded():void
		{
			super.onImgDataLoaded();
			renderConfig();
		}
		
		protected function renderConfig():void
		{
			var bmd:BitmapData = _imgConfigVO.getFrames(0).bitmapData;
			_vertexBuffer = RookieBufferFactory.createBasicVertexBuffer();
			_indexBuffer = RookieBufferFactory.createBasicIndexBuffer();
			_shader = RookieShaderFactory.createBasicShader();
			_texture = RookieTextureFactory.createBasicTexture(bmd);
			_renderReady = true;
		}
		
		override public function render():void
		{
			if (_renderReady)
			{
				var renderManager:RenderManager = RookieEntry.renderManager;
				renderManager.setVertexBuffer(_vertexBuffer);
				renderManager.setIndexBuffer(_indexBuffer);
				renderManager.setShader(_shader);
				renderManager.setTextureAt(0, _texture);
				renderManager.setRenderPos(_x, _y, _texture.width, _texture.height);
				renderManager.draw();
			}
		}
	}
}