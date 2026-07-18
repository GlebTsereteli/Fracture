// feather ignore all

/// @ignore
function __FractureConvexSliceBox(_inst, _pieceCount, _cutAngle) {
	static _vertX = array_create(6);
	static _vertY = array_create(6);
	
	__FRACTURE_START;
	
	var _nx = -dsin(_cutAngle);
	var _ny = -dcos(_cutAngle);
	
	var _projTL = 0;
	var _projTR = _w * _nx;
	var _projBR = (_w * _nx) + (_h * _ny);
	var _projBL = _h * _ny;
	
	var _minProj = min(_projTL, _projTR, _projBR, _projBL);
	var _step = (max(_projTL, _projTR, _projBR, _projBL) - _minProj) / _pieceCount;
	
	var _cornerX = [0, _w, _w, 0];
	var _cornerY = [0, 0, _h, _h];
	var _cornerProj = [_projTL, _projTR, _projBR, _projBL];
	
	var _pieces = array_create(_pieceCount);
	var _index = 0;
	
	for (var _i = 0; _i < _pieceCount; _i++) {
		var _near = _minProj + _step * _i;
		var _far = _near + _step;
		var _vertCount = 0;
		
		for (var _edge1 = 0; _edge1 < 4; _edge1++) {
			var _edge2 = (_edge1 + 1) mod 4;
			var _ax = _cornerX[_edge1], _ay = _cornerY[_edge1], _aProj = _cornerProj[_edge1];
			var _bx = _cornerX[_edge2], _by = _cornerY[_edge2], _bProj = _cornerProj[_edge2];
			
			if ((_aProj >= _near) and (_aProj <= _far)) {
				_vertX[_vertCount] = _ax;
				_vertY[_vertCount] = _ay;
				_vertCount++;
			}
			
			var _projDelta = _bProj - _aProj;
			if (_projDelta != 0) {
				var _tNear = (_near - _aProj) / _projDelta;
				var _tFar = (_far - _aProj) / _projDelta;
				var _t1 = min(_tNear, _tFar);
				var _t2 = max(_tNear, _tFar);
				
				if ((_t1 > 0) and (_t1 < 1)) {
					_vertX[_vertCount] = lerp(_ax, _bx, _t1);
					_vertY[_vertCount] = lerp(_ay, _by, _t1);
					_vertCount++;
				}
				if ((_t2 != _t1) and (_t2 > 0) and (_t2 < 1)) {
					_vertX[_vertCount] = lerp(_ax, _bx, _t2);
					_vertY[_vertCount] = lerp(_ay, _by, _t2);
					_vertCount++;
				}
			}
		}
		if (_vertCount < 3) continue;
		
		// Centroid
		var _sumX = 0, _sumY = 0;
		for (var _v = 0; _v < _vertCount; _v++) {
			_sumX += _vertX[_v];
			_sumY += _vertY[_v];
		}
		var _ox = _sumX / _vertCount;
		var _oy = _sumY / _vertCount;
		
		// Vertices. Triangle fan from centroid
		var _nTris = _vertCount;
		var _cu = lerp(_u0, _u1, _ox / _w);
		var _cv = lerp(_v0, _v1, _oy / _h);
		for (var _j = 0; _j < _nTris; _j++) {
			var _ax = _vertX[_j], _ay = _vertY[_j];
			var _bx = _vertX[(_j + 1) mod _vertCount], _by = _vertY[(_j + 1) mod _vertCount];
			vertex_position(_vb, 0, 0); __FRACTURE_VCOLOR; vertex_texcoord(_vb, _cu, _cv);
			vertex_position(_vb, _ax - _ox, _ay - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
			vertex_position(_vb, _bx - _ox, _by - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
		}
		
		// Fixture
		__FRACTURE_PIECE
			__primitiveType = pr_trianglelist;
			__vertexCount = _nTris * 3;
			__vertexIndex = _vertexOffset;
			
			__FRACTURE_FIXTURE_START; {
				for (var _f = 0; _f < _vertCount; _f++) {
					physics_fixture_add_point(_fx, _vertX[_f] - _ox, _vertY[_f] - _oy);
				}
				__FRACTURE_FIXTURE_END;
			}
			
			_pieces[_index++] = id;
		}
		
		_vertexOffset += _nTris * 3;
	}
	
	_pieceCount = _index;
	array_resize(_pieces, _pieceCount);
	
	__FRACTURE_END;
}
