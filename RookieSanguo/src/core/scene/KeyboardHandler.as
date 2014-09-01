package core.scene 
{
	import core.creature.cpu.UserCpu;
	import core.creature.UserVO;
	import definition.ActionEnum;
	import definition.DirectionEnum;
	import definition.SanguoDefine;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import global.ManagerEntry;
	import global.ModelEntry;
	import global.SanguoEntry;
	import rookie.tool.math.RookieMath;
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
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
		}
		
		private function addTestUser():void
		{
			var id:Number = RookieMath.randomInt(1, 10000);
			if (!ModelEntry.userModel.hasUser(id))
			{
				var user:* = SanguoDefine.GPU_RENDER_SCENE?UserFactory.getTestUserGpu():UserFactory.getTestUserCpu();
				user.synCellPos(RookieMath.randomInt(30, 50), RookieMath.randomInt(30, 50))
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
	}
}