package rookie.core.render.gpu.base 
{
	import rookie.namespace.Rookie;
	import com.adobe.utils.AGALMiniAssembler;
	import flash.display3D.Context3D;
	import flash.display3D.Program3D;
	import rookie.global.RookieEntry;
	use namespace Rookie;
	/**
	 * ...
	 * @author Warmly
	 */
	public class RookieShader 
	{
		private var _vertexAssembler:AGALMiniAssembler;
		private var _fragmentAssembler:AGALMiniAssembler;
		private var _shader:Program3D;
		private var _context3D:Context3D;
		
		public function RookieShader() 
		{
			_context3D = RookieEntry.renderManager.context3D;
			_shader = _context3D.createProgram();
		}
		
		public function upload():void
		{
			_shader.upload(_vertexAssembler.agalcode, _fragmentAssembler.agalcode);
		}
		
		public function set vertexAssembler(value:AGALMiniAssembler):void 
		{
			_vertexAssembler = value;
		}
		
		public function set fragmentAssembler(value:AGALMiniAssembler):void 
		{
			_fragmentAssembler = value;
		}
		
		public function get shader():Program3D 
		{
			return _shader;
		}
	}
}