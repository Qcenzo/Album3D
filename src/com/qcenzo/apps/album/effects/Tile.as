package com.qcenzo.apps.album.effects
{
	public class Tile extends Effect
	{
		private var _asp:Number;

		public function Tile(aspectRatio:Number)
		{
			super();
			_asp = aspectRatio;
		}
		
		override protected function initCameraStat():void
		{
			_cmrStat.appendTranslation(0, 0, -1);
		}
		
		override protected function generateMesh(numQuads:int):void
		{
			var c:int = Math.sqrt(numQuads);
			var dy:Number = 2 / c;
			var dx:Number = _asp * dy;
			var x0:Number;
			var y0:Number;
			var z0:Number = 0; 
			var w0:Number;
			var temp:Vector.<Number> = new Vector.<Number>();
			for (var i:int = 0; i < numQuads; i++)
			{
				x0 = -_asp + (i % c) * dx;
				y0 = 1 - int(i / c) * dy;
				w0 = i / numQuads;
				
				temp[_nvx++] = x0;
				temp[_nvx++] = y0;
				temp[_nvx++] = z0;
				temp[_nvx++] = w0;
				temp[_nvx++] = x0 + dx;
				temp[_nvx++] = y0;
				temp[_nvx++] = z0;
				temp[_nvx++] = w0;
				temp[_nvx++] = x0;
				temp[_nvx++] = y0 - dy;
				temp[_nvx++] = z0;
				temp[_nvx++] = w0;
				temp[_nvx++] = x0 + dx;
				temp[_nvx++] = y0 - dy;
				temp[_nvx++] = z0;
				temp[_nvx++] = w0;
			}
			
			//随机打乱
			var n:int;
			var quad:Vector.<Number>;
			while (temp.length > 0)
			{
				n = 16 * int((temp.length / 16) * Math.random());
				quad = temp.splice(n, 16);
				while (quad.length > 0)
					_vx.push(quad.shift());
			}
		}
	}
}