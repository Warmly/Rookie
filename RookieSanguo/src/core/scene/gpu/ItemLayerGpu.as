package core.scene.gpu 
{
	import core.creature.gpu.UserGpu;
	import core.scene.ISceneObj;
	import rookie.core.render.gpu.ImgGpuBase;
	import rookie.tool.objectPool.IObjPoolItem;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ItemLayerGpu
	{
		private var _itemsRef:Vector.<ISceneObj> = new Vector.<ISceneObj>();
		
		public function ItemLayerGpu() 
		{
		}
		
		public function addUser(user:UserGpu):void
		{
			_itemsRef.push(user);
		}
		
		public function addSceneAnim(anim:SceneAnimGpu):void
		{
			_itemsRef.push(anim);
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