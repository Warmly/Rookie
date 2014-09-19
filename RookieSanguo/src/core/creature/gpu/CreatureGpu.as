package core.creature.gpu 
{
	import core.creature.ActProcess;
	import core.creature.CreatureVO;
	import core.scene.ISceneObj;
	import flash.geom.Point;
	import global.SanguoEntry;
	import rookie.global.RookieEntry;
	import rookie.tool.objectPool.ObjectPool;
	import rookie.tool.objectPool.ObjPoolItem;
	import tool.CoorTool;
	/**
	 * ...
	 * @author Warmly
	 */
	public class CreatureGpu extends ObjPoolItem implements ISceneObj
	{
		protected var _creatureVO:CreatureVO;
		protected var _partsContainer:CreaturePartsContainerGpu;
		protected var _action:uint;
		protected var _direction:uint;
		protected var _actProcess:ActProcess;
		protected var _depth:uint;
		//场景坐标X
		protected var _x:Number = 0;
		//场景坐标Y
		protected var _y:Number = 0;
		
		public function CreatureGpu() 
		{
			_partsContainer = new CreaturePartsContainerGpu();
		}
		
		/**
	     * 动作改变
		 * @loop 播放次数，默认0为一直循环播放 
	     */
		public function synAction(action:uint, direction:uint = 0, loop:uint = 0):void
		{
			if (action && action != _action)
			{
				_action = action;
				if (direction)
				{
					_direction = direction;
				}
				_partsContainer.synAction(_action, _direction, loop);
			}
			else
			{
				synDirection(direction);
			}
		}
		
		/**
	     * 动作不变，方向改变
	     */
		public function synDirection(direction:uint):void
		{
			if (direction && direction != _direction)
			{
				_direction = direction;
				_partsContainer.synDirection(direction);
			}
		}
		
		public function render():void
		{
			updateRenderPos();
			_partsContainer.render();
		}
		
		public function initActProcess():void
		{
			if (!_actProcess)
			{
				_actProcess = new ActProcess();
			}
		}
		
		public function clearActProcess():void
		{
			_actProcess = null;
		}
		
		public function get actProcess():ActProcess
		{
			return _actProcess;
		}
		
		/**
		 * 场景坐标X
		 */
		public function get x():Number 
		{
			return _x;
		}
		
		/**
		 * 场景坐标Y
		 */
		public function get y():Number 
		{
			return _y;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
			updateRenderPos();
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
			updateRenderPos();
		}
		
		public function get depth():uint 
		{
			return _depth;
		}
		
		public function set depth(value:uint):void 
		{
			_depth = value;
		}
		
		override public function reset():void
		{
			_action = 0;
			_direction = 0;
			_partsContainer.reset();
			super.reset();
		}
		
		public function startPlay():void 
		{
			_partsContainer.startPlay();
		}
		
		public function get id():Number 
		{
			return _creatureVO.id;
		}
		
		public function set id(value:Number):void 
		{
			_creatureVO.id = value;
		}
		
		public function synDepthByCurCellPos():void
		{
			_depth = _creatureVO.cellY;
		}
		
		public function synPixelPos(pixelX:Number, pixelY:Number):void
		{
			this.x = pixelX;
			this.y = pixelY;
		}
		
		public function synPixelPosByCurCellPos():void
		{
			var pt:Point = CoorTool.cellToScene(_creatureVO.cellX, _creatureVO.cellY);
			synPixelPos(pt.x, pt.y);
		}
		
		public function synCellPos(cellX:int, cellY:int, synPixelPos:Boolean = false):void
		{
			_creatureVO.cellX = cellX;
			_creatureVO.cellY = cellY;
			if (synPixelPos)
			{
				synPixelPosByCurCellPos();
			}
		}
		
		private function updateRenderPos():void
		{
			var cameraPos:Point = CoorTool.sceneToCamera(_x, _y);
			_partsContainer.x = cameraPos.x;
			_partsContainer.y = cameraPos.y;
		}
	}
}