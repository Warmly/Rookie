package rookie.core.render
{
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import rookie.dataStruct.HashTable;
	import rookie.namespace.Rookie;
	import rookie.tool.log.error;

	import rookie.core.IMainLoop;

	/**
	 * @author Warmly
	 */
	public class RenderManager implements IMainLoop
	{
		private var _renderQueue:HashTable = new HashTable(String, IRenderItem);
		private var _context3D:Context3D;
		private var _stage:Stage;
		
		public function init3DRenderComponent(stage:Stage):void
		{
			_stage = stage;
			_stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
		}

		public function onEnterFrame():void
		{
			var items:Dictionary = _renderQueue.content;
			for each (var i : IRenderItem in items)
			{
				i.render();
			}
		}

		private function onContext3DCreate(e:Event):void
		{
			_context3D = (e.target as Stage3D).context3D;
			
			if (!_context3D)
			{
				error("未获取到3D设备！");
				return;
			}
			
			_context3D.enableErrorChecking = true;
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
