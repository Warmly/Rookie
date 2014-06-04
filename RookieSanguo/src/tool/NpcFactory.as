package tool
{
	import core.creature.NpcConfigVO;
	import definition.ActionEnum;
	import definition.DirectionEnum;
	import global.ModelEntry;
	import core.creature.NpcVO;
	import rookie.tool.objectPool.ObjectPool;
	import core.creature.cpu.NpcCpu;
	/**
	 * @author Warmly
	 */
	public class NpcFactory
	{
		public static function getTestNpcVO():NpcVO
		{
			var vo:NpcVO = new NpcVO();
			vo.detail = ModelEntry.staticDataModel.getNpcConfigVO(256) as NpcConfigVO;
			return vo;
		}
		
		public static function getTestNpcCpu():NpcCpu
		{
			var npcCpu:NpcCpu = ObjectPool.getObject(NpcCpu) as NpcCpu;
			npcCpu.init(getTestNpcVO());
			npcCpu.synAction(ActionEnum.STAND, DirectionEnum.RIGHT_DOWN);
			return npcCpu;
		}
	}
}
