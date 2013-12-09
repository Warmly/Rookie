package tool
{
	import core.creature.NpcConfigVO;
	import global.ModelEntry;
	import core.creature.NpcVO;
	import rookie.tool.objectPool.ObjectPool;
	import core.creature.NpcCpu;
	/**
	 * @author Warmly
	 */
	public class NpcFactory
	{
		public static function getTestNpcVO():NpcVO
		{
			var vo:NpcVO = new NpcVO();
			vo.detail = ModelEntry.staticDataModel.npcConfig.find(256) as NpcConfigVO;
			return vo;
		}
		
		public static function getTestNpcCpu():NpcCpu
		{
			var npcCpu:NpcCpu = ObjectPool.getObject(NpcCpu) as NpcCpu;
			npcCpu.init(getTestNpcVO());
			return npcCpu;
		}
	}
}
