package rookie.core.render
{
	import flash.display.BitmapData;
	import flash.utils.getDefinitionByName;

	import rookie.core.resource.ResUrl;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author Warmly
	 */
	public class ImgCpu extends ImgCpuBase
	{
		public function ImgCpu(resUrl:ResUrl, parent:DisplayObjectContainer)
		{
			super(resUrl, parent);
		}

		override protected function onImgDataLoaded():void
		{
			var cls:Class = getDefinitionByName(_resUrl.clsName) as Class;
			var bmd:BitmapData = new cls();
			this.bitmapData = bmd;
		}
	}
}
