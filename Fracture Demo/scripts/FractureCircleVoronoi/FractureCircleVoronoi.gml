// feather ignore all

function FractureCircleVoronoi(_inst, _bodyCount) {
	__FRACTURE_START;
	
	var _radius = max(_w, _h) * 0.5;
	
	// seeds
	var _cols = max(1, round(sqrt(_bodyCount * _w / _h)));
	var _rows = max(1, round(_bodyCount / _cols));
	var _cellW = _w / _cols;
	var _cellH = _h / _rows;
	
	var _seeds = [];
	var _noise = 0.3;
	for (var _col = 0; _col < _cols; _col++) {
		for (var _row = 0; _row < _rows; _row++) {
			var _sx = (_col + 0.5 + random_range(-_noise, _noise)) * _cellW;
			var _sy = (_row + 0.5 + random_range(-_noise, _noise)) * _cellH;
			if (point_distance(_centerX, _centerY, _sx, _sy) <= _radius) {
				array_push(_seeds, _sx, _sy);
			}
		}
	}
	
	// initial clipping polygon — circle approximation
	var _nSides = 32;
	var _clipPolygon = array_create(_nSides * 2);
	for (var _i = 0; _i < _nSides; _i++) {
		var _a = -(_i / _nSides) * 360;
		_clipPolygon[_i * 2] = _centerX + lengthdir_x(_radius, _a);
		_clipPolygon[_i * 2 + 1] = _centerY + lengthdir_y(_radius, _a);
	}
	
	// voronoi
	var _nSeeds = array_length(_seeds) / 2;
	var _index = 0;
	var _vertexOffset = 0;
	
	var _bodies = array_create(_bodyCount);
	for (var _i = 0; _i < _nSeeds; _i++) {
		var _polygon = _clipPolygon;
		
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
		var _dist = point_distance(_centerX, _centerY, _xl, _yt);
		var _dir = point_direction(_centerX, _centerY, _xl, _yt);
		var _bodyX = _inst.x + lengthdir_x(_dist, _dir - _angle);
		var _bodyY = _inst.y + lengthdir_y(_dist, _dir - _angle);
		
		with (instance_create_depth(_bodyX, _bodyY, _inst.depth, __objFractureBody)) {
			__state = _state;
			__primitiveType = pr_trianglelist;
			__nVertices = _nVerticesForBody;
			__vertexIndex = _vertexOffset;
			__vertexBuffer = _vb;
			__texture = _texture;
			
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
