package rookie.core.render
{
	import rookie.tool.functionHandler.FH;
	import rookie.core.resource.ResType;
	import rookie.global.RookieEntry;
	import rookie.core.resource.ResUrl;

	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;

	/**
	 * @author Warmly
	 */
	public class ImgCpuBase extends Bitmap implements IRenderItem,IParent
	{
		protected var _parent:DisplayObjectContainer;
		protected var _resUrl:ResUrl;

		public function ImgCpuBase(resUrl:ResUrl, parent:DisplayObjectContainer)
		{
			super();
			_resUrl = resUrl;
			_parent = parent;
		}

		public function render():void
		{
			if (_parent)
			{
				_parent.addChild(this);
				RookieEntry.resManager.load(_resUrl, ResType.SWF, 0, FH(onImgDataLoaded));
			}
		}

		public function set parent(parent:DisplayObjectContainer):void
		{
			_parent = parent;
		}

		protected function onImgDataLoaded():void
		{
		}
	}
}
