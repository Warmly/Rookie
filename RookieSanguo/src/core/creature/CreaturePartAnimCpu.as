package core.creature
{
	import flash.utils.Dictionary;
	import rookie.dataStruct.HashTable;
	import definition.Define;
	import definition.ActionEnum;
	import definition.DirectionEnum;

	import global.ModelEntry;

	import rookie.core.render.AnimCpu;
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
		private var _action:uint = ActionEnum.DEFAULT;
		// 动作方向
		private var _direction:uint = DirectionEnum.DEFAULT;
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
			_imgConfigVoTable = RookieEntry.resManager.getImgConfigVoTable(resUrl);
			synAction(ActionEnum.DEFAULT);
		}

		public function synAction(action:uint):void
		{
			if (action != _action)
			{
				_action = action;
				_imgConfigVO = _imgConfigVoTable.search(action);
				_totalFrame = _imgConfigVO.frameLength;
				synActDirNum();
				synDirection(_direction);
			}
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
			_needYReverse = false;
			var resDir:uint;
			switch(_direction)
			{
				case DirectionEnum.UP:
					if (_resDirNum == 2 || _resDirNum == 3)
					{
						resDir = DirectionEnum.RIGHT_UP;
						_needYReverse = true;
					}
					else
					{
						resDir = DirectionEnum.UP;
					}
					break;
				case DirectionEnum.RIGHT_UP:
					resDir = DirectionEnum.RIGHT_UP;
					break;
				case DirectionEnum.RIGHT:
					if (_resDirNum == 2)
					{
						resDir = DirectionEnum.RIGHT_DOWN;
					}
					else
					{
						resDir = DirectionEnum.RIGHT;
					}
					break;
				case DirectionEnum.RIGHT_DOWN:
					resDir = DirectionEnum.RIGHT_DOWN;
					break;
				case DirectionEnum.DOWN:
					if (_resDirNum == 2 || _resDirNum == 3)
					{
						resDir = DirectionEnum.RIGHT_DOWN;
						_needYReverse = true;
					}
					else
					{
						resDir = DirectionEnum.DOWN;
					}
					break;
				case DirectionEnum.LEFT_DOWN:
					resDir = DirectionEnum.RIGHT_DOWN;
					_needYReverse = true;
					break;
				case DirectionEnum.LEFT:
					if (_resDirNum == 2)
					{
						resDir = DirectionEnum.RIGHT_DOWN;
					}
					else
					{
						resDir = DirectionEnum.RIGHT;
					}
					_needYReverse = true;
					break;
				case DirectionEnum.LEFT_UP:
					resDir = DirectionEnum.RIGHT_UP;
					_needYReverse = true;
					break;
			}
			_resDir = resDir;
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
					var frame:ImgFrameConfigVO = vo.getFrames(j);
					frame.manualSetResCls(getResCls(i, j));
				}
			}
		}

		override protected function setCurFrameBmd():void
		{
			_curFrameVO = _imgConfigVO.getFrames(_curFrame - 1);
			if (_curFrameVO)
			{
				super.bitmapData = _needYReverse ? _curFrameVO.yReverseBitmapData : _curFrameVO.bitmapData;
				adjustInnerPos();
			}
		}

		// 待优化
		override protected function adjustInnerPos():void
		{
			var xVal:Number = -_curFrameVO.imgWidth * 0.5 + _curFrameVO.validRectX;
			var yVal:Number = -_curFrameVO.imgHeight * 0.5 + _curFrameVO.validRectY + Define.CREATURE_PART_ANIM_Y_OFFSET;
			if (_needYReverse)
			{
				xVal = -xVal - _curFrameVO.validRectWidth;
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
