package core.creature.gpu 
{
	import core.creature.ActProcess;
	import core.creature.CreatureVO;
	/**
	 * ...
	 * @author Warmly
	 */
	public class CreatureGpu 
	{
		protected var _creature:CreatureVO;
		protected var _partsContainer:CreaturePartsContainerGpu;
		protected var _action:int;
		protected var _direction:int;
		protected var _actProcess:ActProcess;
		
		public function CreatureGpu() 
		{
			_partsContainer = new CreaturePartsContainerGpu();
		}
		
		/**
	     * 动作改变
		 * @loop 播放次数，默认-1为一直循环播放 
	     */
		public function synAction(action:int, direction:int = -1, loop:int = -1):void
		{
			if (action != _action && action > 0)
			{
			}
		}
		
		public function render():void
		{
			_partsContainer.render();
		}
	}
}