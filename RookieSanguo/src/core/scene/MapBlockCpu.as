package core.scene
{
	import global.ModelEntry;

	import rookie.core.resource.ResUrl;
	import rookie.tool.objectPool.IObjPoolItem;
	import rookie.core.render.ImgCpu;

	import flash.display.Sprite;

	/**
	 * @author Warmly
	 */
	public class MapBlockCpu extends Sprite implements IObjPoolItem
	{
		private var _img:ImgCpu;
		private var _index:int;

		public function MapBlockCpu()
		{
		}

		public function update():void
		{
			var resUrl:ResUrl = ModelEntry.mapModel.getMapImgUrl(_index);
			if (_img)
			{
				_img.manualLoad(resUrl);
			}
			else
			{
				_img = new ImgCpu(resUrl);
			}
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
