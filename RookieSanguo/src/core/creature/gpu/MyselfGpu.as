package core.creature.gpu 
{
	import global.ModelEntry;
	import global.MyselfModel;
	/**
	 * ...
	 * @author Warmly
	 */
	public class MyselfGpu extends UserGpu 
	{
		private var _myselfModel:MyselfModel;
		
		public function MyselfGpu() 
		{
			_myselfModel = ModelEntry.myselfModel;
		}
		
		public function refresh():void
		{
		}
	}
}