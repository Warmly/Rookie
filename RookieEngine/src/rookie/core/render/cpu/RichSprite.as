package rookie.core.render.cpu
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	/**
	 * @author Warmly
	 */
	public class RichSprite extends Sprite implements IParent
	{
		public function RichSprite()
		{
		}
		
		public function set parent(prt:DisplayObjectContainer):void
		{
			prt.addChild(this);
		}

		public function deleteParent():void
		{
			if (parent)
			{
				parent.removeChild(this);
			}
		}
	}
}
