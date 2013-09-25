package rookie.core.vo
{
	import flash.utils.getDefinitionByName;
	import flash.system.ApplicationDomain;
	import flash.display.BitmapData;

	import rookie.core.resource.ResUrl;

	/**
	 * @author Warmly
	 */
	public class ImgFrameConfigVO
	{
		private var _bitmapData:BitmapData;
		private var _resUrl:ResUrl;
		private var _index:uint;
		private var _resCls:Class;
		private var _imgWidth:uint;
		private var _imgHeight:uint;

		public function ImgFrameConfigVO(index:uint, resUrl:ResUrl, topLeftX:int, topLeftY:int, bottomRightX:int, bottomRightY:int, width:uint, height:uint)
		{
			_resUrl = resUrl;
			_index = index;
			_imgWidth = width;
			_imgHeight = height;
		}

		public function onImgFrameDataLoaded():void
		{
			initClass();
		}

		private function initClass():void
		{
			var clsName:String = "bmd_" + _resUrl.packId + "_" + _resUrl.groupId + "_" + _resUrl.imageId;
			if (ApplicationDomain.currentDomain.hasDefinition(clsName))
			{
				_resCls = getDefinitionByName(clsName) as Class;
			}
			else
			{
				clsName += "_" + _index;
				if (ApplicationDomain.currentDomain.hasDefinition(clsName))
				{
					_resCls = getDefinitionByName(clsName) as Class;
				}
			}
		}

		public function get bitmapData():BitmapData
		{
			if (!_bitmapData && _resCls)
			{
				_bitmapData = new _resCls();
			}
			return _bitmapData;
		}
	}
}
