package rookie.core.render
{
	import rookie.core.vo.ImgFrameConfigVO;
	import rookie.core.resource.ResUrl;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author Warmly
	 */
	public class ImgCpu extends ImgCpuBase
	{
		public function ImgCpu(resUrl:ResUrl, parent:DisplayObjectContainer = null)
		{
			super(resUrl, parent);
		}

		override protected function onImgDataLoaded():void
		{
			super.onImgDataLoaded();
			var frameFirst:ImgFrameConfigVO = _imgConfigVO.getFrames(0);
			super.bitmapData = frameFirst.bitmapData;
		}
	}
}
