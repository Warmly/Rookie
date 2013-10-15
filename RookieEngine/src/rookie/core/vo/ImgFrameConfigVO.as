package rookie.core.vo
{
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import flash.system.ApplicationDomain;
	import flash.display.BitmapData;

	import rookie.core.resource.ResUrl;

	/**
	 * @author Warmly
	 */
	public class ImgFrameConfigVO
	{
		// 这一帧的图片数据
		private var _bitmapData:BitmapData;
		// Y轴反转
		private var _yReverseBitmapData:BitmapData;
		private var _resUrl:ResUrl;
		private var _index:uint;
		private var _resCls:Class;
		private var _imgWidth:uint;
		private var _imgHeight:uint;
		private var _validRect:Rectangle;

		public function ImgFrameConfigVO(index:uint, resUrl:ResUrl, topLeftX:int, topLeftY:int, bottomRightX:int, bottomRightY:int, width:uint, height:uint)
		{
			_resUrl = resUrl;
			_index = index;
			_imgWidth = width;
			_imgHeight = height;
			_validRect = new Rectangle(topLeftX, topLeftY, bottomRightX - topLeftX, bottomRightY - topLeftY);
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

		public function get yReverseBitmapData():BitmapData
		{
			if (_bitmapData && !_yReverseBitmapData)
			{
				var yReverseCopy:BitmapData = new BitmapData(_bitmapData.width, _bitmapData.height);
				var matrix:Matrix = new Matrix();
				matrix.a = -1;
				matrix.tx = _bitmapData.width;
				yReverseCopy.draw(_bitmapData, matrix, null, null, null, true);
				_yReverseBitmapData = yReverseCopy;
			}
			return _yReverseBitmapData;
		}

		public function get validRect():Rectangle
		{
			return _validRect;
		}

		public function manualSetResCls(cls:Class):void
		{
			_resCls = cls;
			_bitmapData = new _resCls();
		}
	}
}
