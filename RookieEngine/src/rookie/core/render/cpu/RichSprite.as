package rookie.core.render.cpu
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;

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
			if (prt)
			{
				prt.addChild(this);
			}
		}

		public function deleteParent():void
		{
			if (parent)
			{
				parent.removeChild(this);
			}
		}
		
		public function setPosition(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		}
		
		public function get position():Point 
		{
			return new Point(this.x, this.y);
		}
		
		public function set position(value:Point):void 
		{
			this.x = value.x;
			this.y = value.y;
		}
	}
}
