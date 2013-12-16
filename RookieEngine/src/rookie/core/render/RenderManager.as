package rookie.core.render
{
	import flash.utils.Dictionary;
	import rookie.dataStruct.HashTable;
	import rookie.namespace.Rookie;

	import rookie.core.IMainLoop;

	/**
	 * @author Warmly
	 */
	public class RenderManager implements IMainLoop
	{
		public static const FRAME_RATE:Number = 30;
		private var _renderQueue:HashTable = new HashTable(String, IRenderItem);

		public function onEnterFrame():void
		{
			var items:Dictionary = _renderQueue.content;
			for each (var i : IRenderItem in items)
			{
				i.render();
			}
		}

		Rookie function addToQueue(renderItem:IRenderItem):void
		{
			if(!_renderQueue.has(renderItem.key))
			{
				_renderQueue.insert(renderItem.key, renderItem);
			}
		}

		Rookie function removeFromQueue(renderItem:IRenderItem):void
		{
			_renderQueue.del(renderItem.key);
		}
		
		Rookie function isInRenderQueue(renderItem:IRenderItem):Boolean
		{
			return _renderQueue.has(renderItem.key);
		}
	}
}
