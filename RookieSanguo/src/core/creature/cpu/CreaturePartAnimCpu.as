package core.creature.cpu
{
	import definition.SanguoDefine;
	import flash.utils.Dictionary;
	import rookie.dataStruct.HashTable;
	import definition.ActionEnum;
	import definition.DirectionEnum;

	import global.ModelEntry;

	import rookie.core.render.cpu.AnimCpu;
	import rookie.core.resource.ResUrl;
	import rookie.core.vo.ImgConfigVO;
	import rookie.core.vo.ImgFrameConfigVO;
	import rookie.global.RookieEntry;

	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;

	/**
	 * @author Warmly
	 */
	public class CreaturePartAnimCpu extends AnimCpu
	{
		// 动作ID为键，包含所有方向的配置为值的哈希表
		private var _imgConfigVoTable:HashTable = new HashTable(uint, ImgConfigVO);
		// 动作ID
		private var _action:uint;
		// 动作方向
		private var _direction:uint;
		// 使用的图片资源的方向
		private var _resDir:uint;
		// 图片资源包含几个方向
		private var _resDirNum:int;
		// 每个方向帧数
		private var _eachDirFrameNum:int;
		// Y轴反转
		private var _needYReverse:Boolean;
		// 类型
		private var _type:uint;
		// 深度
		private var _depth:uint;

		public function CreaturePartAnimCpu(resUrl:ResUrl, type:uint)
		{
			_type = type;
			super(resUrl, false);
			frequency = SanguoDefine.CREATURE_PART_ANIM_FREQUENCY;
			_imgConfigVoTable = RookieEntry.resManager.getImgConfigVoTable(resUrl);
		}

		public function synAction(action:uint, direction:uint):void
		{
			_action = action;
			_imgConfigVO = _imgConfigVoTable.search(action);
			_totalFrame = _imgConfigVO.frameLength;
			synActDirNum();
			synDirection(direction);
		}

		public function synDirection(direction:uint):void
		{
			_direction = direction;
			synResDirAndReverse();
			synPlayRange();
			gotoAndPlay(_startFrame);
		}

		private function synResDirAndReverse():void
		{
			_resDir = DirectionEnum.DIRECTION_MAP[_resDirNum][_direction];
			_needYReverse = DirectionEnum.REVERSE_MAP[_resDirNum][_direction];
		}

		private function synPlayRange():void
		{
			var index:int;
			switch(_resDirNum)
			{
				case 2:
					index = DirectionEnum.TWO_DIRECTION.indexOf(_resDir);
					break;
				case 3:
					index = DirectionEnum.THREE_DIRECTION.indexOf(_resDir);
					break;
				case 5:
					index = DirectionEnum.FIVE_DIRECTION.indexOf(_resDir);
					break;
			}
			_startFrame = index * _eachDirFrameNum + 1;
			_endFrame = _startFrame + _eachDirFrameNum - 1;
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
		
		override protected function onImgDataLoaded():void
		{
			var items:Dictionary = _imgConfigVoTable.content;
			for (var i : * in items)
			{
				var vo:ImgConfigVO = items[i];
				var frameLength:uint = vo.frameLength;
				for (var j:int = 0;j < frameLength;j++)
				{
					var frame:ImgFrameConfigVO = vo.getFrame(j);
					frame.manualSetResCls(getResCls(i, j));
				}
			}
		}

		override protected function setCurFrameBmd():void
		{
			_curFrameVO = _imgConfigVO.getFrame(_curFrame - 1);
			if (_curFrameVO)
			{
				super.bitmapData = _needYReverse ? _curFrameVO.yReverseBitmapData : _curFrameVO.bitmapData;
				adjustInnerPos();
			}
		}

		override protected function adjustInnerPos():void
		{
			var xVal:Number = _curFrameVO.adjustX;
			var yVal:Number = _curFrameVO.adjustY + SanguoDefine.CREATURE_PART_ANIM_Y_OFFSET;
			if (_needYReverse)
			{
				xVal = - xVal - _curFrameVO.validRectWidth;
			}
			hardSetPos(xVal, yVal);
		}

		private function getResCls(actionId:uint, index:uint):Class
		{
			var clsName:String = "bmd_" + _resUrl.packId + "_" + _resUrl.fileName + "_" + actionId + "_" + index;
			var resCls:Class;
			if (ApplicationDomain.currentDomain.hasDefinition(clsName))
			{
				resCls = getDefinitionByName(clsName) as Class;
			}
			return resCls;
		}

		public function get type():uint
		{
			return _type;
		}

		public function get depth():uint
		{
			return _depth;
		}

		public function set depth(depth:uint):void
		{
			_depth = depth;
		}
	}
}
