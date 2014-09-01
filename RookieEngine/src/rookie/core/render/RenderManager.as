package rookie.core.render
{
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DCompareMode;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.utils.Dictionary;
	import rookie.core.render.gpu.base.RookieIndexBuffer;
	import rookie.core.render.gpu.base.RookieShader;
	import rookie.core.render.gpu.base.RookieTexture;
	import rookie.core.render.gpu.base.RookieVertexBuffer;
	import rookie.core.render.gpu.blend.RookieBlendMode;
	import rookie.core.render.gpu.factory.RookieBufferFactory;
	import rookie.core.render.gpu.factory.RookieRenderFactory;
	import rookie.core.render.gpu.factory.RookieShaderFactory;
	import rookie.tool.functionHandler.FunHandler;
	import rookie.dataStruct.HashTable;
	import rookie.definition.RookieDefine;
	import rookie.namespace.Rookie;
	import rookie.tool.log.error;
	import rookie.tool.log.log;

	import rookie.core.IMainLoop;

	/**
	 * 渲染管理(2D/3D)
	 * @author Warmly
	 */
	public class RenderManager implements IMainLoop
	{
		//CPU渲染队列
		private var _cpuRenderQueue:HashTable = new HashTable(String, IRenderItem);
		//GPU渲染队列
		private var _gpuRenderQueue:Vector.<IRenderItem> = new Vector.<IRenderItem>();
		private var _context3D:Context3D;
		private var _stage:Stage;
		//后台缓冲区宽高
		private var _backBufferWidth:Number = 0;
		private var _backBufferHeight:Number = 0;
		//当前着色器
		private var _curShader:RookieShader;
		//当前顶点
		private var _curVertexBuffer:RookieVertexBuffer;
		//当前索引
		private var _curIndexBuffer:RookieIndexBuffer;
		//当前渲染位置
		private var _curRenderPosX:Number = 0;
		private var _curRenderPosY:Number = 0;
		//当前贴图
		private var _curTexture:RookieTexture;
		//当前镜头矩阵
		private var _curCameraMatrix:Matrix3D = new Matrix3D();
		//当前混合模式
		private var _curBlendMode:int;
		private var _3DRenderComponentReady:Boolean;
		private var _3DRenderComponentReadyCallBack:FunHandler;
		
		public function init3DRenderComponent(stage:Stage, callBack:FunHandler):void
		{
			_stage = stage;
			_3DRenderComponentReadyCallBack = callBack;
			_stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
			_stage.stage3Ds[0].requestContext3D();
			_curCameraMatrix.identity();
		}
		
		private function onContext3DCreate(e:Event):void
		{
			_context3D = (e.target as Stage3D).context3D;
			
			if (_context3D)
			{
				log("3D device ready!");
			}
			else
			{
				error("3D device not found!");
				return;
			}
			
			_3DRenderComponentReady = true;
			_3DRenderComponentReadyCallBack.execute();
			_context3D.enableErrorChecking = true;
		}

		public function onEnterFrame():void
		{
			GpuRender();
			CpuRender();
		}
		
		private function GpuRender():void 
		{
			if (_3DRenderComponentReady)
			{
				clear();
				Gpu3DRender();
				Gpu2DRender();
				_context3D.present();
			}
		}
		
		private function Gpu3DRender():void 
		{
		}
		
		private function Gpu2DRender():void 
		{
			for each (var item:IRenderItem in _gpuRenderQueue) 
			{
				item.render();
			}
		}
		
		private function CpuRender():void 
		{
			var items:Dictionary = _cpuRenderQueue.content;
			for each (var i : IRenderItem in items)
			{
				i.render();
			}
		}
		
		public function configBackBuffer(width:Number, height:Number, antiAlias:int = 0, enableDepthAndStencil:Boolean = false):void
		{
			if (!_context3D)
			{
				error("未获取到3D设备！");
				return;
			}
			if (width >= RookieDefine.MIN_BACK_BUFFER_SIZE && height >= RookieDefine.MIN_BACK_BUFFER_SIZE)
			{
				if (width != _backBufferWidth || height != _backBufferHeight)
				{
					_backBufferWidth = width;
					_backBufferHeight = height;
					_context3D.configureBackBuffer(width, height, antiAlias, enableDepthAndStencil);
				}
			}
		}
		
		public function clear():void
		{
			_context3D.clear(255, 255, 255);
		}
		
		public function setBlendMode(mode:int):void
		{
			_curBlendMode = mode;
			var src:String = RookieBlendMode.BLEND_MODES[mode][0];
			var dst:String = RookieBlendMode.BLEND_MODES[mode][1];
			_context3D.setBlendFactors(src, dst);
		}
		
		public function setDepthTest(depthMask:Boolean = true, passCompareMode:String = Context3DCompareMode.ALWAYS):void
		{
			_context3D.setDepthTest(depthMask, passCompareMode);
		}
		
		public function setVertexBuffer(buffer:RookieVertexBuffer):void
		{
			_curVertexBuffer = buffer;
			_context3D.setVertexBufferAt(0, buffer.buffer, 0, Context3DVertexBufferFormat.FLOAT_2);
			_context3D.setVertexBufferAt(1, buffer.buffer, 2, Context3DVertexBufferFormat.FLOAT_2);
		}
		
		public function setIndexBuffer(buffer:RookieIndexBuffer):void
		{
			_curIndexBuffer = buffer;
		}
		
		public function setShader(shader:RookieShader):void
		{
			_curShader = shader;
			_context3D.setProgram(shader.shader);
		}
		
		public function setTextureAt(sampler:int, texture:RookieTexture):void
		{
			_curTexture = texture;
			_context3D.setTextureAt(sampler, texture.texture);
		}
		
		public function setRenderPos(x:Number, y:Number, width:Number, height:Number):void
		{
			_curRenderPosX = x;
			_curRenderPosY = y;
			_curCameraMatrix.identity();
			//缩放到贴图实际大小
			_curCameraMatrix.appendScale(width/_backBufferWidth, height/_backBufferHeight, 1);
			//对准位置
			var xValue:Number = (x - _backBufferWidth * 0.5 + _curTexture.width * 0.5) / _backBufferWidth * 2;
			var yValue:Number = (_backBufferHeight * 0.5 - y - _curTexture.height * 0.5) / _backBufferHeight * 2;
			_curCameraMatrix.appendTranslation(xValue, yValue, 0);
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _curCameraMatrix, true);
		}
		
		public function draw():void
		{
			_context3D.drawTriangles(_curIndexBuffer.buffer, 0, _curIndexBuffer.length / 3);
		}
		
		public function addToGpuRenderQueue(renderItem:IRenderItem):void
		{
			_gpuRenderQueue.push(renderItem);
		}
		
		public function removeFromGpuRenderQueue(renderItem:IRenderItem):void
		{
		}
		
		public function addToCpuRenderQueue(renderItem:IRenderItem):void
		{
			_cpuRenderQueue.insert(renderItem.key, renderItem);
		}

		public function removeFromCpuRenderQueue(renderItem:IRenderItem):void
		{
			_cpuRenderQueue.del(renderItem.key);
		}
		
		public function get context3D():Context3D 
		{
			return _context3D;
		}
	}
}
