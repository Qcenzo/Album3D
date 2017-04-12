package com.qcenzo.apps.album  
{
	import com.qcenzo.apps.album.effects.Cube;
	import com.qcenzo.apps.album.effects.Effect;
	import com.qcenzo.apps.album.effects.Queue;
	import com.qcenzo.apps.album.effects.Tile;
	
	import flash.display3D.Context3D;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.geom.Matrix3D;
	import flash.utils.getTimer;

	/**
	 * Effector采用线性插值处理运动特效切换，包括模型变形、相机空间的位置变换。特效共享UV、纹理和索引缓冲，不共享相机视角、模型网格和网格变形延时
	 * @author Charles Chen
	 * 
	 */
	public class Effector
	{
		/**
		 * 效果过渡时间（ 毫秒） 
		 */
		private const DURATION:int = 1000;
		
		private var _vector:Vector.<Number>;
		private var _ixb:IndexBuffer3D;
		private var _uvb:VertexBuffer3D;
		private var _mlnk:MatrixLink;
		private var _list:Vector.<Effect>;
		private var _indx0:int;
		private var _indx1:int;
		private var _chging:Boolean;
		private var _time:int;
		
		public function Effector(w:int, h:int)
		{
			_vector = Vector.<Number>([0, 1, 1, 0]);
//			_list = Vector.<Effect>([new Cube(), new Sphere(), new Tile(w / h)]); 
			_list = new Vector.<Effect>();
			_list.push(new Queue(w / h));
			_list.push(new Tile(w / h));
			_list.push(new Cube());

			_mlnk = new MatrixLink(w, h, _list[_indx0].modelStatus1, _list[_indx0].cameraStatus, _list[_indx0].moveFunc);
		}
		
		public function setup(context:Context3D, numQuads:int):void
		{
			_vector[3] = 1 / numQuads;
			
			//xyz
			for (var i:int = 0; i < _list.length; i++)
				_list[i].createVertexBuffer(context, numQuads);
			
			//uv
			var c:int = Math.sqrt(numQuads);
			var d:Number = 1 / c;
			var u0:Number;
			var v0:Number;
			var j:int;
			var uv:Vector.<Number> = new Vector.<Number>();
			for (i = 0; i < numQuads; i++)
			{
				u0 = (i % c) * d;
				v0 = int(i / c) * d;
				
				uv[j++] = u0;
				uv[j++] = v0;
				uv[j++] = u0 + d;
				uv[j++] = v0;
				uv[j++] = u0;
				uv[j++] = v0 + d;
				uv[j++] = u0 + d;
				uv[j++] = v0 + d;
			}
			j /= 2;
			_uvb = context.createVertexBuffer(j, 2);
			_uvb.uploadFromVector(uv, 0, j);
			
			//face
			var ix:Vector.<uint> = new Vector.<uint>();
			for (i = 0, j = 0; i < numQuads; i++)
			{
				d = i * 4;
				ix[j++] = 0 + d;
				ix[j++] = 1 + d;
				ix[j++] = 2 + d;
				ix[j++] = 2 + d;
				ix[j++] = 1 + d;
				ix[j++] = 3 + d;
			}
			_ixb = context.createIndexBuffer(j);
			_ixb.uploadFromVector(ix, 0, j);
		}
		
		public function prev():void
		{
			if (_chging)
				return;
			
			_indx1 = _indx0 - 1;
			if (_indx1 < 0)
				_indx1 = _list.length - 1;
			
			update();
		}
		
		public function next():void
		{
			if (_chging)
				return;
			
			_indx1 = _indx0 + 1;
			if (_indx1 > _list.length - 1)
				_indx1 = 0;
			
			update();
		}
		
		/**
		 * [剩余时间，已消耗时间，结束标记，每一片小矩形的差值总时间] 
		 * @return 
		 * 
		 */
		public function get vector():Vector.<Number>
		{
			if (_chging)
			{
				var beta:Number = (getTimer() - _time) / DURATION; 
				if (beta >= 1)
				{
					beta = 1;
					_indx0 = _indx1;
					_chging = false;
				}
				_vector[0] = 1 - beta;
				_vector[1] = beta;
				
				_mlnk.lerp(beta);
			}
			return _vector;
		}
		
		public function get matrix():Matrix3D
		{
			return _mlnk.value;
		}

		public function get uvb():VertexBuffer3D
		{
			return _uvb;
		}

		public function get ixb():IndexBuffer3D
		{
			return _ixb;
		}

		public function get vxb0():VertexBuffer3D
		{
			return _list[_indx0].vxb;
		}

		public function get vxb1():VertexBuffer3D
		{
			return _list[_indx1].vxb;
		}
		
		private function update():void
		{
			_mlnk.toMat(_list[_indx1].modelStatus1, _list[_indx1].cameraStatus, _list[_indx1].moveFunc);
			_time = getTimer();
			_chging = true;
		}
	}
}