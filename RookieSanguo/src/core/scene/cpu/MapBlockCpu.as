package core.scene.cpu
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import rookie.core.render.cpu.ImgCpuBase;
	import rookie.core.render.cpu.RichSprite;
	import rookie.core.resource.LoadPriority;
	import rookie.global.RookieEntry;
	import rookie.tool.objectPool.ObjectPool;

	import global.ModelEntry;

	import rookie.core.resource.ResUrl;
	import rookie.tool.objectPool.IObjPoolItem;
	import rookie.core.render.cpu.ImgCpu;
	import rookie.tool.functionHandler.fh;
	import rookie.tool.log.log;

	/**
	 * @author Warmly
	 */
	public class MapBlockCpu extends ImgCpuBase implements IObjPoolItem
	{
		private var _index:int;

		public function MapBlockCpu()
		{
			super(null, false);
		}

		public function refresh():void
		{
			if (ModelEntry.mapModel.curMapVO)
			{
				var resUrl:ResUrl = ModelEntry.mapModel.getMapImgUrl(_index);
				manualLoad(resUrl, LoadPriority.HIGH);
			}
		}
		
		override protected function onImgDataLoaded():void
		{
			var bmd:BitmapData = RookieEntry.resManager.bmdData.search(_resUrl.url);
			super.bitmapData = bmd;
		}
		
		override public function manualLoad(resUrl:ResUrl, loadPriority:int = 0):void
		{
			_resUrl = resUrl;
			RookieEntry.loadManager.load(resUrl, loadPriority, fh(onImgDataLoaded));
		}

		public function reset():void
		{
			if (this.bitmapData)
			{
				this.bitmapData.dispose();
			}
		}

		public function dispose():void
		{
			ObjectPool.addToPool(this);
		}

		public function set index(index:int):void
		{
			_index = index;
		}
	}
}
