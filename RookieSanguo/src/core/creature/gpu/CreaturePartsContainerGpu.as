package core.creature.gpu 
{
	import definition.CreaturePartEnum;
	import rookie.core.resource.ResUrl;
	/**
	 * ...
	 * @author Warmly
	 */
	public class CreaturePartsContainerGpu 
	{
		private var _body:CreaturePartAnimGpu;
		private var _weapon:CreaturePartAnimGpu;
		private var _horse:CreaturePartAnimGpu;
		private var _ref:Vector.<CreaturePartAnimGpu> = new Vector.<CreaturePartAnimGpu>();
		private var _action:uint;
		private var _direction:uint;
		
		public function CreaturePartsContainerGpu() 
		{
		}
		
		public function initBody(resUrl:ResUrl):void
		{
			_body = new CreaturePartAnimGpu(resUrl, CreaturePartEnum.BODY);
			_ref.push(_body);
		}
		
		public function initWeapon(resUrl:ResUrl):void
		{
			_weapon = new CreaturePartAnimGpu(resUrl, CreaturePartEnum.WEAPON);
			_ref.push(_weapon);
		}
		
		public function initHorse(resUrl:ResUrl):void
		{
			_horse = new CreaturePartAnimGpu(resUrl, CreaturePartEnum.HORSE);
			_ref.push(_horse);
		}
		
		public function reset():void
		{
			_action = 0;
			_direction = 0;
			_ref.length = 0;
		}
		
		public function synAction(action:uint, direction:uint, loop:uint):void
		{
			_action = action;
			_direction = direction;
			for each (var item:CreaturePartAnimGpu in _ref) 
			{
				item.synAction(action, direction);
				item.loop = loop;
			}
			updatePartsDepth();
		}
		
		public function synDirection(direction:uint):void
		{
			_direction = direction;
			for each (var item:CreaturePartAnimGpu in _ref) 
			{
				item.synDirection(direction);
			}
			updatePartsDepth();
		}
		
		public function render():void
		{
			for each (var item:CreaturePartAnimGpu in _ref) 
			{
				item.render();
			}
		}
		
		public function startPlay():void
		{
			for each (var item:CreaturePartAnimGpu in _ref) 
			{
				item.startPlay();
			}
		}
		
		private function updatePartsDepth():void
		{
			if (_ref.length)
			{
				var order:Array = CreaturePartEnum.RENDER_ORDER[_direction];
				for each (var item:CreaturePartAnimGpu in _ref) 
				{
					item.depth = order.indexOf(item.type);
				}
				_ref.sort(sortOnDepth);
			}
		}
		
		private function sortOnDepth(a:CreaturePartAnimGpu, b:CreaturePartAnimGpu):int 
		{
			return a.depth <= b.depth ? -1 : 1;
		}
	}
}