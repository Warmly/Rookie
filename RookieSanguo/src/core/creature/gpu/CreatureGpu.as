package core.creature.gpu 
{
	import core.creature.ActProcess;
	import core.creature.CreatureVO;
	import core.scene.ISceneObj;
	import rookie.core.render.IRenderItem;
	import rookie.core.render.RenderType;
	import rookie.global.RookieEntry;
	import rookie.tool.math.RookieMath;
	import rookie.tool.namer.IName;
	import rookie.tool.namer.namer;
	import rookie.tool.objectPool.IObjPoolItem;
	import rookie.tool.objectPool.ObjectPool;
	/**
	 * ...
	 * @author Warmly
	 */
	public class CreatureGpu implements IObjPoolItem,IRenderItem,IName,ISceneObj
	{
		protected var _creatureVO:CreatureVO;
		protected var _partsContainer:CreaturePartsContainerGpu;
		protected var _action:uint;
		protected var _direction:uint;
		protected var _actProcess:ActProcess;
		protected var _name:String;
		protected var _x:Number;
		protected var _y:Number;
		protected var _depth:uint;
		
		public function CreatureGpu() 
		{
			_partsContainer = new CreaturePartsContainerGpu();
		}
		
		/**
	     * 动作改变
		 * @loop 播放次数，默认0为一直循环播放 
	     */
		public function synAction(action:uint, direction:uint = 0, loop:uint = 0):void
		{
			if (action && action != _action)
			{
				_action = action;
				if (direction)
				{
					_direction = direction;
				}
				_partsContainer.synAction(_action, _direction, loop);
			}
			else
			{
				synDirection(direction);
			}
		}
		
		/**
	     * 动作不变，方向改变
	     */
		public function synDirection(direction:uint):void
		{
			if (direction && direction != _direction)
			{
				_direction = direction;
				_partsContainer.synDirection(direction);
			}
		}
		
		public function render():void
		{
			_partsContainer.render();
		}
		
		public function get renderType():int
		{
			return RenderType.GPU;
		}
		
		public function get key():String
		{
			return namer("Creature Instance", name); 
		}
		
		public function get name():String 
		{
			if (!_name)
			{
				_name = "" + RookieMath.random();
			}
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get x():Number 
		{
			return _x;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function get depth():uint 
		{
			return _depth;
		}
		
		public function set depth(value:uint):void 
		{
			_depth = value;
		}
		
		public function reset():void
		{
			_action = 0;
			_direction = 0;
			_partsContainer.reset();
		}
		
		public function dispose():void
		{
			ObjectPool.addToPool(this);
		}
		
		/**
		 * 仅用于调试，慎用！
		 */
	    public function selfStartRender():void
	    {
		    RookieEntry.renderManager.addToGpuRenderQueue(this);
			startPlay();
	    }
		
		public function startPlay():void 
		{
			_partsContainer.startPlay();
		}
	}
}