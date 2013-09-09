package
{
	import away3d.loaders.parsers.Parsers;
	import flash.events.Event;

	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;

	import flash.display.Sprite;

	public class Away3dTest extends Sprite
	{
		private var _view : View3D;

		public function Away3dTest()
		{
			_view = new View3D();
			_view.backgroundColor = 0x666666;
			_view.antiAlias = 4;
			addChild(_view);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			Parsers.enableAllBundled();
			
			
			
			
			
			
			
			
			
			
			
			
			

			// 创建一个长宽高都为500的立方体数据

			var cubeGeometry : CubeGeometry = new CubeGeometry(500, 500, 500);

			// 创建一个单色的贴图(材质)

			var cubeMaterial : ColorMaterial = new ColorMaterial(0xFF0000);

			// 创建一个可视的Mesh对象,并设置形状数据和贴图

			var cubeMesh : Mesh = new Mesh(cubeGeometry, cubeMaterial);

			// 将mesh添加到舞台上

			_view.scene.addChild(cubeMesh);

			// 移动风景中的物体

			cubeMesh.z += 100;

			// 移动镜头,或是说移动你的眼睛....

			_view.camera.z = 100;
		}

		private function onEnterFrame(e : Event) : void
		{
			_view.render();
		}
	}
}
