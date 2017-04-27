package com.qcenzo.apps.album.effects
{
	import flash.display.BitmapData;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.text.TextField;

	public class Logo extends Effect
	{
		private var _canvas:BitmapData;
		private var _asp:Number;
		private var _t:Number;

		public function Logo(logo:String, aspectRatio:Number)
		{
			super();
			
			_asp = aspectRatio;
			_t = 0;
			
			var tf:TextField = new TextField();
			tf.htmlText = "<font face='Heiti' size='40'><b>" + logo + "</b></font>";
			tf.width = tf.textWidth + 4;
			tf.height = tf.textHeight + 4;
			_canvas = new BitmapData(tf.width, tf.height, true, 0);
			_canvas.draw(tf);
		}
		
		override protected function initCameraStat():void
		{
			_cmrStat.appendTranslation(0, 0, -2);
		}
		
		override public function moveFunc(model:Matrix3D):void
		{
			model.identity();
			model.appendRotation(10 * Math.sin(_t), Vector3D.X_AXIS);
			_t += 0.06;
		}
		
		override protected function generateMesh(numQuads:int):void
		{
			var w:int = _canvas.width;
			var h:int = _canvas.height;
			var dx:Number = 4 / w;
			var dy:Number = 4 / h;
			var n:int;
			var x0:Number;
			var y0:Number;
			var z0:Number = 0;
			var w0:Number;
			for (var i:int = 0; i < w; i++)
			{
				for (var j:int = 0; j < h; j++)
				{
					if (_canvas.getPixel32(i, j) >> 32 != 0)
					{
						x0 = -_asp + i / w * 2 * _asp;
						y0 = 1 - j / h * 2;
						w0 = n / numQuads;
						
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
						
						n++;
					}
				}
			}
			
			//多出的
			n = numQuads - n;
			for (i = 0; i < n; i++)
			{
				var m:int = _nvx - 16;
				for (j = 0; j < 16; j++)
					_vx[_nvx++] = _vx[m + j];
			}
		}
	}
}