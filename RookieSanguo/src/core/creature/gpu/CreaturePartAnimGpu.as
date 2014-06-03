package core.creature.gpu 
{
	import definition.ActionEnum;
	import definition.DirectionEnum;
	import definition.SanguoDefine;
	import global.ModelEntry;
	import rookie.core.render.gpu.AnimGpu;
	import rookie.core.resource.ResUrl;
	import rookie.core.vo.ImgConfigVO;
	import rookie.dataStruct.HashTable;
	import rookie.global.RookieEntry;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class CreaturePartAnimGpu extends AnimGpu 
	{
		// 动作ID为键，包含所有方向的配置为值的哈希表
		private var _imgConfigVoTable:HashTable = new HashTable(uint, ImgConfigVO);
		// 动作ID
		private var _action:uint = ActionEnum.DEFAULT;
		// 动作方向
		private var _direction:uint = DirectionEnum.DEFAULT;
		// 使用的图片资源的方向
		private var _resDir:uint;
		// 图片资源包含几个方向
		private var _resDirNum:uint;
		// 每个方向帧数
		private var _eachDirFrameNum:uint;
		// Y轴反转
		private var _needYReverse:Boolean;
		// 类型
		private var _type:uint;
		// 深度
		private var _depth:uint;

		public function CreaturePartAnimGpu(resUrl:ResUrl, type:uint) 
		{
			_type = type;
			super(resUrl, false);
			frequency = SanguoDefine.CREATURE_PART_ANIM_FREQUENCY;
			_imgConfigVoTable = RookieEntry.resManager.getImgConfigVoTable(resUrl);
		}
		
		public function synAction(action:uint):void
		{
			_action = action;
			_imgConfigVO = _imgConfigVoTable.search(action);
			_totalFrame = _imgConfigVO.frameLength;
			synActDirNum();
		}
		
		private function synActDirNum():void
		{
			_resDirNum = ModelEntry.actionModel.getActDirNum(_action, _resUrl.groupId);
			
			// 潜规则
			if (_action == ActionEnum.STAND && _totalFrame == 2)
			{
				_resDirNum = 2;
			}

			_eachDirFrameNum = _totalFrame / _resDirNum;
			// 潜规则
			if (_eachDirFrameNum == 0)
			{
				_resDirNum = 1;
				_eachDirFrameNum = _totalFrame;
			}
		}
	}
}