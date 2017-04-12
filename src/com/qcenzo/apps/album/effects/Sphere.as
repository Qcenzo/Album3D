package com.qcenzo.apps.album.effects
{
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;

	public class Sphere extends Effect
	{
		public function Sphere()
		{
			super();
		}
		
		override public function moveFunc(model:Matrix3D):void
		{
			model.appendRotation(1, Vector3D.Y_AXIS);
		}
		
		override protected function initModelStat():void
		{
		}
		
		override protected function initCameraStat():void
		{
			_cmrStat.appendRotation(-10, Vector3D.X_AXIS);
			_cmrStat.appendTranslation(0, 0, -3);
		}
		
		override protected function generateMesh(numQuads:int):void
		{
			
		}
	}
}