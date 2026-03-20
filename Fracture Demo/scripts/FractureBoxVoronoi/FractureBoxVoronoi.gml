// feather ignore all

function FractureBoxVoronoi(_inst, _bodyCount) {
	__FRACTURE_BOX_START;
	
	// seeds
	var _seeds = [];
	var _attempts = 0;
	var _maxAttempts = _bodyCount * 100;
	var _minDist = 10;
	
	while ((array_length(_seeds) < _bodyCount) and (_attempts < _maxAttempts)) {
		_attempts++;
		var _sx = random(_w);
		var _sy = random(_h);
		var _tooClose = false;
		for (var _k = 0; _k < array_length(_seeds); _k++) {
			if (point_distance(_sx, _sy, _seeds[_k].x, _seeds[_k].y) < _minDist) {
				_tooClose = true;
				break;
			}
		}
		if (not _tooClose) {
			array_push(_seeds, { x: _sx, y: _sy });
		}
	}
	
	// voronoi
	var _nSeeds = array_length(_seeds);
	var _index = 0;
	var _vertexOffset = 0;
	
	var _bodies = array_create(_bodyCount);
	for (var _i = 0; _i < _nSeeds; _i++) {
		var _polygon = [
			{ x: 0,  y: 0 },
			{ x: _w, y: 0 },
			{ x: _w, y: _h },
			{ x: 0,  y: _h },
		];
		
		var _iSeed = _seeds[_i];
		for (var _j = 0; _j < _nSeeds; _j++) {
			if (_i == _j) continue;
			if (array_length(_polygon) == 0) break;
			
			var _jSeed = _seeds[_j];
			var _midX = mean(_iSeed.x, _jSeed.x);
			var _midY = mean(_iSeed.y, _jSeed.y);
			var _normalX = _iSeed.x - _jSeed.x;
			var _normalY = _iSeed.y - _jSeed.y;
			_polygon = __FracturePolygonClipHalfPlane(_polygon, _midX, _midY, _normalX, _normalY);
		}
		
		var _nVerts = array_length(_polygon);
		if (_nVerts < 3) continue;
		
		var _nTriangles = _nVerts - 2;
		var _nVerticesForBody = _nTriangles * 3;
		
		var _xl = _polygon[0].x;
		var _yt = _polygon[0].y;
		for (var _k = 1; _k < _nVerts; _k++) {
			_xl = min(_xl, _polygon[_k].x);
			_yt = min(_yt, _polygon[_k].y);
		}
		
		var _dist = point_distance(_centerX, _centerY, _xl, _yt);
		var _dir = point_direction(_centerX, _centerY, _xl, _yt);
		var _bodyX = _inst.x + lengthdir_x(_dist, _dir - _angle);
		var _bodyY = _inst.y + lengthdir_y(_dist, _dir - _angle);
		
		with (instance_create_depth(_bodyX, _bodyY, _inst.depth, __objFractureBody)) {
			for (var _k = 1; _k < _nVerts - 1; _k++) {
				var _p0 = _polygon[0];
				var _pk = _polygon[_k];
				var _pk1 = _polygon[_k + 1];
				vertex_position(_vb, _p0.x - _xl, _p0.y - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _p0.x / _w,  _p0.y / _h);
				vertex_position(_vb, _pk.x - _xl, _pk.y - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _pk.x / _w,  _pk.y / _h);
				vertex_position(_vb, _pk1.x - _xl, _pk1.y - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _pk1.x / _w, _pk1.y / _h);
			}
			
			__nVertices = _nVerticesForBody;
			__vertexIndex = _vertexOffset;
			__vertexBuffer = _vb;
			__texture = _texture;
			
			__FRACTURE_FIXTURE_START; {
				for (var _k = 0; _k < _nVerts; _k++) {
					physics_fixture_add_point(_fx, _polygon[_k].x - _xl, _polygon[_k].y - _yt);
				}
				__FRACTURE_FIXTURE_END;
			}
			
			_bodies[_index++] = id;
		}
		
		_vertexOffset += _nVerticesForBody;
	}
	
	__FRACTURE_END;
}
