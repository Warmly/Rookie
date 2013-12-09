package core.creature
{
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
		protected var _direction:uint = DirectionEnum.DEFAULT;
		protected var _action:uint = ActionEnum.DEFAULT;

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

		public function synActionAndDirection(action:uint, direction:uint):void
		{
			synAction(action);
			synDirection(direction);
		}

		public function synAction(action:uint):void
		{
			_action = action;
			_partsContainer.synAction(action);
		}

		public function synDirection(direction:uint):void
		{
			_direction = direction;
			_partsContainer.synDirection(direction);
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
