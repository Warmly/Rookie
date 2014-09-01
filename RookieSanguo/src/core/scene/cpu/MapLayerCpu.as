package core.scene.cpu
{
	import core.scene.MapModel;
	import core.scene.SanguoCamera;
	import flash.geom.Point;
	import global.ModelEntry;
	import rookie.core.render.cpu.RichSprite;
	import rookie.tool.objectPool.ObjectPool;
	import rookie.tool.math.RookieMath;
	import rookie.tool.log.log;
    import rookie.namespace.Rookie;
	import global.SanguoEntry;
    use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class MapLayerCpu extends RichSprite
	{
		private var _mapModel:MapModel;
		private var _camera:SanguoCamera;
		// 水平
		private var _numBlockW:int;
		// 竖直
		private var _numBlockH:int;
		private var _blocks:Vector.<MapBlockCpu> = new Vector.<MapBlockCpu>();

		public function MapLayerCpu()
		{
			_mapModel = ModelEntry.mapModel;
			_camera = SanguoEntry.camera;
		}
		
		public function getFirstBlockPos():Point
		{
			if (_blocks.length)
			{
				return new Point(_blocks[0].x, _blocks[0].y);
			}
			return null;
		}

		public function get numBlockW():int
		{
			return _numBlockW;
		}
		
		public function get numBlockH():int
		{
			return _numBlockH;
		}
		
		public function render():void
		{
			if (_mapModel.curMapVO)
			{
				var startIndexX:int = getStartIndex(_camera.xInScene);
				var startIndexY:int = getStartIndex(_camera.yInScene);
				var numBlockWMap:int = _mapModel.numBlockW;
				for (var i:int = 0;i < _numBlockH;i++)
				{
					var yInScene:Number = (i + startIndexY) * MapModel.MAP_BLOCK_SIZE;
					for (var j:int = 0;j < _numBlockW;j++)
					{
						var xInScene:Number = (j + startIndexX) * MapModel.MAP_BLOCK_SIZE;
						var block:MapBlockCpu = _blocks[i * _numBlockW + j];
						block.x = xInScene;
						block.y = yInScene;
						var index:int = (i + startIndexY) * numBlockWMap + (j + startIndexX);
						block.index = index;
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
			for (var i:int = 0;i < needAddNum;i++)
			{
				var block:MapBlockCpu = ObjectPool.getObject(MapBlockCpu) as MapBlockCpu;
				block.parent = this;
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
