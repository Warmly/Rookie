package tool
{
	import core.creature.cpu.MyselfCpu;
	import core.creature.gpu.UserGpu;
	import definition.ActionEnum;
	import definition.DirectionEnum;
	import global.MyselfVO;
	import global.SanguoEntry;
	import rookie.tool.objectPool.ObjectPool;
	import core.creature.cpu.UserCpu;
	import core.creature.UserVO;
	/**
	 * @author Warmly
	 */
	public class UserFactory
	{
		public static function getTestUserVO():UserVO
		{
			var vo:UserVO = new UserVO();
			vo.body = 10305;
			vo.weapon = 10305;
			vo.horse = 3214;
			return vo;
		}
		
		public static function getTestUserGpu():UserGpu
		{
			var userGpu:UserGpu = ObjectPool.getObject(UserGpu) as UserGpu;
			userGpu.init(getTestUserVO());
			userGpu.synAction(ActionEnum.RUN_ON_HORSE, DirectionEnum.RIGHT_DOWN);
			return userGpu;
		}
		
		public static function getTestUserCpu():UserCpu
		{
			var userCpu:UserCpu = ObjectPool.getObject(UserCpu) as UserCpu;
			userCpu.init(getTestUserVO());
			userCpu.synAction(ActionEnum.RUN_ON_HORSE, DirectionEnum.RIGHT_DOWN);
			return userCpu;
		}
		
		public static function getTestMyselfVO():MyselfVO
		{
			var vo:MyselfVO = SanguoEntry.myselfVO;
			vo.cellX = 40;
			vo.cellX = 40;
			vo.body = 10305;
			vo.weapon = 10305;
			vo.horse = 3214;
			return vo;
		}
		
		public static function getMyselfCpu():MyselfCpu
		{
			var myselfCpu:MyselfCpu = new MyselfCpu();
			myselfCpu.init(getTestMyselfVO());
			myselfCpu.synAction(ActionEnum.STAND_ON_HORSE, DirectionEnum.RIGHT_DOWN);
			return myselfCpu;
		}
	}
}
