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
	import rookie.tool.objectPool.IObjPoolItem;
	
	/**
	 * Layer of items, including creatures, effects and items
	 * @author Warmly
	 */
	public class ItemLayerCpu extends RichSprite
	{
		private var _itemsRef:Vector.<ISceneObj> = new Vector.<ISceneObj>();
		private var _camera:SanguoCamera;
		
		public function ItemLayerCpu() 
		{
			_camera = SanguoEntry.camera;
		}
		
		public function addUser(user:UserCpu):void
		{
			_itemsRef.push(user);
			user.parent = this;
		}
		
		public function addSceneAnim(anim:SceneAnimCpu):void
		{
			_itemsRef.push(anim);
			anim.parent = this;
		}
		
		public function render():void
		{
			filterRef();
			updateDepth();
			for each (var item:ISceneObj in _itemsRef) 
			{
				item.render();
			}
		}
		
		private function filterRef():void
		{
			_itemsRef = _itemsRef.filter(function(item:ISceneObj, index:int, vec:Vector.<ISceneObj>):Boolean
			{
				if (item is IObjPoolItem && !(item as IObjPoolItem).disposed)
				{
					return true;
				}
				return false;
			});
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