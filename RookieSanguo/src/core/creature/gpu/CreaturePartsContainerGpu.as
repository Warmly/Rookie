package core.creature.gpu 
{
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
		private var _action:int;
		private var _direction:int;
		
		public function CreaturePartsContainerGpu() 
		{
		}
		
		public function render():void
		{
			for each (var item:CreaturePartAnimGpu in _ref) 
			{
				item.render();
			}
		}
	}
}