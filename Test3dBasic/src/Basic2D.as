package
{
	import flash.display3D.Context3DVertexBufferFormat;

	import com.adobe.utils.PerspectiveMatrix3D;

	import flash.geom.Matrix3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display.Bitmap;
	import flash.display3D.textures.Texture;
	import flash.display3D.Context3DProgramType;

	import com.adobe.utils.AGALMiniAssembler;

	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;

	import com.adobe.utils.Stats;

	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * @author Warmly
	 */
	[SWF(backgroundColor="#ffffff", frameRate="60", width="800", height="600")]
	public class Basic2D extends Sprite
	{
		[Embed(source="art/map.jpg")]
		private var bmdClass:Class;
		//
		private static const SWF_WIDTH:int = 800;
		private static const SWF_HEIGHT:int = 600;
		private var _context3D:Context3D;
		private var _vertexData:Vector.<Number>;
		private var _indexData:Vector.<uint>;
		private var _vertexBuffer:VertexBuffer3D;
		private var _indexBuffer:IndexBuffer3D;
		private var _shader:Program3D;
		private var _texture:Texture;
		private var _mMatrix:Matrix3D = new Matrix3D();
		private var _vMatrix:Matrix3D = new Matrix3D();
		private var _pMatrix:PerspectiveMatrix3D = new PerspectiveMatrix3D();
		private var _mvpMatrix:Matrix3D = new Matrix3D();

		public function Basic2D()
		{
			if (stage != null)
			{
				onAddToStage();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			}
		}

		private function onAddToStage(e:Event = null):void
		{
			if (hasEventListener(Event.ADDED_TO_STAGE))
			{
				removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			}

			stage.frameRate = 60;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			addChild(new Stats());

			stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
			stage.stage3Ds[0].requestContext3D();
		}

		private function onContext3DCreate(e:Event):void
		{
			if (hasEventListener(Event.ENTER_FRAME))
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}

			_context3D = (e.target as Stage3D).context3D;

			if (_context3D == null)
			{
				return;
			}

			_context3D.enableErrorChecking = true;

			initData();
			initBuffer();
			initShaders();
			initTexture();
			initCamera();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function initData():void
		{
			_vertexData = Vector.<Number>([//
			// x, y, u, v
			-1, 1, 0, 0,
			// 
			1, 1, 1, 0,
			// 
			1, -1, 1, 1,
			// 
			-1, -1, 0, 1]);

			_indexData = Vector.<uint>([//
			//
			0, 1, 2,
			// 
			2, 3, 0]);
		}

		private function initBuffer():void
		{
			_context3D.configureBackBuffer(SWF_WIDTH, SWF_HEIGHT, 0, true);

			_vertexBuffer = _context3D.createVertexBuffer(_vertexData.length / 4, 4);
			_vertexBuffer.uploadFromVector(_vertexData, 0, _vertexData.length / 4);

			_indexBuffer = _context3D.createIndexBuffer(_indexData.length);
			_indexBuffer.uploadFromVector(_indexData, 0, _indexData.length);
		}

		private function initShaders():void
		{
			var vAssembler1:AGALMiniAssembler = new AGALMiniAssembler();
			vAssembler1.assemble(Context3DProgramType.VERTEX, 
			// pos 
			"m44 op, va0, vc0\n" +
			// uv 
			"mov v1, va1\n");

			var fAssembler1:AGALMiniAssembler = new AGALMiniAssembler();
			fAssembler1.assemble(Context3DProgramType.FRAGMENT, 
			// 
			"tex oc, v1, fs0 <2d,repeat,nomeap>\n");

			_shader = _context3D.createProgram();
			_shader.upload(vAssembler1.agalcode, fAssembler1.agalcode);
		}

		private function initTexture():void
		{
			var bmp:Bitmap = new bmdClass();
			_texture = _context3D.createTexture(bmp.width, bmp.height, Context3DTextureFormat.BGRA, false);
			_texture.uploadFromBitmapData(bmp.bitmapData);
		}

		private function initCamera():void
		{
			_vMatrix.identity();
			_pMatrix.identity();
		}
		
		private static const SCREEN_X:int = 400;
		private static const SCREEN_Y:int = 200;

		private function onEnterFrame(e:Event):void
		{
			_context3D.clear(255, 255, 255);

			// _context3D.setBlendFactors(sourceFactor, destinationFactor)

			// 设置fs0
			_context3D.setTextureAt(0, _texture);

			_context3D.setProgram(_shader);

			_mvpMatrix.identity();
			_mvpMatrix.appendScale(256 / SWF_WIDTH, 256 / SWF_HEIGHT, 1);
			var xVal:Number = (SCREEN_X - SWF_WIDTH * 0.5) / SWF_WIDTH * 2;
			var yVal:Number = (SWF_HEIGHT * 0.5 - SCREEN_Y) / SWF_HEIGHT * 2;
			//_mvpMatrix.appendTranslation(xVal, yVal, 0);

			// 设置vc0 
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _mvpMatrix, true);

			// 设置va0,va1
			_context3D.setVertexBufferAt(0, _vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
			_context3D.setVertexBufferAt(1, _vertexBuffer, 2, Context3DVertexBufferFormat.FLOAT_2);

			_context3D.drawTriangles(_indexBuffer, 0, _indexData.length / 3);

			_context3D.present();
		}
	}
}
