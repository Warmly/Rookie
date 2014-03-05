package rookie.tool.text 
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import rookie.core.render.IParent;
	
	/**
	 * ...
	 * @author Warmly
	 */
	public class RookieTextField extends TextField implements IParent 
	{
		public function RookieTextField() 
		{
		}
		
		public function set parent(prt:DisplayObjectContainer):void
		{
			if (parent)
			{
				if (parent == prt)
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