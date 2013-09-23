package global
{
	import definition.ImgConfigVO;

	import flash.utils.Dictionary;
	import flash.utils.Endian;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;

	/**
	 * @author Warmly
	 */
	public class ImgDataModel extends ModelBase
	{
		private var _packList:Array = [302, 307, 310, 313, 316, 317];
		private var _imgConfigDic:Dictionary = new Dictionary();

		public function ImgDataModel()
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
	}
}
