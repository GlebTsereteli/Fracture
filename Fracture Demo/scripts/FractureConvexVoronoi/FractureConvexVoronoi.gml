// feather ignore all

function FractureConvexVoronoi(_inst, _pieceCount) {
	static _hulls = {};
		
	__FRACTURE_START;
	
	var _key = $"{_inst.sprite_index},{_inst.image_index}";
	_hulls[$ _key] ??= sprite_get_convex_hull(_inst.sprite_index, undefined, _inst.image_index);
	var _hull = _hulls[$ _key];
	
	// Convert flat CCW hull to CW flat array
	var _nHullPts = array_length(_hull) / 2;
	var _clipPolygon = array_create(_nHullPts * 2);
	for (var _i = 0; _i < _nHullPts; _i++) {
		var _k = _nHullPts - 1 - _i;
		_clipPolygon[_i * 2] = _hull[_k * 2] * _inst.image_xscale;
		_clipPolygon[_i * 2 + 1] = _hull[_k * 2 + 1] * _inst.image_yscale;
	}
	
	// Seeds
	var _centroidX = 0, _centroidY = 0;
	for (var _i = 0; _i < _nHullPts; _i++) {
	    _centroidX += _clipPolygon[_i * 2];
	    _centroidY += _clipPolygon[_i * 2 + 1];
	}
	_centroidX /= _nHullPts;
	_centroidY /= _nHullPts;

	var _seeds = array_create(_pieceCount * 2);
	for (var _i = 0; _i < _pieceCount; _i++) {
	    var _vi = (_i * _nHullPts div _pieceCount) mod _nHullPts;
	    var _vx = _clipPolygon[_vi * 2];
	    var _vy = _clipPolygon[_vi * 2 + 1];
	    var _t = random_range(0.2, 0.8);
	    _seeds[_i * 2] = lerp(_centroidX, _vx, _t);
	    _seeds[_i * 2 + 1] = lerp(_centroidY, _vy, _t);
	}
	
	// Main
	var _nSeeds = array_length(_seeds) / 2;
	var _index = 0;
	
	var _pieces = array_create(_pieceCount);
	for (var _i = 0; _i < _nSeeds; _i++) {
		var _polygon = _clipPolygon;
		
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
		var _nVerticesForPiece = _nTriangles * 3;
		
		var _ox = 0, _oy = 0;
		for (var _j = 0; _j < _nPts; _j++) {
			_ox += _polygon[_j * 2];
			_oy += _polygon[_j * 2 + 1];
		}
		_ox /= _nPts;
		_oy /= _nPts;
		
		// Vertices
		for (var _j = 1; _j < _nPts - 1; _j++) {
			var _p0x = _polygon[0], _p0y = _polygon[1];
			var _p2x = _polygon[_j * 2], _p2y = _polygon[_j * 2 + 1];
			var _p3x = _polygon[(_j + 1) * 2], _p3y = _polygon[(_j + 1) * 2 + 1];
			vertex_position(_vb, _p0x - _ox, _p0y - _oy); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _p0x / _w), lerp(_v0, _v1, _p0y / _h));
			vertex_position(_vb, _p2x - _ox, _p2y - _oy); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _p2x / _w), lerp(_v0, _v1, _p2y / _h));
			vertex_position(_vb, _p3x - _ox, _p3y - _oy); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _p3x / _w), lerp(_v0, _v1, _p3y / _h));
		}
		
		// Piece
		__FRACTURE_PIECE
			__primitiveType = pr_trianglelist;
			__vertexCount = _nVerticesForPiece;
			__vertexIndex = _vertexOffset;
			
			__FRACTURE_FIXTURE_START; {
				for (var _j = 0; _j < _nPts; _j++) {
					physics_fixture_add_point(_fx, _polygon[_j * 2] - _ox, _polygon[_j * 2 + 1] - _oy);
				}
				__FRACTURE_FIXTURE_END;
			}
			
			_pieces[_index++] = id;
		}
		
		_vertexOffset += _nVerticesForPiece;
	}
	
	__FRACTURE_END;
}
