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
		
		//默认客户端宽
		public static const DEFAULT_CLIENT_WIDTH:int = 600;
		//默认客户端高
		public static const DEFAULT_CLIENT_HEIGHT:int = 800;
		//客户端宽高比
		public static const CLIENT_RATIO:Number = DEFAULT_CLIENT_WIDTH / DEFAULT_CLIENT_HEIGHT;
		//初始生命
		public static const DEFAULT_LIFT:int = 10;
		//初始时间
		public static const DEFAULT_CLOCK:int = 360;
		
		//客户端缩放比例
		public static var CLIENT_SCALE:Number = 1;
		public static var CELL_WIDTH:int = 60;
		public static var CELL_HEIGHT:int = 60;
		//格子内部响应区域大小
		public static var CELL_INNER_RESPONSE_SIZE:int = 40;
		//路径元素大小
		public static var PATH_ELE_SIZE:int = 90;
		
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
		
		public static function updateConfig():void
		{
			CELL_WIDTH = Math.round(CELL_WIDTH * CLIENT_SCALE);
			CELL_HEIGHT = Math.round(CELL_HEIGHT * CLIENT_SCALE);
			CELL_INNER_RESPONSE_SIZE = Math.round(CELL_INNER_RESPONSE_SIZE * CLIENT_SCALE);
			PATH_ELE_SIZE  = Math.round(PATH_ELE_SIZE * CLIENT_SCALE);
		}
		
		public function getStageVO(id:int):ZingStageVO
		{
			return _stageConfig.search(id) as ZingStageVO;
		}
	}
}