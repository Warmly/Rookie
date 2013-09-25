package rookie.core.render
{
	import rookie.core.resource.ResUrl;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author Warmly
	 */
	public class AnimCpu extends ImgCpuBase
	{
		public function AnimCpu(resUrl:ResUrl, parent:DisplayObjectContainer = null)
		{
			super(resUrl, parent);
		}

		override protected function onImgDataLoaded():void
		{
		}
	}
}
