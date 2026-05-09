// feather ignore all

function FractureBoxVoronoi(_inst, _pieceCount) {
	__FRACTURE_START;
	
	// Seeds
	var _cols = max(1, round(sqrt(_pieceCount * _w / _h)));
	var _rows = max(1, round(_pieceCount / _cols));
	var _cellW = _w / _cols;
	var _cellH = _h / _rows;
	
	var _nSeeds = _cols * _rows;
	var _seeds = array_create(_nSeeds * 2);
	var _index = 0;
	var _noise = 0.4;
	for (var _col = 0; _col < _cols; _col++) {
		for (var _row = 0; _row < _rows; _row++) {
			_seeds[_index++] = (_col + 0.5 + (_row mod 2) * 0.5 + random_range(-_noise, _noise)) * _cellW;
			_seeds[_index++] = (_row + 0.5 + random_range(-_noise, _noise)) * _cellH;
		}
	}
	
	// Voronoi
	var _index = 0;
	
	var _pieces = array_create(_pieceCount);
	for (var _i = 0; _i < _nSeeds; _i++) {
		var _polygon = [0, 0, _w, 0, _w, _h, 0, _h];
		
		// Polygon
		var _iSeedX = _seeds[_i * 2];
		var _iSeedY = _seeds[_i * 2 + 1];
		for (var _j = 0; _j < _nSeeds; _j++) {
			if (_i == _j) continue;
			if (array_length(_polygon) == 0) break;
			
			var _jSeedX = _seeds[_j * 2];
			var _jSeedY = _seeds[_j * 2 + 1];
			var _midX = mean(_iSeedX, _jSeedX);
			var _midY = mean(_iSeedY, _jSeedY);
			var _normalX = _iSeedX - _jSeedX;
			var _normalY = _iSeedY - _jSeedY;
			_polygon = __FracturePolygonClipHalfPlane(_polygon, _midX, _midY, _normalX, _normalY);
		}
		
		var _nPts = array_length(_polygon) / 2;
		if (_nPts < 3) continue;
		
		var _nTriangles = _nPts - 2;
		var _nVertices = _nTriangles * 3;
		
		var _ox = 0, _oy = 0;
		for (var _j = 0; _j < _nPts; _j++) {
			_ox += _polygon[_j * 2];
			_oy += _polygon[_j * 2 + 1];
		}
		_ox /= _nPts;
		_oy /= _nPts;
		
		for (var _j = 1; _j < _nPts - 1; _j++) {
			var _p0x = _polygon[0], _p0y = _polygon[1];
			var _p2x = _polygon[_j * 2], _p2y = _polygon[_j * 2 + 1];
			var _p3x = _polygon[(_j + 1) * 2], _p3y = _polygon[(_j + 1) * 2 + 1];
			vertex_position(_vb, _p0x - _ox, _p0y - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _p0x / _w), lerp(_v0, _v1, _p0y / _h));
			vertex_position(_vb, _p2x - _ox, _p2y - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _p2x / _w), lerp(_v0, _v1, _p2y / _h));
			vertex_position(_vb, _p3x - _ox, _p3y - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _p3x / _w), lerp(_v0, _v1, _p3y / _h));
		}
		
		__FRACTURE_PIECE
			__primitiveType = pr_trianglelist;
			__vertexCount = _nVertices;
			__vertexIndex = _vertexOffset;
			
			__FRACTURE_FIXTURE_START; {
				for (var _j = 0; _j < _nPts; _j++) {
					physics_fixture_add_point(_fx, _polygon[_j * 2] - _ox, _polygon[_j * 2 + 1] - _oy);
				}
				__FRACTURE_FIXTURE_END;
			}
			
			_pieces[_index++] = id;
		}
		
		_vertexOffset += _nVertices;
	}
	
	__FRACTURE_END;
}
