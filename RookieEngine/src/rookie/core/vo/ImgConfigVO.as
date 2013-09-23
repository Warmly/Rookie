package rookie.core.vo
{
	import rookie.core.resource.ResUrl;

	import flash.utils.ByteArray;
	/**
	 * @author Warmly
	 */
	public class ImgConfigVO
	{
		private var _frameLength:uint;
		private var _imgWidth:uint;
		private var _imgHeight:uint;
		private var _resUrl:ResUrl;
		private var _frames:Vector.<ImgFrameConfigVO>;

		public function ImgConfigVO(packId:uint, groupId:uint, imageId:uint)
		{
			_resUrl = new ResUrl(packId, groupId, imageId);
		}

		public function parseAndInit(data:ByteArray):void
		{
			_frameLength = data.readUnsignedShort();
			_imgWidth = data.readUnsignedShort();
			_imgHeight = data.readUnsignedShort();
			if (_frameLength > 0)
			{
				_frames = new Vector.<ImgFrameConfigVO>();
				for (var i:int = 0; i < _frameLength;i++)
				{
					var topLeftX:int = data.readShort();
					var topLeftY:int = data.readShort();
					var bottomRightX:int = data.readShort();
					var bottomRightY:int = data.readShort();
					_frames[i] = new ImgFrameConfigVO(_resUrl, topLeftX, topLeftY, bottomRightX, bottomRightY);
				}
			}
		}

		public function get imgWidth():uint
		{
			return _imgWidth;
		}

		public function get imgHeight():uint
		{
			return _imgHeight;
		}

		public function get resUrl():ResUrl
		{
			return _resUrl;
		}
	}
}
