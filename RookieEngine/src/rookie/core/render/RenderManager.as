package rookie.core.render
{
	import rookie.core.IMainLoop;

	/**
	 * @author Warmly
	 */
	public class RenderManager implements IMainLoop
	{
		private var _renderQueue : Vector.<IRenderItem> = new Vector.<IRenderItem>();

		public function onEnterFrame() : void
		{
			for each (var i : IRenderItem in _renderQueue)
			{
				i.render();
			}
		}
	}
}
