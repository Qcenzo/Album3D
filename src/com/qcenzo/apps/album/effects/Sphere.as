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
		
		override protected function initCameraStat():void
		{
			_cmrStat.appendRotation(40, Vector3D.X_AXIS);
			_cmrStat.appendTranslation(0, 0, -2.6);
		}
		
		override public function moveFunc(model:Matrix3D):void
		{
			model.appendRotation(1, Vector3D.Y_AXIS);
		}
		
		override protected function generateMesh(numQuads:int):void
		{
			var segh:int = Math.sqrt(numQuads / 2);
			var segv:int = segh * 2;
			var dLong:Number = 2 * Math.PI / segh;//经度增量
			var dLat:Number = Math.PI / segv;//纬度增量
			var long:Number;
			var lat:Number = dLat;
			var r:Number;
			var n:int = segh * (segv - 2);
			var w:Number;
			for (var i:int = 0; i < n; i++)
			{
				long = i % segh * dLong;
				lat = dLat + int(i / segh) * dLat;
				w = i / numQuads;
				
				r = Math.sin(lat);
				_vx[_nvx++] = r * Math.sin(long);
				_vx[_nvx++] = Math.cos(lat);
				_vx[_nvx++] = r * Math.cos(long);
				_vx[_nvx++] = w;
				
				_vx[_nvx++] = r * Math.sin(long + dLong);
				_vx[_nvx++] = Math.cos(lat);
				_vx[_nvx++] = r * Math.cos(long + dLong);
				_vx[_nvx++] = w;

				r = Math.sin(lat + dLat);
				_vx[_nvx++] = r * Math.sin(long);
				_vx[_nvx++] = Math.cos(lat + dLat);
				_vx[_nvx++] = r * Math.cos(long);
				_vx[_nvx++] = w;
				
				_vx[_nvx++] = r * Math.sin(long + dLong);
				_vx[_nvx++] = Math.cos(lat + dLat);
				_vx[_nvx++] = r * Math.cos(long + dLong);
				_vx[_nvx++] = w;
			}
			
			//多出的
			n = numQuads - n;
			for (i = 0; i < n; i++)
			{
				var m:int = _nvx - 16;
				for (var j:int = 0; j < 16; j++)
					_vx[_nvx++] = _vx[m + j];
			}
		}
	}
}