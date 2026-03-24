// feather ignore all

function FractureBoxVoronoi(_inst, _bodyCount) {
	__FRACTURE_START;
	
	// seeds
	var _cols = max(1, round(sqrt(_bodyCount * _w / _h)));
	var _rows = max(1, round(_bodyCount / _cols));
	var _cellW = _w / _cols;
	var _cellH = _h / _rows;
	
	var _nSeeds = _cols * _rows;
	var _seeds = array_create(_nSeeds * 2);
	var _index = 0;
	var _noise = 0.4;
	for (var _col = 0; _col < _cols; _col++) {
		for (var _row = 0; _row < _rows; _row++) {
			_seeds[_index++] = (_col + 0.5 + random_range(-_noise, _noise)) * _cellW;
			_seeds[_index++] = (_row + 0.5 + random_range(-_noise, _noise)) * _cellH;
		}
	}
	
	// voronoi
	var _index = 0;
	var _vertexOffset = 0;
	
	var _bodies = array_create(_bodyCount);
	for (var _i = 0; _i < _nSeeds; _i++) {
		var _polygon = [0, 0, _w, 0, _w, _h, 0, _h];
		
		// polygon
		var _isx = _seeds[_i * 2];
		var _isy = _seeds[_i * 2 + 1];
		for (var _j = 0; _j < _nSeeds; _j++) {
			if (_i == _j) continue;
			if (array_length(_polygon) == 0) break;
			
			var _jsx = _seeds[_j * 2];
			var _jsy = _seeds[_j * 2 + 1];
			var _midX = mean(_isx, _jsx);
			var _midY = mean(_isy, _jsy);
			var _normalX = _isx - _jsx;
			var _normalY = _isy - _jsy;
			_polygon = __FracturePolygonClipHalfPlane(_polygon, _midX, _midY, _normalX, _normalY);
		}
		
		var _nPts = array_length(_polygon) / 2;
		if (_nPts < 3) continue;
		var _nTriangles = _nPts - 2;
		var _nVerticesForBody = _nTriangles * 3;
		
		var _xl = _polygon[0];
		var _yt = _polygon[1];
		for (var _j = 1; _j < _nPts; _j++) {
			_xl = min(_xl, _polygon[_j * 2]);
			_yt = min(_yt, _polygon[_j * 2 + 1]);
		}
		
		// vertices
		for (var _j = 1; _j < _nPts - 1; _j++) {
			var _p0x = _polygon[0], _p0y = _polygon[1];
			var _p2x = _polygon[_j * 2], _p2y = _polygon[_j * 2 + 1];
			var _p3x = _polygon[(_j + 1) * 2], _p3y = _polygon[(_j + 1) * 2 + 1];
			vertex_position(_vb, _p0x - _xl, _p0y - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _p0x / _w), lerp(_v0, _v1, _p0y / _h));
			vertex_position(_vb, _p2x - _xl, _p2y - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _p2x / _w), lerp(_v0, _v1, _p2y / _h));
			vertex_position(_vb, _p3x - _xl, _p3y - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _p3x / _w), lerp(_v0, _v1, _p3y / _h));
		}
		
		// body
		__FRACTURE_BODY
			__primitiveType = pr_trianglelist;
			__nVertices = _nVerticesForBody;
			__vertexIndex = _vertexOffset;
			
			__FRACTURE_FIXTURE_START; {
				for (var _j = 0; _j < _nPts; _j++) {
					physics_fixture_add_point(_fx, _polygon[_j * 2] - _xl, _polygon[_j * 2 + 1] - _yt);
				}
				__FRACTURE_FIXTURE_END;
			}
			
			_bodies[_index++] = id;
		}
		
		_vertexOffset += _nVerticesForBody;
	}
	
	__FRACTURE_END;
}
