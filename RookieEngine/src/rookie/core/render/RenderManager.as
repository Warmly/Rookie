package rookie.core.render
{
	import rookie.namespace.Rookie;

	import flash.utils.Dictionary;

	import rookie.core.IMainLoop;

	/**
	 * @author Warmly
	 */
	public class RenderManager implements IMainLoop
	{
		public static const FRAME_RATE:Number = 30;
		private var _renderQueue:Dictionary = new Dictionary();

		public function onEnterFrame():void
		{
			for each (var i : IRenderItem in _renderQueue)
			{
				i.render();
			}
		}

		Rookie function addToQueue(renderItem:IRenderItem):void
		{
			if (!_renderQueue[renderItem.key])
			{
				_renderQueue[renderItem.key] = renderItem;
			}
		}

		Rookie function dispose(renderItem:IRenderItem):void
		{
			if (_renderQueue[renderItem.key])
			{
				_renderQueue[renderItem.key] = null;
				delete _renderQueue[renderItem.key];
			}
		}
	}
}
