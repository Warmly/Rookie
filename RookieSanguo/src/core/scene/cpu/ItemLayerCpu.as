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
			for each (var item:ISceneObj in ISceneObj) 
			{
				if (item is IParent)
				{
					(item as IParent).parent = this;
				}
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
				return 0;
			}
			else
			{
				return 1;
			}
		}
	}
}