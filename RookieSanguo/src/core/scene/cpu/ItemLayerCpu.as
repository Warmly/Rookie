package core.scene.cpu 
{
	import core.creature.cpu.UserCpu;
	import core.scene.ISceneObj;
	import flash.display.DisplayObject;
	import rookie.core.render.cpu.IParent;
	import rookie.core.render.cpu.RichSprite;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class ItemLayerCpu extends RichSprite 
	{
		private var _itemsRef:Vector.<ISceneObj> = new Vector.<ISceneObj>();
		
		public function ItemLayerCpu() 
		{
		}
		
		public function addUser(user:UserCpu):void
		{
			_itemsRef.push(user);
			user.parent = this;
		}
		
		public function updateDepth():void
		{
			_itemsRef.sort(sortByDepth);
			var num:int = _itemsRef.length;
			for (var i:int = 0; i < num; i++) 
			{
				var item:ISceneObj = _itemsRef[i];
				(item as IParent).parent = this;
			}
		}
		
		private function sortByDepth(a:UserCpu, b:UserCpu):int
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