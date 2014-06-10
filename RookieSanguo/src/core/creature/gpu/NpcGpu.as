package core.creature.gpu 
{
	import core.creature.NpcVO;
	import rookie.core.resource.ResUrl;
	/**
	 * ...
	 * @author Warmly
	 */
	public class NpcGpu extends CreatureGpu 
	{
		public function NpcGpu() 
		{
		}
		
		public function init(vo:NpcVO):void
		{
			_creatureVO = vo;
			_partsContainer.reset();
			var resUrl:ResUrl = new ResUrl(316, -1, vo.detail.pic);
			_partsContainer.initBody(resUrl);
		}
		
		public function get npcVO():NpcVO
		{
			return _creatureVO as NpcVO;
		}
	}
}