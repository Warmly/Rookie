package core.scene
{
	import flash.utils.Dictionary;
	import global.ManagerEntry;
	import flash.utils.ByteArray;

	import rookie.core.resource.ResManager;
	import rookie.tool.functionHandler.fh;
	import rookie.core.resource.LoadPriorityEnum;
	import rookie.core.resource.ResEnum;
	import rookie.global.RookieEntry;
	import rookie.dataStruct.HashTable;

	import global.ModelEntry;
	import global.StaticDataModel;

	import rookie.core.resource.ResUrl;

	import global.ModelBase;
	
	import rookie.tool.log.error;

	/**
	 * @author Warmly
	 */
	public class MapModel extends ModelBase
	{
		// 地图块大小
		public static const MAP_BLOCK_SIZE:int = 256;
		// 镜头周围保留地图块数
		public static const CAMERA_RESERVE_BLOCK_NUM:int = 1;
		// 格子宽
		public static const CELL_WIDTH:int = 64;
		// 格子高
		public static const CELL_HEIGHT:int = 32;
		private var _sceneMapInfoConfig:HashTable = new HashTable(int, MapInfoVO);
		private var _curMapInfoVO:MapInfoVO;
		private var _mapVoConfig:HashTable = new HashTable(int, MapVO);
		private var _curMapId:int;
		private var _curMapVO:MapVO;
		// 地图总高
		private var _curMapWidth:int;
		// 地图总宽
		private var _curMapHeight:int;
		//
		private var _staticDataModel:StaticDataModel;
		private var _resManager:ResManager;

		public function MapModel()
		{
			super();
			_staticDataModel = ModelEntry.staticDataModel;
			_resManager = RookieEntry.resManager;
		}
		
		public function loadMap():void
		{
			var mapInfoVO:MapInfoVO = sceneMapInfoConfig.search(_curMapId) as MapInfoVO;
			if (mapInfoVO)
			{
				_curMapInfoVO = mapInfoVO;
				var resUrl:ResUrl = new ResUrl(-1, -1, mapInfoVO.fileName, ResEnum.MAP_DATA, "map/");
				RookieEntry.loadManager.load(resUrl, LoadPriorityEnum.HIGH, fh(onMapLoaded, resUrl.url));
			}
			else
			{
				error("未找到地图ID为" + _curMapId + "的地图XML配置！");
			}
		}

		private function onMapLoaded(mapUrlStr:String):void
		{
			var mapVO:MapVO = _mapVoConfig.search(_curMapInfoVO.id);
			if (!mapVO)
			{
				var byteArr:ByteArray = RookieEntry.resManager.byteArrData.search(mapUrlStr);
				mapVO = new MapVO(byteArr);
				_mapVoConfig.insert(_curMapInfoVO.id, mapVO);
			}
			_curMapVO = mapVO;
			ManagerEntry.sceneManager.onMapLoaded();
		}

		public function getMapImgUrl(index:int):ResUrl
		{
			var resUrl:ResUrl = new ResUrl(320, _curMapVO.groupId, index, ResEnum.JPG);
			return resUrl;
		}

		public function get curMapId():int
		{
			return _curMapId;
		}

		public function set curMapId(curMapId:int):void
		{
			_curMapId = curMapId;
		}

		public function get mapVoConfig():HashTable
		{
			return _mapVoConfig;
		}

		public function get curMapVO():MapVO
		{
			return _curMapVO;
		}

		public function set curMapVO(curMapVO:MapVO):void
		{
			_curMapVO = curMapVO;
		}

		public function get sceneMapInfoConfig():HashTable
		{
			if (_sceneMapInfoConfig.length == 0)
			{
				var xmlList:XMLList = _staticDataModel.getXmlConfig("sceneMapInfoConfig_client.xml").mapinfo.map;
				for each (var i : XML in xmlList)
				{
					var vo:MapInfoVO = new MapInfoVO(i);
					_sceneMapInfoConfig.insert(vo.id, vo);
				}
			}
			return _sceneMapInfoConfig;
		}
		
		public function get numBlockW():int
		{
			return curMapWidth / MAP_BLOCK_SIZE;
		}
		
		public function get curMapWidth():int 
		{
			_curMapWidth = _curMapVO ? CELL_WIDTH * _curMapVO.numCellW : 0;
			return _curMapWidth;
		}
		
		public function get curMapHeight():int 
		{
			_curMapHeight = _curMapVO ? CELL_HEIGHT * _curMapVO.numCellH : 0;
			return _curMapHeight;
		}
	}
}










