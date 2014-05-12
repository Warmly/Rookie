package core.scene.gpu 
{
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	import global.ModelEntry;
	import rookie.core.render.gpu.base.RookieVertexBuffer;
	import rookie.core.render.gpu.factory.RookieBufferFactory;
	import rookie.core.render.gpu.factory.RookieShaderFactory;
	import rookie.core.render.gpu.factory.RookieTextureFactory;
	import rookie.core.render.RenderManager;
	import rookie.core.resource.ResUrl;
	import rookie.global.RookieEntry;
	import rookie.tool.functionHandler.fh;
	import rookie.tool.objectPool.IObjPoolItem;
	/**
	 * ...
	 * @author Warmly
	 */
	public class MapBlockGpu extends SceneObjGpuBase implements IObjPoolItem
	{
		private var _index:int;
		
		public function MapBlockGpu() 
		{
			super(null);
		}
		
		public function set index(value:int):void 
		{
			_index = value;
			var resUrl:ResUrl = ModelEntry.mapModel.getMapImgUrl(value);
			if (_resUrl && _resUrl.equal(resUrl))
			{
				return;
			}
			_resUrl = resUrl;
			RookieEntry.loadManager.load(_resUrl, 0, fh(onImgDataLoaded, _resUrl));
		}
		
		override protected function onImgDataLoaded(resUrl:ResUrl):void
		{
			renderInit(resUrl);
		}
		
		override protected function renderInit(resUrl:ResUrl):void
		{
			var bmd:BitmapData = RookieEntry.resManager.bmdData.search(resUrl.url);
			_texture = RookieTextureFactory.createBasicTexture(bmd);
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
		
		public function reset():void
		{
		}

		override public function dispose():void
		{
		}
	}
}