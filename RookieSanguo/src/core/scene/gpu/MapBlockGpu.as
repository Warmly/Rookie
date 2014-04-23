package core.scene.gpu 
{
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	import global.ModelEntry;
	import rookie.core.resource.ResUrl;
	import rookie.global.RookieEntry;
	import rookie.tool.functionHandler.FH;
	import rookie.tool.objectPool.IObjPoolItem;
	/**
	 * ...
	 * @author Warmly
	 */
	public class MapBlockGpu extends SceneObjGpuBase implements IObjPoolItem
	{
		private var _index:int;
		private var _texture:Texture;
		private var _resUrl:ResUrl;
		
		public function MapBlockGpu() 
		{
		}
		
		public function render():void
		{
			if (ModelEntry.mapModel.curMapVO)
			{
				var resUrl:ResUrl = ModelEntry.mapModel.getMapImgUrl(_index);
				load(resUrl);
			}
		}
		
		public function load(resUrl:ResUrl, loadPriority:int = 0):void
		{
			_resUrl = resUrl;
			RookieEntry.loadManager.load(resUrl, loadPriority, FH(onImgDataLoaded));
		}
		
		public function reset():void
		{
		}

		public function dispose():void
		{
		}
		
		public function set index(index:int):void
		{
			_index = index;
		}
		
		private function onImgDataLoaded():void
		{
			var bmd:BitmapData = RookieEntry.resManager.bmdData.search(_resUrl.url);
		}
	}
}