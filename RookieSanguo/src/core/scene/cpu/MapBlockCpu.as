package core.scene.cpu
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import rookie.core.render.cpu.ImgCpuBase;
	import rookie.core.render.cpu.RichSprite;
	import rookie.core.resource.LoadPriorityEnum;
	import rookie.global.RookieEntry;

	import global.ModelEntry;

	import rookie.core.resource.ResUrl;
	import rookie.core.render.cpu.ImgCpu;
	import rookie.tool.functionHandler.fh;
	import rookie.tool.log.log;

	/**
	 * @author Warmly
	 */
	public class MapBlockCpu extends ImgCpuBase
	{
		private var _index:int;

		public function MapBlockCpu()
		{
			super(null, false, LoadPriorityEnum.HIGH);
		}

		public function render():void
		{
			if (ModelEntry.mapModel.curMapVO)
			{
				var resUrl:ResUrl = ModelEntry.mapModel.getMapImgUrl(_index);
				manualLoad(resUrl, LoadPriorityEnum.HIGH);
			}
		}
		
		override protected function onImgDataLoaded():void
		{
			var bmd:BitmapData = RookieEntry.resManager.bmdData.search(_resUrl.url);
			super.bitmapData = bmd;
		}

		public function set index(index:int):void
		{
			_index = index;
		}
	}
}
