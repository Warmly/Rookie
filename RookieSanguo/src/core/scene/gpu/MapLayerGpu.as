package core.scene.gpu 
{
	import core.scene.MapModel;
	import core.scene.SanguoCamera;
	import flash.geom.Point;
	import global.ModelEntry;
	import global.SanguoEntry;
	import rookie.tool.math.RookieMath;
	import rookie.tool.objectPool.ObjectPool;
	import tool.SanguoCoorTool;
	/**
	 * ...
	 * @author Warmly
	 */
	public class MapLayerGpu
	{
		private var _mapModel:MapModel;
		private var _camera:SanguoCamera;
		// 水平
		private var _numBlockW:int;
		// 竖直
		private var _numBlockH:int;
		private var _blocks:Vector.<MapBlockGpu> = new Vector.<MapBlockGpu>();
		
		public function MapLayerGpu() 
		{
			_mapModel = ModelEntry.mapModel;
			_camera = SanguoEntry.camera;
		}
		
		public function render():void
		{
			if (_mapModel.curMapVO)
			{
				var startIndexX:int = getStartIndex(_camera.xInScene);
				var startIndexY:int = getStartIndex(_camera.yInScene);
				for (var i:int = 0; i < _numBlockH; i++) 
				{
					var yInScene:Number = (i + startIndexY) * MapModel.MAP_BLOCK_SIZE;
					for (var j:int = 0; j < _numBlockW; j++) 
					{
						var xInScene:Number = (j + startIndexX) * MapModel.MAP_BLOCK_SIZE;
						var block:MapBlockGpu = _blocks[i * _numBlockW + j];
						var pt:Point = SanguoCoorTool.sceneToCamera(xInScene, yInScene);
						block.x = pt.x;
						block.y = pt.y;
						block.index = (i + startIndexY) * _mapModel.numBlockW + (j + startIndexX);
						block.render();
					}
				}
			}
		}
		
		public function onScreenResize():void
		{
			_numBlockW = getBlockNum(_camera.width);
			_numBlockH = getBlockNum(_camera.height);
	        resizeBlocks();	
		}
		
		private function resizeBlocks():void 
		{
			var needAddNum:int = _numBlockW * _numBlockH - _blocks.length;
			for (var i:int = 0; i < needAddNum; i++) 
			{
				var block:MapBlockGpu = ObjectPool.getObject(MapBlockGpu) as MapBlockGpu;
				_blocks.push(block);
			}
		}
		
		/**
		 * 获得第一个地图块的纵向/横向索引
		 */
		private function getStartIndex(coord:Number):int
		{
			var index:int = RookieMath.floor(coord / MapModel.MAP_BLOCK_SIZE) - MapModel.CAMERA_RESERVE_BLOCK_NUM;
			if (index < 0)
			{
				index = 0;
			}
			return index;
		}
		
		/**
		 * 获得一定范围内需要的纵向/横向地图块叔
		 */
		private function getBlockNum(distance:Number):int
		{
			return RookieMath.ceil(distance / MapModel.MAP_BLOCK_SIZE) + MapModel.CAMERA_RESERVE_BLOCK_NUM * 2;
		}
	}
}