package rookie.core.render
{
	import rookie.core.resource.LoadPriority;
	import rookie.core.vo.ImgFrameConfigVO;
	import rookie.core.vo.ImgConfigVO;
	import rookie.tool.functionHandler.FH;
	import rookie.core.resource.ResType;
	import rookie.global.RookieEntry;
	import rookie.core.resource.ResUrl;

	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import rookie.tool.log.error;

	/**
	 * @author Warmly
	 */
	public class ImgCpuBase extends Bitmap implements IParent
	{
		protected var _imgConfigVO:ImgConfigVO;
		protected var _resUrl:ResUrl;

		public function ImgCpuBase(resUrl:ResUrl = null, loadImmediately:Boolean = true)
		{
			super();
			_resUrl = resUrl;
			if (loadImmediately)
			{
				_imgConfigVO = RookieEntry.resManager.getImgConfigVO(_resUrl);
				RookieEntry.loadManager.load(_resUrl, LoadPriority.LOW, FH(onImgDataLoaded));
		    }
		}

		protected function onImgDataLoaded():void
		{
			if (!_imgConfigVO)
			{
				error("没有" + _resUrl.url + "的配置！");
				return;
			}
			var frameLength:uint = _imgConfigVO.frameLength;
			for (var i:uint = 0;i < frameLength;i++)
			{
				var frame:ImgFrameConfigVO = _imgConfigVO.getFrames(i);
				frame.onImgFrameDataLoaded();
			}
		}

		public function manualLoad(resUrl:ResUrl):void
		{
			_resUrl = resUrl;
			_imgConfigVO = RookieEntry.resManager.getImgConfigVO(resUrl);
			RookieEntry.loadManager.load(resUrl, LoadPriority.LOW, FH(onImgDataLoaded));
		}

		public function set parent(parent:DisplayObjectContainer):void
		{
			parent.addChild(this);
		}

		public function deleteParent():void
		{
			if (parent)
			{
				parent.removeChild(this);
			}
		}
	}
}
