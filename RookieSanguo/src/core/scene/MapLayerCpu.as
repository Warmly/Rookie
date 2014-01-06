package core.scene
{
	import global.ModelEntry;
	import rookie.core.render.IRenderItem;
	import rookie.core.render.RichSprite;
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
		// 水平
		private var _numBlockW:int;
		// 竖直
		private var _numBlockH:int;
		private var _blocks:Vector.<MapBlockCpu> = new Vector.<MapBlockCpu>();

		public function MapLayerCpu()
		{
			_mapModel = ModelEntry.mapModel;
		}

		public function refresh():void
		{
			if (_mapModel.curMapVO)
			{
				var camera:SanguoCamera = SanguoEntry.camera;
				var startIndexX:int = getStartIndex(camera.xInScene);
				var startIndexY:int = getStartIndex(camera.yInScene);
				var numBlockWMAP:int = _mapModel.numBlockW;
				for (var i:int = 0;i < _numBlockH;i++)
				{
					var yInScene:Number = (i + startIndexY) * MapModel.MAP_BLOCK_SIZE;
					for (var j:int = 0;j < _numBlockW;j++)
					{
						var xInScene:Number = (j + startIndexX) * MapModel.MAP_BLOCK_SIZE;
						var block:MapBlockCpu = _blocks[i * _numBlockW + j];
						block.x = xInScene;
						block.y = yInScene;
						var index:int = (i + startIndexY) * numBlockWMAP + (j + startIndexX);
						block.index = index;
						block.refresh();
					}
				}
			}
		}

		public function onScreenResize():void
		{
			var camera:SanguoCamera = SanguoEntry.camera;
			_numBlockW = getBlockNum(camera.width);
			_numBlockH = getBlockNum(camera.height);
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

		private function getStartIndex(coord:Number):int
		{
			var index:int = RookieMath.floor(coord / MapModel.MAP_BLOCK_SIZE) - MapModel.CAMERA_RESERVE_BLOCK_NUM;
			if (index < 0)
			{
				index = 0;
			}
			return index;
		}

		private function getBlockNum(distance:Number):int
		{
			return RookieMath.ceil(distance / MapModel.MAP_BLOCK_SIZE) + MapModel.CAMERA_RESERVE_BLOCK_NUM * 2;
		}
	}
}
