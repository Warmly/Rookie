package core.scene
{
	import rookie.core.render.ImgCpuBase;
	import rookie.core.render.RichSprite;

	import global.ModelEntry;

	import rookie.core.resource.ResUrl;
	import rookie.tool.objectPool.IObjPoolItem;
	import rookie.core.render.ImgCpu;

	/**
	 * @author Warmly
	 */
	public class MapBlockCpu extends ImgCpuBase implements IObjPoolItem
	{
		private var _index:int;

		public function MapBlockCpu()
		{
			super(new ResUrl());
		}

		public function update():void
		{
			var resUrl:ResUrl = ModelEntry.mapModel.getMapImgUrl(_index);
			/*if (_img)
			{
				_img.manualLoad(resUrl);
			}
			else
			{
				_img = new ImgCpu(resUrl);
				_img.parent = this;
			}*/
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
