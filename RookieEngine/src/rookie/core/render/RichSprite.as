package rookie.core.render
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
			if(parent)
			{
				if(parent == prt)
				{
					return;
				}
				else
				{
					parent.removeChild(this);
				}
			}
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
