package rookie.core.render
{
	import rookie.core.vo.ImgFrameConfigVO;
	import rookie.core.vo.ImgConfigVO;
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
		protected var _imgConfigVO:ImgConfigVO;
		protected var _parent:DisplayObjectContainer;
		protected var _resUrl:ResUrl;

		public function ImgCpuBase(resUrl:ResUrl, parent:DisplayObjectContainer = null)
		{
			super();
			_resUrl = resUrl;
			_parent = parent;
			_imgConfigVO = RookieEntry.resManager.getImgConfigVO(_resUrl);
		}

		public function render():void
		{
			if (_parent)
			{
				_parent.addChild(this);
				RookieEntry.loadManager.load(_resUrl, ResType.SWF, 0, FH(onImgDataLoaded));
			}
		}

		public function set parent(parent:DisplayObjectContainer):void
		{
			_parent = parent;
		}

		protected function onImgDataLoaded():void
		{
			if (!_imgConfigVO)
			{
				throw new Error("没有对应图片的配置！");
				return;
			}
			var frameLength:uint = _imgConfigVO.frameLength;
			for (var i:uint = 0;i < frameLength;i++)
			{
				var frame:ImgFrameConfigVO = _imgConfigVO.getFrames(i);
				frame.onImgFrameDataLoaded();
			}
		}
	}
}
