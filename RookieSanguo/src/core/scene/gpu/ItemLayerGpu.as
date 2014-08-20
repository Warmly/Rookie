package core.scene.gpu 
{
	import core.creature.gpu.CreatureGpu;
	import core.creature.gpu.UserGpu;
	import core.scene.ISceneObj;
	import rookie.core.render.IRenderItem;
	import rookie.definition.RenderEnum;
	import rookie.tool.namer.namer;
	/**
	 * ...
	 * @author Warmly
	 */
	public class ItemLayerGpu implements IRenderItem
	{
		private var _itemsRef:Vector.<ISceneObj> = new Vector.<ISceneObj>();
		
		public function ItemLayerGpu() 
		{
		}
		
		public function addUser(user:UserGpu):void
		{
			_itemsRef.push(user);
		}
		
		public function render():void
		{
			updateDepth();
			for each (var item:ISceneObj in _itemsRef) 
			{
				if (item is CreatureGpu)
				{
					(item as CreatureGpu).render();
				}
			}
		}

		public function get key():String
		{
			return namer("SanguoScene", "ItemLayerGpu");
		}
		
		public function get renderType():int
		{
			return RenderEnum.GPU;
		}
		
		public function updateDepth():void
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