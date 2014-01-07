package core.creature
{
	import flash.geom.Point;
	import rookie.core.render.RichSprite;
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
		protected var _direction:uint;
		protected var _action:uint;
		protected var _actProcess:ActProcess;

		public function CreatureCpu()
		{
			_partsContainer = new CreaturePartsContainerCpu();
			_partsContainer.parent = this;
		}

		public function reset():void
		{
			_direction = DirectionEnum.DEFAULT;
			_action = ActionEnum.DEFAULT;
			_partsContainer.reset();
		}

		public function synAction(action:int, direction:int = -1):void
		{
			if (action != _action)
			{
				_action = action;
				if (direction > 0)
				{
					_direction = direction;
					_partsContainer.synAction(action, direction);
				}
				else
				{
					_partsContainer.synAction(action, _direction);
				}
			}
			else if(direction != _direction && direction > 0)
			{
				_direction = direction;
				_partsContainer.synDirection(direction);
			}
		}

		public function synDirection(direction:uint):void
		{
			if (direction != _direction)
			{
				_direction = direction;
				_partsContainer.synDirection(direction);
			}
		}
		
		public function setScenePixelPos(pt:Point):void
		{
			this.x = pt.x;
			this.y = pt.y;
		}

		public function setNewActProcess(ap:ActProcess):void
		{
			_actProcess = ap;
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
