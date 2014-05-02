package rookie.core.render.gpu.factory 
{
	import com.adobe.utils.AGALMiniAssembler;
	import flash.display3D.Context3DProgramType;
	import rookie.core.render.gpu.base.RookieShader;

	/**
	 * ...
	 * @author Warmly
	 */
	public class RookieShaderFactory 
	{
		public function RookieShaderFactory() 
		{
		}
		
		public static function createBasicShader():RookieShader
		{
			var shader:RookieShader = new RookieShader();
			var vAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			vAssembler.assemble(Context3DProgramType.VERTEX,
			//pos
			"m44 op va0 vc0\n" +
			//uv
			"mov v1 va1");
			var fAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			fAssembler.assemble(Context3DProgramType.FRAGMENT,
			//
			"tex oc, v1, fs0 <2d,repeat,nomeap>");
			shader.vertexAssembler = vAssembler;
			shader.fragmentAssembler = fAssembler;
			shader.upload();
			return shader;
		}
	}
}