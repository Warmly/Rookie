package rookie.tool.math
{
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;

	/**
	 * @author Warmly
	 */
	public class Coordinate3DUtil
	{
		/**
		 * 屏幕坐标系下一点的坐标，转换到xz平面上的一点的坐标
		 * @param x               屏幕坐标系下一点的x坐标（原点在屏幕左上角）
		 * @param y               屏幕坐标系下一点的y坐标
		 * @param cameraTransform 摄像机的仿射矩阵（包含平移，即摄像机坐标系的原点的世界坐标）
		 * @param visualAngle     视角（包括视平面上下两部分）
		 * @param isOrthographic  是否是正交投影（默认透视投影）
		 * 注：屏幕上一个像素代表世界坐标系下一个坐标
		 */
		public static function screenToWorldXZ(x : int, y : int, cameraTransform : Matrix3D, screenWidth : int, screenHeight : int, visualAngle : Number = 0, isOrthographic : Boolean = false) : Vector3D
		{
			var pointAtScreenInWorld : Vector3D = screenToWorld(x, y, cameraTransform, screenWidth, screenHeight, visualAngle, isOrthographic);
			var ray : Vector3D;
			if (isOrthographic)
			{
				ray = new Vector3D();
				cameraTransform.copyColumnTo(2, ray);
			}
			else
			{
				var focusPosInWorld : Vector3D = new Vector3D();
				cameraTransform.copyColumnTo(3, focusPosInWorld);
				ray = pointAtScreenInWorld.subtract(focusPosInWorld);
			}
			var temp : Number = -(Vector3D.Y_AXIS.dotProduct(pointAtScreenInWorld));
			var temp1 : Number = Vector3D.Y_AXIS.dotProduct(ray);
			ray.scaleBy(temp / temp1);
			var result : Vector3D = pointAtScreenInWorld.add(ray);
			return result;
		}

		/**
		 * 屏幕坐标系下一点的坐标，
		 * 先转换到摄像机坐标系下一点的坐标，
		 * 再转换到世界坐标系内的坐标（理解这一点在近裁剪面上）
		 * @param x               屏幕坐标系下一点的x坐标（原点在屏幕左上角）
		 * @param y               屏幕坐标系下一点的y坐标
		 * @param cameraTransform 摄像机的仿射矩阵（包含平移，即摄像机坐标系的原点的世界坐标）
		 * @param visualAngle     视角（包括视平面上下两部分）
		 * @param isOrthographic  是否是正交投影（默认透视投影）
		 * 注：屏幕上一个像素代表世界坐标系下一个坐标
		 */
		public static function screenToWorld(x : int, y : int, cameraTransform : Matrix3D, screenWidth : int, screenHeight : int, visualAngle : Number = 0, isOrthographic : Boolean = false) : Vector3D
		{
			var screenCenterX : int = screenWidth / 2;
			var screenCenterY : int = screenHeight / 2;
			var offX : int = x - screenCenterX;
			var offY : int = screenCenterY - y;
			if (!isOrthographic)
			{
				// 一半视角的余切
				var yCotValue : Number = 1 / Math.tan(visualAngle * Math.PI / 360);
				var focusDistance : int = screenHeight * 0.5 * yCotValue;
			}
			var posInCamera : Vector3D = new Vector3D(offX, offY, isOrthographic ? 0 : focusDistance);
			// 只有线性变换，不含平移
			var posInWorld : Vector3D = cameraTransform.deltaTransformVector(posInCamera);
			// 即焦点世界坐标
			var cameraPosInWorld : Vector3D = new Vector3D();
			cameraTransform.copyColumnTo(3, cameraPosInWorld);
			// 应用平移
			posInWorld = posInWorld.add(cameraPosInWorld);
			return posInWorld;
		}
	}
}
