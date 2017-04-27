package com.qcenzo.apps.album.effects
{
	import flash.geom.Matrix3D;

	public class Queue extends Effect
	{
		private var _asp:Number;
		private var _t:int;
		private var _m:Matrix3D;
		
		public function Queue(aspectRatio:Number)
		{
			super();
			_asp = aspectRatio;
			_m = new Matrix3D();
		}
		
		override public function moveFunc(model:Matrix3D):void
		{
			model.identity();
			_m.identity();
			_m.appendTranslation(0, 0, _t);
			_t += 6;
			if (_t > 10000)
				_t = 0;
			model.append(_m);
		}
		
		override protected function initCameraStat():void
		{
			_cmrStat.appendTranslation(0, 0, -1000.2);
		}
		
		override protected function generateMesh(numQuads:int):void
		{
			var x0:Number;
			var y0:Number;
			var z0:Number;
			var w0:Number;
			var t:Number = 2 * _asp;
			var dx:Number = 40;
			var dy:Number = 40;
			
			for (var i:int = 0; i < numQuads; i++)
			{
				x0 = -640 + 1280 * Math.random();
				y0 = 400 - 800 * Math.random();
				z0 = -20000 * Math.random();
				w0 = i / numQuads;
				
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0 + dx;
				_vx[_nvx++] = y0;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0;
				_vx[_nvx++] = y0 - dy;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
				_vx[_nvx++] = x0 + dx;
				_vx[_nvx++] = y0 - dy;
				_vx[_nvx++] = z0;
				_vx[_nvx++] = w0;
			}
				
		}
	}
}