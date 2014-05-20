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
	import rookie.tool.namer.namer;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ImgGpu extends ImgGpuBase
	{
		public function ImgGpu(resUrl:ResUrl) 
		{
			super(resUrl);
		}
		
		/**
		 * 仅用于调试，慎用！
		 */
		public function selfStartRender():void
		{
			RookieEntry.renderManager.addToGpuRenderQueue(this);
		}
		
		override protected function onImgDataLoaded(resUrl:ResUrl):void
		{
			super.onImgDataLoaded(resUrl);
			renderInit(resUrl);
		}
		
		override protected function renderInit(resUrl:ResUrl):void
		{
			var bmd:BitmapData = _imgConfigVO.getFrames(0).bitmapData;
			_texture = RookieTextureFactory.createBasicTexture(bmd);
			_texture.name = namer(resUrl.url);
			_renderReady = true;
		}
		
		override public function render():void
		{
			if (_renderReady)
			{
				var renderManager:RenderManager = RookieEntry.renderManager;
				renderManager.setTextureAt(0, _texture);
				renderManager.setRenderPos(_x, _y, _texture.width, _texture.height);
				renderManager.draw();
			}
		}
	}
}