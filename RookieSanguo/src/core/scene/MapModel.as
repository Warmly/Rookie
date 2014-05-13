package core.scene
{
	import global.ManagerEntry;
	import flash.utils.ByteArray;
	import rookie.core.frame.FrameVO;
	import rookie.core.render.gpu.base.RookieTexture;

	import rookie.core.resource.ResManager;
	import rookie.tool.functionHandler.fh;
	import rookie.core.resource.LoadPriority;
	import rookie.core.resource.ResType;
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
		// 地图水平附加格子数
		public static const MAP_W_ADD_CELL:int = 20;
		// 地图竖直附加格子数
		public static const MAP_H_ADD_CELL:int = 20;
		// 地图水平附加长度
		public static const MAP_W_ADD:int = MAP_W_ADD_CELL * CELL_WIDTH;
		// 地图竖直附加长度
		public static const MAP_H_ADD:int = MAP_H_ADD_CELL * CELL_HEIGHT;
		private var _sceneMapInfoConfig:HashTable = new HashTable(int, MapInfoVO);
		private var _curMapInfoVO:MapInfoVO;
		private var _mapVoConfig:HashTable = new HashTable(int, MapVO);
		private var _curMapId:int;
		private var _curMapVO:MapVO;
		// 有效地图宽
		private var _validMapWidth:int;
		// 有效地图高
		private var _validMapHeight:int;
		// 地图总高（计算附加高）
		private var _totalMapWidth:int;
		// 地图总宽（计算附加宽）
		private var _totalMapHeight:int;
		//
		private var _staticDataModel:StaticDataModel;
		private var _resManager:ResManager;
		private var _textureTable:HashTable = new HashTable(String, RookieTexture);
		private var _frameUpdateComponent:FrameVO;

		public function MapModel()
		{
			super();
			_staticDataModel = ModelEntry.staticDataModel;
			_resManager = RookieEntry.resManager;
			//_frameUpdateComponent = RookieEntry.frameManager.setFrameInterval(1,);
			
		}

		public function loadMap():void
		{
			var mapInfoVO:MapInfoVO = sceneMapInfoConfig.search(_curMapId) as MapInfoVO;
			if (mapInfoVO)
			{
				_curMapInfoVO = mapInfoVO;
				var resUrl:ResUrl = new ResUrl(-1, -1, mapInfoVO.fileName, ResType.MAP_DATA, "map/");
				RookieEntry.loadManager.load(resUrl, LoadPriority.HIGH, fh(onMapLoaded, resUrl.url));
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
			var resUrl:ResUrl = new ResUrl(320, _curMapVO.groupId, (index + "_" + MAP_BLOCK_SIZE + "_" + totalMapWidth + "_" + totalMapHeight), ResType.JPG);
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

		public function get totalMapWidth():int
		{
			_totalMapWidth = validMapWidth + MAP_W_ADD * 2;
			return _totalMapWidth;
		}

		public function get totalMapHeight():int
		{
			_totalMapHeight = validMapHeight + MAP_H_ADD * 2;
			return _totalMapHeight;
		}

		public function get validMapWidth():int
		{
			_validMapWidth = _curMapVO.numCellW * CELL_WIDTH;
			return _validMapWidth;
		}

		public function get validMapHeight():int
		{
			_validMapHeight = _curMapVO.numCellH * CELL_HEIGHT;
			return _validMapHeight;
		}
		
		public function get numBlockW():int
		{
			return totalMapWidth / MAP_BLOCK_SIZE;
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
	}
}
