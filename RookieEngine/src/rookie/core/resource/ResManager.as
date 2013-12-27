package rookie.core.resource
{
	import rookie.dataStruct.HashTable;
	import rookie.core.vo.ImgConfigVO;
	import rookie.namespace.Rookie;

	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.getDefinitionByName;

	use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class ResManager
	{
		// 二进制数据的字典
		private var _byteArrData:HashTable = new HashTable(String, ByteArray);
		// 位图数据的字典（直接以图片格式加载进来的图片，而不是swf）
		private var _bmdData:HashTable = new HashTable(String, BitmapData);
		// 包列表
		private var _packList:Array;
		// 图片配置的字典
		private var _imgConfig:HashTable = new HashTable(uint, HashTable);

		public function ResManager()
		{
			_packList = [302, 307, 310, 311, 313, 316, 317];
		}

		public function init():void
		{
			var packNum:int = _packList.length;
			for (var i:int = 0;i < packNum;i++)
			{
				var packId:uint = _packList[i];
				var cls:Class = getDefinitionByName("Image_StaticData_Data_" + packId) as Class;
				parseImgConfigData(new cls());
			}
		}

		private function parseImgConfigData(data:ByteArray):void
		{
			data.endian = Endian.LITTLE_ENDIAN;
			var byteArr:ByteArray = new ByteArray();
			byteArr.endian = Endian.LITTLE_ENDIAN;
			byteArr.writeBytes(data);
			byteArr.position = 0;

			var packId:uint = byteArr.readUnsignedShort();
			var groupLength:uint = byteArr.readUnsignedShort();
			var groupTable:HashTable = new HashTable(uint, HashTable);
			_imgConfig.insert(packId, groupTable);

			for (var i:int = 0; i < groupLength;i++)
			{
				var groupId:uint = byteArr.readUnsignedShort();
				var imgLength:uint = byteArr.readUnsignedShort();
				var imgTable:HashTable = new HashTable(uint, ImgConfigVO);
				groupTable.insert(groupId, imgTable);
				for (var j:int = 0;j < imgLength;j++)
				{
					var imageId:uint = byteArr.readUnsignedShort();
					var vo:ImgConfigVO = new ImgConfigVO(packId, groupId, imageId);
					vo.parseAndInit(byteArr);
					imgTable.insert(imageId, vo);
				}
			}
		}

		public function getImgConfigVO(resUrl:ResUrl):ImgConfigVO
		{
			var groupTable:HashTable = _imgConfig.search(resUrl.packId);
			if (groupTable)
			{
				var imgTable:HashTable = groupTable.search(resUrl.groupId);
				if (imgTable)
				{
					var vo:ImgConfigVO = imgTable.search(resUrl.fileName);
					return vo;
				}
			}
			return null;
		}

		public function getImgConfigVoTable(resUrl:ResUrl):HashTable
		{
			var groupTable:HashTable = _imgConfig.search(resUrl.packId);
			if (groupTable)
			{
				var imgTable:HashTable = groupTable.search(resUrl.fileName);
				if (imgTable)
				{
					return imgTable;
				}
			}
			return null;
		}

		public function get byteArrData():HashTable
		{
			return _byteArrData;
		}

		public function get bmdData():HashTable
		{
			return _bmdData;
		}
	}
}
