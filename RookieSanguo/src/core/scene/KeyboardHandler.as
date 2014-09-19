package core.scene 
{
	import core.creature.cpu.UserCpu;
	import core.creature.UserVO;
	import definition.ActionEnum;
	import definition.DirectionEnum;
	import definition.SanguoDefine;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import global.ManagerEntry;
	import global.ModelEntry;
	import global.SanguoEntry;
	import rookie.core.resource.ResUrl;
	import rookie.tool.math.RookieMath;
	import tool.CastAnimTool;
	import tool.CoorTool;
	import tool.UserFactory;
	/**
	 * ...
	 * @author Warmly
	 */
	public class KeyboardHandler 
	{
		private var _stage:Stage;
		
		public function KeyboardHandler() 
		{
		}
		
		public function init(stage:Stage):void
		{
			_stage = stage;
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			switch(e.keyCode)
			{
				case Keyboard.W:
					break;
				case Keyboard.A:
					break;
				case Keyboard.S:
					break;
				case Keyboard.D:
					break;
				case Keyboard.SPACE:
					break;
				case Keyboard.T:
					addTestUser();
					break;
				case Keyboard.E:
					addTestEffect();
					break;
			}
		}
		
		private function addTestEffect():void 
		{
			var myCellPosX:int = SanguoEntry.myselfVO.cellX;
			myCellPosX = RookieMath.randomInt(myCellPosX - 10, myCellPosX + 10);
			var myCellPosY:int = SanguoEntry.myselfVO.cellY;
			myCellPosY = RookieMath.randomInt(myCellPosY - 10, myCellPosY + 10);
			var pt:Point = CoorTool.cellToScene(myCellPosX, myCellPosY);
			if (SanguoDefine.GPU_RENDER_SCENE)
			{
				CastAnimTool.castAnimGpuToScene(new ResUrl(310, 1, 1005), pt.x, pt.y);
			}
			else
			{
				CastAnimTool.castAnimCpuToScene(new ResUrl(310, 1, 1005), pt.x, pt.y);
			}
		}
		
		private function addTestUser():void
		{
			var id:Number = RookieMath.randomInt(1, 10000);
			if (!ModelEntry.userModel.hasUser(id))
			{
				var myCellPosX:int = SanguoEntry.myselfVO.cellX;
				var myCellPosY:int = SanguoEntry.myselfVO.cellY;
				var user:* = SanguoDefine.GPU_RENDER_SCENE?UserFactory.getTestUserGpu():UserFactory.getTestUserCpu();
				user.synCellPos(RookieMath.randomInt(myCellPosX - 10, myCellPosX + 10), RookieMath.randomInt(myCellPosY - 10, myCellPosY + 10))
				user.synPixelPosByCurCellPos();
				user.synDepthByCurCellPos();
				user.userVO.id = id;
				ModelEntry.userModel.addUser(user.userVO);
				if (SanguoDefine.GPU_RENDER_SCENE)
				{
					ManagerEntry.sceneManager.addUserGpu(user);
				}
				else
				{
					ManagerEntry.sceneManager.addUserCpu(user);
				}
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
		}
	}
}