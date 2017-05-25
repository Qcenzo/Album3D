package com.qcenzo.apps.album.math
{
	import com.adobe.utils.PerspectiveMatrix3D;
	
	import flash.geom.Matrix3D;

	public class MatrixLink extends Matrix3D
	{
		private var _m1:Matrix3D;
		private var _m2:Matrix3D;
		private var _m3:PerspectiveMatrix3D;
		private var _tm1:Matrix3D;
		private var _tm2:Matrix3D;
		private var _mvFunc:Function;
		private var _beta:Number

		public function MatrixLink(aspectRatio:Number, defaultModelStatus:Matrix3D, defaultCameraStatus:Matrix3D, defaultMoveFunction:Function)
		{
			_m1 = defaultModelStatus.clone();
			_m2 = defaultCameraStatus.clone();
			_m3 = new PerspectiveMatrix3D();
			_m3.perspectiveFieldOfViewRH(Math.PI / 2, aspectRatio, 0.1, 1000);
			_mvFunc = defaultMoveFunction;
			_beta = 1;
		}
		
		public function get value():Matrix3D
		{
			identity();
			append(_m1);
			if (_beta == 1)
				_mvFunc(_m1);
			append(_m2);
			append(_m3);
			return this;
		}
		
		public function lerp(beta:Number):void
		{
			_beta = beta;
			_m1.interpolateTo(_tm1, _beta);
			_m2.interpolateTo(_tm2, _beta);
		}
		
		public function toMat(modelToMat:Matrix3D, cameraToMat:Matrix3D, moveFunction:Function):void
		{
			_tm1 = modelToMat;
			_tm2 = cameraToMat;
			_mvFunc = moveFunction;
		}
	}
}