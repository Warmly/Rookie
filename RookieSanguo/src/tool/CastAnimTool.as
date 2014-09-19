package tool 
{
	import core.scene.cpu.SceneAnimCpu;
	import core.scene.gpu.SceneAnimGpu;
	import flash.geom.Point;
	import global.ManagerEntry;
	import rookie.core.resource.ResUrl;
	import rookie.tool.functionHandler.fh;
	
	/**
	 * A tool to cast anim
	 * @author Warmly
	 */
	public class CastAnimTool 
	{
		/**
		 * Cast anim based on CPU rendering to scene 
		 * @param	resUrl
		 * @param	x         scene pos x
		 * @param	y         scene pos y
		 * @param	loop
		 * @return
		 */
		public static function castAnimCpuToScene(resUrl:ResUrl, x:Number, y:Number, loop:int = 1):SceneAnimCpu
		{
			var anim:SceneAnimCpu = new SceneAnimCpu(resUrl);
			anim.loop = loop;
			anim.x = x;
			anim.y = y;
			anim.loopEndCallBack = fh(function():void
			{
				anim.dispose();
			});
			ManagerEntry.sceneManager.addSceneAnimCpu(anim);
			return anim;
		}
		
		/**
		 * Cast anim based on GPU rendering to scene
		 * @param	resUrl
		 * @param	x         scene pos x
		 * @param	y         scene pos y
		 * @param	loop
		 * @return
		 */
		public static function castAnimGpuToScene(resUrl:ResUrl, x:Number, y:Number, loop:int = 1):SceneAnimGpu
		{
			var cameraPos:Point = CoorTool.sceneToCamera(x, y);
			var anim:SceneAnimGpu = new SceneAnimGpu(resUrl);
			anim.loop = loop;
			anim.x = cameraPos.x;
			anim.y = cameraPos.y;
			anim.loopEndCallBack = fh(function():void
			{
				anim.dispose();
			});	
			ManagerEntry.sceneManager.addSceneAnimGpu(anim);
			return anim;
		}
		
		public static function castAnimCpuToUI():void
		{
		}
	}
}