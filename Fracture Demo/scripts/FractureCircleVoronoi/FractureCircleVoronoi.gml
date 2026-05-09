// feather ignore all

function FractureCircleVoronoi(_inst, _pieceCount) {
	static _goldenAngle = 180 * (3 - sqrt(5));
	
	__FRACTURE_START;
	
	var _radius = max(_w, _h) / 2;
	
	// Seeds
	var _nSeeds = _pieceCount;
	var _seeds = array_create(_nSeeds * 2);
	
	for (var _i = 0; _i < _nSeeds; _i++) {
	    var _a = _i * _goldenAngle;
	    var _r = _radius * sqrt(_i / _nSeeds);
	    _seeds[_i * 2] = _centerX + lengthdir_x(_r, _a);
	    _seeds[_i * 2 + 1] = _centerY + lengthdir_y(_r, _a);
	}
	
	// Initial clipping polygon
	var _clipPolygon = array_create(__FRACTURE_CIRCLE_PRECISION * 2);
	for (var _i = 0; _i < __FRACTURE_CIRCLE_PRECISION; _i++) {
	    var _a = -(_i / __FRACTURE_CIRCLE_PRECISION) * 360;
	    _clipPolygon[_i * 2] = _centerX + lengthdir_x(_radius, _a);
	    _clipPolygon[_i * 2 + 1] = _centerY + lengthdir_y(_radius, _a);
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
		var _nPieceVertices = _nTriangles * 3;
		
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
			vertex_position(_vb, _p0x - _ox, _p0y - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _p0x / _w), lerp(_v0, _v1, _p0y / _h));
			vertex_position(_vb, _p2x - _ox, _p2y - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _p2x / _w), lerp(_v0, _v1, _p2y / _h));
			vertex_position(_vb, _p3x - _ox, _p3y - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _p3x / _w), lerp(_v0, _v1, _p3y / _h));
		}
		
		// Piece
		__FRACTURE_PIECE
			__primitiveType = pr_trianglelist;
			__vertexCount = _nPieceVertices;
			__vertexIndex = _vertexOffset;
			
			__FRACTURE_FIXTURE_START; {
				for (var _j = 0; _j < _nPts; _j++) {
					physics_fixture_add_point(_fx, _polygon[_j * 2] - _ox, _polygon[_j * 2 + 1] - _oy);
				}
				__FRACTURE_FIXTURE_END;
			}
			
			_pieces[_index++] = id;
		}
		
		_vertexOffset += _nPieceVertices;
	}
	
	__FRACTURE_END;
}
