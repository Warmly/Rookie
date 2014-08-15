package rookie.core.render.cpu
{
	import rookie.core.resource.LoadPriorityEnum;
	import rookie.core.vo.ImgFrameConfigVO;
	import rookie.core.vo.ImgConfigVO;
	import rookie.tool.functionHandler.fh;
	import rookie.core.resource.ResEnum;
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

		public function ImgCpuBase(resUrl:ResUrl = null, loadImmediately:Boolean = true, loadPriority:int = LoadPriorityEnum.LOW)
		{
			super();
			_resUrl = resUrl;
			if (loadImmediately)
			{
				_imgConfigVO = RookieEntry.resManager.getImgConfigVO(_resUrl);
				RookieEntry.loadManager.load(_resUrl, loadPriority, fh(onImgDataLoaded));
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
				var frame:ImgFrameConfigVO = _imgConfigVO.getFrame(i);
				frame.onImgFrameDataLoaded();
			}
		}

		public function manualLoad(resUrl:ResUrl = null, loadPriority:int = LoadPriorityEnum.LOW):void
		{
			if (resUrl)
			{
				_resUrl = resUrl;
			}
			_imgConfigVO = RookieEntry.resManager.getImgConfigVO(_resUrl);
			RookieEntry.loadManager.load(resUrl, loadPriority, fh(onImgDataLoaded));
		}

		public function set parent(prt:DisplayObjectContainer):void
		{
			prt.addChild(this);
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
