package core.creature.cpu
{
	import core.creature.ActProcess;
	import core.creature.CreatureVO;
	import flash.geom.Point;
	import rookie.core.render.cpu.RichSprite;
	import definition.ActionEnum;
	import definition.DirectionEnum;

	import rookie.tool.objectPool.IObjPoolItem;
	import rookie.tool.objectPool.ObjectPool;

	/**
	 * @author Warmly
	 */
	public class CreatureCpu extends RichSprite implements IObjPoolItem
	{
		protected var _creatureVO:CreatureVO;
		protected var _partsContainer:CreaturePartsContainerCpu;
		protected var _action:int;
		protected var _direction:int;
		protected var _actProcess:ActProcess;

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
		 * @loop 播放次数，默认-1为一直循环播放 
	     */
		public function synAction(action:int, direction:int = -1, loop:int = -1):void
		{
			if (action != _action && action > 0)
			{
				_action = action;
				if (direction > 0)
				{
					_direction = direction;
				}
				_partsContainer.synAction(action, _direction, loop);
			}
			else 
			{
				synDirection(direction);
			}
		}
        
		/**
	     * 动作不变，方向改变
	     */
		public function synDirection(direction:int):void
		{
			if (direction != _direction && direction > 0)
			{
				_direction = direction;
				_partsContainer.synDirection(direction);
			}
		}
		
		public function synScenePixelPos(pt:Point):void
		{
			this.x = pt.x;
			this.y = pt.y;
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
	}
}
