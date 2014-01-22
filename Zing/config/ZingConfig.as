package config 
{
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import rookie.dataStruct.HashTable;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ZingConfig 
	{
		[Embed(source="Zing.xml",mimeType="application/octet-stream")]
		private var _stageConfigCls:Class;
		private var _stageConfigXML:XML;
		private var _stageConfig:HashTable = new HashTable(int, ZingStageVO);
		
		public static const CELL_WIDTH:int = 80;
		public static const CELL_HEIGHT:int = 80;
		public static const PATH_ELE_SIZE:int = 60;
		
		public function ZingConfig() 
		{
			var ba:ByteArray = new _stageConfigCls();
			_stageConfigXML = XML(ba.readUTFBytes(ba.bytesAvailable));
			var xmlList:XMLList = _stageConfigXML.stage;
			for each(var i:XML in xmlList)
			{
				var vo:ZingStageVO = new ZingStageVO(i);
				_stageConfig.insert(vo.id, vo);
			}
		}
		
		public function getStageVO(id:int):ZingStageVO
		{
			return _stageConfig.search(id) as ZingStageVO;
		}
	}
}