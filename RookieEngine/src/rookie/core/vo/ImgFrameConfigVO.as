package rookie.core.vo
{
	import flash.geom.Matrix;
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
		// Y轴反转的图片数据
		private var _yReverseBitmapData:BitmapData;
		private var _resUrl:ResUrl;
		private var _index:uint;
		private var _resCls:Class;
		// 原始图片宽
		private var _imgWidth:uint;
		// 原始图片高
		private var _imgHeight:uint;
		// 切割后的矩形区域
		private var _validRectX:Number;
		private var _validRectY:Number;
		private var _validRectWidth:Number;
		private var _validRectHeight:Number;

		public function ImgFrameConfigVO(index:uint, resUrl:ResUrl, topLeftX:int, topLeftY:int, bottomRightX:int, bottomRightY:int, width:uint, height:uint)
		{
			_resUrl = resUrl;
			_index = index;
			_imgWidth = width;
			_imgHeight = height;
			_validRectX = topLeftX;
			_validRectY = topLeftY;
			_validRectWidth = bottomRightX - topLeftX;
			_validRectHeight = bottomRightY - topLeftY;
		}

		public function onImgFrameDataLoaded():void
		{
			initClass();
		}

		private function initClass():void
		{
			var clsName:String = "bmd_" + _resUrl.packId + "_" + _resUrl.groupId + "_" + _resUrl.fileName;
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
			if (bitmapData && !_yReverseBitmapData)
			{
				var yReverseCopy:BitmapData = new BitmapData(bitmapData.width, bitmapData.height, bitmapData.transparent, 0x00000000);
				var matrix:Matrix = new Matrix();
				matrix.a = -1;
				matrix.tx = bitmapData.width;
				yReverseCopy.draw(bitmapData, matrix);
				_yReverseBitmapData = yReverseCopy;
			}
			return _yReverseBitmapData;
		}

		public function manualSetResCls(cls:Class):void
		{
			_resCls = cls;
			_bitmapData = new _resCls();
		}

		public function get imgWidth():uint
		{
			return _imgWidth;
		}

		public function get imgHeight():uint
		{
			return _imgHeight;
		}

		public function get validRectX():Number
		{
			return _validRectX;
		}

		public function get validRectY():Number
		{
			return _validRectY;
		}

		public function get validRectWidth():Number
		{
			return _validRectWidth;
		}

		public function get validRectHeight():Number
		{
			return _validRectHeight;
		}
	}
}
