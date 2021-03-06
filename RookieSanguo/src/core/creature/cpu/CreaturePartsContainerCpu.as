package core.creature.cpu
{
	import rookie.core.render.cpu.RichSprite;
	import definition.CreaturePartEnum;

	import rookie.core.resource.ResUrl;

	/**
	 * @author Warmly
	 */
	public class CreaturePartsContainerCpu extends RichSprite
	{
		private var _body:CreaturePartAnimCpu;
		private var _weapon:CreaturePartAnimCpu;
		private var _horse:CreaturePartAnimCpu;
		private var _ref:Vector.<CreaturePartAnimCpu> = new Vector.<CreaturePartAnimCpu>();
		private var _action:uint;
		private var _direction:uint;

		public function CreaturePartsContainerCpu()
		{
		}

		public function synAction(action:uint, direction:uint, loop:uint):void
		{
			_action = action;
			_direction = direction;
			for each (var i : CreaturePartAnimCpu in _ref)
			{
				i.synAction(action, direction);
				i.loop = loop;
			}
			updatePartsDepth();
		}

		public function synDirection(direction:uint):void
		{
			_direction = direction;
			for each (var i : CreaturePartAnimCpu in _ref)
			{
				i.synDirection(direction);
			}
			updatePartsDepth();
		}
		
		public function render():void
		{
			for each (var i:CreaturePartAnimCpu in _ref) 
			{
				i.render();
			}
		}

		public function initBody(resUrl:ResUrl):void
		{
			_body = new CreaturePartAnimCpu(resUrl, CreaturePartEnum.BODY);
			_ref.push(_body);
			_body.parent = this;
		}

		public function initWeapon(resUrl:ResUrl):void
		{
			_weapon = new CreaturePartAnimCpu(resUrl, CreaturePartEnum.WEAPON);
			_ref.push(_weapon);
			_weapon.parent = this;
		}
		
		public function initHorse(resUrl:ResUrl):void
		{
			_horse = new CreaturePartAnimCpu(resUrl, CreaturePartEnum.HORSE);
			_ref.push(_horse);
			_horse.parent = this;
		}
		
		public function reset():void
		{
			_action = 0;
			_direction = 0;
			removeChildren();
			_ref.length = 0;
		}

		private function updatePartsDepth():void
		{
			var numParts:int = _ref.length;
			if (numParts)
			{
				var order:Array = CreaturePartEnum.RENDER_ORDER[_direction];
				for each (var i : CreaturePartAnimCpu in _ref)
				{
					i.depth = order.indexOf(i.creaturePart);
				}
				_ref.sort(sortOnDepth);
				for each (var j : CreaturePartAnimCpu in _ref)
				{
					j.parent = this;
				}
			}
		}

		private function sortOnDepth(a:CreaturePartAnimCpu, b:CreaturePartAnimCpu):int
		{
			return a.depth <= b.depth ? -1 : 1;
		}
	}
}
