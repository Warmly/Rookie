package core.creature.cpu
{
	import core.creature.ActProcess;
	import core.creature.CreatureVO;
	import core.scene.ISceneObj;
	import flash.geom.Point;
	import rookie.core.render.cpu.RichSprite;
	import definition.ActionEnum;
	import definition.DirectionEnum;
	import rookie.core.render.IRenderItem;
	import rookie.definition.RenderEnum;
	import rookie.global.RookieEntry;
	import rookie.tool.log.error;
	import rookie.tool.namer.namer;
	import tool.SanguoCoorTool;

	import rookie.tool.objectPool.IObjPoolItem;
	import rookie.tool.objectPool.ObjectPool;

	/**
	 * @author Warmly
	 */
	public class CreatureCpu extends RichSprite implements IObjPoolItem, ISceneObj, IRenderItem
	{
		protected var _creatureVO:CreatureVO;
		protected var _partsContainer:CreaturePartsContainerCpu;
		protected var _action:uint;
		protected var _direction:uint;
		protected var _actProcess:ActProcess;
		protected var _depth:uint;

		public function CreatureCpu()
		{
			_partsContainer = new CreaturePartsContainerCpu();
			_partsContainer.parent = this;
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
		
		public function synCellPos(cellX:int, cellY:int, synPixelPos:Boolean = false):void
		{
			_creatureVO.cellX = cellX;
			_creatureVO.cellY = cellY;
			if (synPixelPos)
			{
				synPixelPosByCurCellPos();
			}
		}
		
		public function synPixelPos(pixelX:Number, pixelY:Number):void
		{
			this.x = pixelX;
			this.y = pixelY;
		}
		
		public function synPixelPosByCurCellPos():void
		{
			var pt:Point = SanguoCoorTool.cellToScene(_creatureVO.cellX, _creatureVO.cellY);
			synPixelPos(pt.x, pt.y);
		}
		
		public function synDepthByCurCellPos():void
		{
			_depth = _creatureVO.cellY;
		}

		public function initActProcess():void
		{
			if (!_actProcess)
			{
				_actProcess = new ActProcess();
			}
		}
		
		public function clearActProcess():void
		{
			_actProcess = null;
		}
		
		public function get actProcess():ActProcess
		{
			return _actProcess;
		}

		public function reset():void
		{
			_action = 0;
			_direction = 0;
			_partsContainer.reset();
		}
		
		/**
		 * 仅用于调试，慎用！
		 */
	    public function selfStartRender():void
	    {
		    RookieEntry.renderManager.addToCpuRenderQueue(this);
	    }
		
		/**
		 * 由子类重写
		 */
		public function get key():String
		{
			error("Invalid call!");
			return "";
		}
		
		public function get renderType():int
		{
			return RenderEnum.CPU;
		}
		
		public function dispose():void
		{
			ObjectPool.addToPool(this);
		}

		public function get direction():uint
		{
			return _direction;
		}

		public function get action():uint
		{
			return _action;
		}
		
		public function get depth():uint 
		{
			return _depth;
		}
		
		public function set depth(value:uint):void 
		{
			_depth = value;
		}
		
		public function get id():Number 
		{
			return _creatureVO.id;
		}
	}
}
