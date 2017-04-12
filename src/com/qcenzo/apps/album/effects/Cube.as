package com.qcenzo.apps.album.effects
{
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;

	public class Cube extends Effect
	{
		public function Cube()
		{
			super();
		}
		
		override protected function initModelStat():void
		{
			_modStat1.appendRotation(-45, Vector3D.X_AXIS);
			_modStat1.appendRotation(45, Vector3D.Z_AXIS);
		}
		
		override protected function initCameraStat():void
		{
			_cmrStat.appendRotation(10, Vector3D.X_AXIS);
			_cmrStat.appendTranslation(0, 0, -3);
		}
		
		override public function moveFunc(model:Matrix3D):void
		{
			model.appendRotation(1, Vector3D.Y_AXIS);
		}
		
		override protected function generateMesh(numQuads:int):void
		{
			var c:int = Math.floor(Math.sqrt(numQuads / 6));
			var d:Number = 2 / c;
			var n:int = c * c;
			var x0:Number;
			var y0:Number;
			var z0:Number;
			var w0:Number;
			var t:int;
			
			//前后
			z0 = 1;
			for (var i:int = 0; i < n; i++)
			{
				x0 = -1 + (i % c) * d; 
				y0 = 1 - int(i / c) * d; 
				w0 = (t++) / numQuads;
				
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0 + d;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0 - d;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0 + d;
				_vx[_nvx++] = y0 - d;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
			}
			z0 = -1;
			for (i = 0; i < n; i++)
			{
				x0 = 1 - (i % c) * d;
				y0 = 1 - int(i / c) * d;
				w0 = (t++) / numQuads;
				
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0 - d;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0 - d;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0 - d;
				_vx[_nvx++] = y0 - d;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
			}
			
			//左右
			x0 = 1;
			for (i = 0; i < n; i++)
			{
				z0 = 1 - (i % c) * d;
				y0 = 1 - int(i / c) * d;
				w0 = (t++) / numQuads;
				
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0 - d;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0 - d;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0 - d;
				_vx[_nvx++] = z0 - d;
				_vx[_nvx++] = w0;
			}
			x0 = -1;
			for (i = 0; i < n; i++)
			{
				z0 = -1 + (i % c) * d;
				y0 = 1 - int(i / c) * d;
				w0 = (t++) / numQuads;
				
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0 + d;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0 - d;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0 - d;
				_vx[_nvx++] = z0 + d;
				_vx[_nvx++] = w0;
			}
			
			//上下
			y0 = 1;
			for (i = 0; i < n; i++)
			{
				x0 = 1 - (i % c) * d;
				z0 = 1 - int(i / c) * d;
				w0 = (t++) / numQuads;
				
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0 - d;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0 - d;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0 - d;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0 - d;
				_vx[_nvx++] = w0;
			}
			y0 = -1;
			for (i = 0; i < n; i++)
			{
				x0 = -1 + (i % c) * d;
				z0 = 1 - int(i / c) * d;
				w0 = (t++) / numQuads;
				
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0 + d;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0 - d;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0 + d;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0 - d;
				_vx[_nvx++] = w0;
			}
			
			//多出的
			var j:int;
			for (i = 0, numQuads -= 6 * n; i < numQuads; i++)
			{
				for (j = 0; j < 16; j++)
				{
					n = _nvx;
					_vx[_nvx++] = _vx[n - 16];
				}
			}
		}
	}
}