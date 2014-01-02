package core.scene
{
	import rookie.tool.log.log;
	import definition.SceneLayerEnum;

	import flash.utils.Endian;
	import flash.utils.ByteArray;

	/**
	 * @author Warmly
	 */
	public class MapVO
	{
		private var _id:uint;
		private var _name:String;
		private var _groupId:uint;
		private var _jpgSize:uint;
		private var _country:uint;
		// 水平格子数
		private var _numCellW:uint;
		// 竖直格子数
		private var _numCellH:uint;
		private var _buildShadows:Vector.<Vector.<int>>;

		public function MapVO(byteArr:ByteArray)
		{
			byteArr.endian = Endian.LITTLE_ENDIAN;
			byteArr.position = 12;
			_numCellW = byteArr.readUnsignedInt();
			_numCellH = byteArr.readUnsignedInt();
			var numLayer:uint = byteArr.readUnsignedInt();
			_groupId = byteArr.readUnsignedInt();
			_jpgSize = byteArr.readUnsignedInt();
			byteArr.position += 24;

			log("宽:" + _numCellW + " 高:" + _numCellH + " 层数:" + numLayer);

			for (var i:uint = 0;i < numLayer;i++)
			{
				var layerType:uint = byteArr.readUnsignedShort();
				var blendType:uint = byteArr.readUnsignedShort();
				var numItem:uint = byteArr.readUnsignedInt();
				byteArr.position += 2;
				var isAlphaArea:Boolean;
				if (byteArr.readUnsignedShort() == 99)
				{
					isAlphaArea = true;
				}
				var rearX:uint = byteArr.readUnsignedShort();
				var rearY:uint = byteArr.readUnsignedShort();

				log("地表类型:" + layerType + " 叠加方式:" + blendType + " 元素数量:" + numItem + " x,y 方向缩放比率" + rearX + " " + rearY);

				if (layerType == SceneLayerEnum.OBSTACLE)
				{
					if (!_buildShadows)
					{
						//_buildShadows = new Vector.<Vector.<int>>(_numCellH, true);
					}
					for (var j:uint = 0;j < numItem;j++)
					{
						var cellX:uint = byteArr.readUnsignedShort();
						var cellY:uint = byteArr.readUnsignedShort();
						var type:uint = byteArr.readUnsignedShort();
						var isWater:Boolean = type == 2;
						if(isAlphaArea || isWater)
						{
						}
					}
				}
			}
		}

		public function get id():uint
		{
			return _id;
		}

		public function get name():String
		{
			return _name;
		}

		public function get groupId():uint
		{
			return _groupId;
		}

		public function get country():uint
		{
			return _country;
		}

		public function get numCellW():uint
		{
			return _numCellW;
		}

		public function get numCellH():uint
		{
			return _numCellH;
		}
	}
}
