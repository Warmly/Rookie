package rookie.core.resource
{
	import rookie.core.vo.ImgConfigVO;
	import rookie.namespace.Rookie;

	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	import flash.utils.getDefinitionByName;

	use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class ResManager
	{
		// 二进制数据的字典
		private var _byteArrDataDic:Dictionary = new Dictionary();
		// 位图数据的字典
		private var _bmdDataDic:Dictionary = new Dictionary();
		private var _packList:Array = [302, 307, 310, 313, 316, 317];
		private var _imgConfigDic:Dictionary = new Dictionary();

		public function ResManager()
		{
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

		public function parseImgConfigData(data:ByteArray):void
		{
			data.endian = Endian.LITTLE_ENDIAN;
			var byteArr:ByteArray = new ByteArray();
			byteArr.writeBytes(data);
			byteArr.position = 0;

			var packId:uint = byteArr.readUnsignedShort();
			var groupLength:uint = byteArr.readUnsignedShort();
			var groupDic:Dictionary = new Dictionary();
			_imgConfigDic[packId] = groupDic;

			for (var i:int = 0; i < groupLength;i++)
			{
				var groupId:uint = byteArr.readUnsignedShort();
				var imgLength:uint = byteArr.readUnsignedShort();
				var imgDic:Dictionary = new Dictionary();
				groupDic[groupId] = imgDic;
				for (var j:int = 0;j < imgLength;j++)
				{
					var imageId:uint = byteArr.readUnsignedShort();
					var vo:ImgConfigVO = new ImgConfigVO(packId, groupId, imageId);
					vo.parseAndInit(data);
					imgDic[imageId] = vo;
				}
			}
		}

		Rookie function setByteArrData(url:String, byteArr:ByteArray):void
		{
			_byteArrDataDic[url] = byteArr;
		}

		Rookie function setBmdData(url:String, bmd:BitmapData):void
		{
			_bmdDataDic[url] = bmd;
		}
	}
}
