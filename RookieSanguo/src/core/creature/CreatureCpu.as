package core.creature
{
	import definition.ActionEnum;
	import definition.DirectionEnum;

	import rookie.core.render.IParent;
	import rookie.tool.objectPool.IObjPoolItem;
	import rookie.tool.objectPool.ObjectPool;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	/**
	 * @author Warmly
	 */
	public class CreatureCpu extends Sprite implements IObjPoolItem,IParent
	{
		protected var _body:CreaturePartAnimCpu;
		protected var _weapon:CreaturePartAnimCpu;
		protected var _direction:uint = DirectionEnum.DEFAULT;
		protected var _action:uint = ActionEnum.DEFAULT;

		public function CreatureCpu()
		{
		}

		public function reset():void
		{
			_direction = DirectionEnum.DEFAULT;
			_action = ActionEnum.DEFAULT;
		}

		public function synActionAndDirection(action:uint, direction:uint):void
		{
			synAction(action);
			synDirection(direction);
		}

		public function synAction(action:uint):void
		{
			if(_body)
			{
				_body.synAction(action);
			}
			if(_weapon)
			{
				_weapon.synAction(action);
			}
		}

		public function synDirection(direction:uint):void
		{
			if(_body)
			{
				_body.synDirection(direction);
			}
			if(_weapon)
			{
				_weapon.synDirection(direction);
			}
		}

		public function set parent(parent:DisplayObjectContainer):void
		{
			parent.addChild(this);
		}

		public function deleteParent():void
		{
			if (parent)
			{
				parent.removeChild(this);
			}
		}

		public function dispose():void
		{
			ObjectPool.addToPool(this);
		}

		public function get direction():uint
		{
			return _direction;
		}

		public function set direction(direction:uint):void
		{
			_direction = direction;
		}

		public function get action():uint
		{
			return _action;
		}

		public function set action(action:uint):void
		{
			_action = action;
		}
	}
}
