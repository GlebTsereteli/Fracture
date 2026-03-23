// feather ignore all

function FractureConvexVoronoi(_inst, _bodyCount, _noise = 0.25) {
	__FRACTURE_START;
	
	static _hulls = {};
	
	var _key = $"{_inst.sprite_index},{_inst.image_index}";
	_hulls[$ _key] ??= sprite_get_convex_hull(_inst.sprite_index, undefined, _inst.image_index);
	var _hull = _hulls[$ _key];
	
	// convert flat CCW hull to CW polygon array
	var _nHullPts = array_length(_hull) / 2;
	var _clipPolygon = array_create(_nHullPts);
	for (var _i = 0; _i < _nHullPts; _i++) {
		var _k = _nHullPts - 1 - _i;
		_clipPolygon[_i] = {
			x: _hull[_k * 2] * _inst.image_xscale,
			y: _hull[_k * 2 + 1] * _inst.image_yscale,
		};
	}
	
	// seeds
	var _cols = max(1, round(sqrt(_bodyCount * _w / _h)));
	var _rows = max(1, round(_bodyCount / _cols));
	var _cellW = _w / _cols;
	var _cellH = _h / _rows;
	
	var _seeds = [];
	for (var _col = 0; _col < _cols; _col++) {
		for (var _row = 0; _row < _rows; _row++) {
			var _sx = (_col + 0.5 + random_range(-_noise, _noise)) * _cellW;
			var _sy = (_row + 0.5 + random_range(-_noise, _noise)) * _cellH;
			array_push(_seeds, { x: _sx, y: _sy });
		}
	}
	
	// voronoi
	var _nSeeds = array_length(_seeds);
	var _index = 0;
	var _vertexOffset = 0;
	
	var _bodies = array_create(_bodyCount);
	for (var _i = 0; _i < _nSeeds; _i++) {
		var _polygon = _clipPolygon;
		
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
		for (var _j = 1; _j < _nVerts; _j++) {
			_xl = min(_xl, _polygon[_j].x);
			_yt = min(_yt, _polygon[_j].y);
		}
		
		// vertices
		for (var _j = 1; _j < _nVerts - 1; _j++) {
			var _p0 = _polygon[0];
			var _p2 = _polygon[_j];
			var _p3 = _polygon[_j + 1];
			vertex_position(_vb, _p0.x - _xl, _p0.y - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _p0.x / _w), lerp(_v0, _v1, _p0.y / _h));
			vertex_position(_vb, _p2.x - _xl, _p2.y - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _p2.x / _w), lerp(_v0, _v1, _p2.y / _h));
			vertex_position(_vb, _p3.x - _xl, _p3.y - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _p3.x / _w), lerp(_v0, _v1, _p3.y / _h));
		}
		
		// body
		var _dist = point_distance(_centerX, _centerY, _xl, _yt);
		var _dir = point_direction(_centerX, _centerY, _xl, _yt);
		var _bodyX = _inst.x + lengthdir_x(_dist, _dir - _angle);
		var _bodyY = _inst.y + lengthdir_y(_dist, _dir - _angle);
		
		with (instance_create_depth(_bodyX, _bodyY, _inst.depth, __objFractureBody)) {
			__primitiveType = pr_trianglelist;
			__nVertices = _nVerticesForBody;
			__vertexIndex = _vertexOffset;
			__vertexBuffer = _vb;
			__texture = _texture;
			
			__FRACTURE_FIXTURE_START; {
				for (var _j = 0; _j < _nVerts; _j++) {
					physics_fixture_add_point(_fx, _polygon[_j].x - _xl, _polygon[_j].y - _yt);
				}
				__FRACTURE_FIXTURE_END;
			}
			
			_bodies[_index++] = id;
		}
		
		_vertexOffset += _nVerticesForBody;
	}
	
	__FRACTURE_END;
}
