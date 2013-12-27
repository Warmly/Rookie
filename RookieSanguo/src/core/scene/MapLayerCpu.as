package core.scene
{
	import rookie.core.render.IRenderItem;
	import rookie.core.render.RichSprite;
	import rookie.global.RookieEntry;
	import rookie.tool.objectPool.ObjectPool;
	import rookie.tool.math.RookieMath;
	import rookie.tool.log.log;
    import rookie.namespace.Rookie;
	import global.SanguoEntry;
    use namespace Rookie;
	/**
	 * @author Warmly
	 */
	public class MapLayerCpu extends RichSprite implements IRenderItem
	{
		// 水平
		private var _numBlockH:int;
		// 竖直
		private var _numBlockV:int;
		private var _blocks:Vector.<MapBlockCpu> = new Vector.<MapBlockCpu>();

		public function MapLayerCpu()
		{
		}

		public function render():void
		{
			var camera:SanguoCamera = SanguoEntry.camera;
			var startIndexH:int = getStartIndex(camera.xInScene + MapModel.MAP_H_ADD);
			var startIndexV:int = getStartIndex(camera.yInScene + MapModel.MAP_V_ADD);
			
			for (var i:int = 0;i < _numBlockV;i++)
			{
				var yInScene:Number = (i + startIndexV) * MapModel.MAP_BLOCK_SIZE;
				for (var j:int = 0;j < _numBlockH;j++)
				{
					var xInScene:Number = (j + startIndexH) * MapModel.MAP_BLOCK_SIZE;
					var index:int = i * _numBlockH + j;
					var block:MapBlockCpu = _blocks[index] as MapBlockCpu;
					block.x = xInScene;
					block.y = yInScene;
					block.index = index;
					block.update();
				}
			}
		}

		public function onScreenResize():void
		{
			var camera:SanguoCamera = SanguoEntry.camera;
			_numBlockH = getBlockNum(camera.width);
			_numBlockV = getBlockNum(camera.height);
			resizeBlocks();
		}

		private function resizeBlocks():void
		{
			var needAddNum:int = _numBlockH * _numBlockV - _blocks.length;
			for (var i:int = 0;i < needAddNum;i++)
			{
				var block:MapBlockCpu = ObjectPool.getObject(MapBlockCpu) as MapBlockCpu;
				block.parent = this;
				_blocks.push(block);
			}
		}

		private function getStartIndex(coord:Number):int
		{
			var index:int = RookieMath.ceil(coord / MapModel.MAP_BLOCK_SIZE) - MapModel.CAMERA_RESERVE_BLOCK_NUM;
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
		
		public function dispose():void
		{
			RookieEntry.renderManager.removeFromQueue(this);
		}
		
		public function get key():String
		{
			return "MapLayerCpu" + "[" + name + "]";
		}
	}
}
