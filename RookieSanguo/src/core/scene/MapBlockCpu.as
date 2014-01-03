package core.scene
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import rookie.core.render.ImgCpuBase;
	import rookie.core.render.RichSprite;
	import rookie.core.resource.LoadPriority;
	import rookie.global.RookieEntry;

	import global.ModelEntry;

	import rookie.core.resource.ResUrl;
	import rookie.tool.objectPool.IObjPoolItem;
	import rookie.core.render.ImgCpu;
	import rookie.tool.functionHandler.FH;
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

		public function update():void
		{
			if (ModelEntry.mapModel.curMapVO)
			{
				var resUrl:ResUrl = ModelEntry.mapModel.getMapImgUrl(_index);
				manualLoad(resUrl, LoadPriority.HIGH);
				//log(resUrl.url);
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
	}
}
