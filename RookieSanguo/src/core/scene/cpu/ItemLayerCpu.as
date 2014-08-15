package core.scene.cpu 
{
	import core.creature.cpu.CreatureCpu;
	import core.creature.cpu.UserCpu;
	import core.scene.ISceneObj;
	import core.scene.SanguoCamera;
	import flash.display.DisplayObject;
	import global.SanguoEntry;
	import rookie.core.render.cpu.IParent;
	import rookie.core.render.cpu.RichSprite;
	import rookie.core.render.IRenderItem;
	import rookie.definition.RenderEnum;
	import rookie.tool.namer.namer;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ItemLayerCpu extends RichSprite implements IRenderItem
	{
		private var _itemsRef:Vector.<ISceneObj> = new Vector.<ISceneObj>();
		private var _camera:SanguoCamera;
		
		public function ItemLayerCpu() 
		{
			_camera =  SanguoEntry.camera;
		}
		
		public function addUser(user:UserCpu):void
		{
			_itemsRef.push(user);
			user.parent = this;
		}
		
		public function render():void
		{
			updateDepth();
			for each (var item:ISceneObj in _itemsRef) 
			{
				if (item is CreatureCpu)
				{
					(item as CreatureCpu).render();
				}
			}
			this.x = - _camera.xInScene;
			this.y = - _camera.yInScene;
		}
		
		public function get key():String
		{
			return namer("SanguoScene", "ItemLayerCpu");
		}
		
		public function get renderType():int
		{
			return RenderEnum.CPU;
		}
		
		private function updateDepth():void
		{
			_itemsRef.sort(sortByDepth);
			var num:int = _itemsRef.length;
			for (var i:int = 0; i < num; i++) 
			{
				var item:ISceneObj = _itemsRef[i];
				if (item is IParent)
				{
					(item as IParent).parent = this;
				}
			}
		}
		
		private function sortByDepth(a:ISceneObj, b:ISceneObj):int
		{
			if (a.depth < b.depth)
			{
				return -1;
			}
			else if (a.depth == b.depth)
			{
				if (a.id <= b.id)
				{
					return -1;
				}
				else
				{
					return 1;
				}
			}
			else
			{
				return 1;
			}
		}
	}
}