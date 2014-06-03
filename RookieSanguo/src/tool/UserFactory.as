package tool
{
	import core.creature.cpu.MyselfCpu;
	import definition.ActionEnum;
	import definition.DirectionEnum;
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
		
		public static function getTestUserCpu():UserCpu
		{
			var userCpu:UserCpu = ObjectPool.getObject(UserCpu) as UserCpu;
			userCpu.init(getTestUserVO());
			return userCpu;
		}
		
		public static function getMyselfCpu():MyselfCpu
		{
			var myselfCpu:MyselfCpu = new MyselfCpu();
			myselfCpu.init(getTestUserVO());
			myselfCpu.synAction(ActionEnum.STAND_ON_HORSE, DirectionEnum.RIGHT_DOWN);
			myselfCpu.scaleX = myselfCpu.scaleY = 0.6;
			return myselfCpu;
		}
	}
}
