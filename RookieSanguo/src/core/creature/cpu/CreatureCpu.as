package core.creature.cpu
{
	import core.creature.ActProcess;
	import core.creature.CreatureVO;
	import core.scene.ISceneObj;
	import flash.geom.Point;
	import rookie.core.render.cpu.RichSprite;
	import definition.ActionEnum;
	import definition.DirectionEnum;
	import tool.SanguoCoorTool;

	import rookie.tool.objectPool.IObjPoolItem;
	import rookie.tool.objectPool.ObjectPool;

	/**
	 * @author Warmly
	 */
	public class CreatureCpu extends RichSprite implements IObjPoolItem, ISceneObj
	{
		protected var _creatureVO:CreatureVO;
		protected var _partsContainer:CreaturePartsContainerCpu;
		protected var _action:uint;
		protected var _direction:uint;
		protected var _actProcess:ActProcess;
		protected var _depth:uint;

		public function CreatureCpu()
		{
			_partsContainer = new CreaturePartsContainerCpu();
			_partsContainer.parent = this;
		}

		public function reset():void
		{
			_action = 0;
			_direction = 0;
			_partsContainer.reset();
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
		
		public function syn
		
		public function synScenePixelPos(pt:Point):void
		{
			this.x = pt.x;
			this.y = pt.y;
		}
		
		public function synScenePixelPosByCellPos():void
		{
			synScenePixelPos(SanguoCoorTool.cellToScene(_creatureVO.cellX, _creatureVO.cellY));
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
		
		public function dispose():void
		{
			ObjectPool.addToPool(this);
		}

		public function get direction():uint
		{
			return _direction;
		}

		public function get action():uint
		{
			return _action;
		}
		
		public function get depth():uint 
		{
			return _depth;
		}
		
		public function set depth(value:uint):void 
		{
			_depth = value;
		}
	}
}
