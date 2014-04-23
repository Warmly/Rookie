package rookie.core.render.cpu
{
	import rookie.core.vo.ImgFrameConfigVO;
	import rookie.core.resource.ResUrl;

	/**
	 * @author Warmly
	 */
	public class ImgCpu extends ImgCpuBase
	{
		public function ImgCpu(resUrl:ResUrl)
		{
			super(resUrl);
		}

		override protected function onImgDataLoaded():void
		{
			super.onImgDataLoaded();
			var frameFirst:ImgFrameConfigVO = _imgConfigVO.getFrames(0);
			super.bitmapData = frameFirst.bitmapData;
		}
	}
}
