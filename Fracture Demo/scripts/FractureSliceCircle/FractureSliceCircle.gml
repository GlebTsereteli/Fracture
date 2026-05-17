// feather ignore all

/// @func FractureSliceCircle()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} pieceCount The number of slices.
/// @param {Real} cutAngle The angle of the cuts. [Default: 45]
/// 
/// @desc Fractures the given circle-shaped instance into parallel slices clipped to the circle boundary, defined by the number of pieces.
/// The cut angle controls the orientation of the slices.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureSliceCircle(_inst, _pieceCount, _cutAngle = 45) {
	// Arc sample buffers. 7 per side, 14 verts per slice
	static _polyX = array_create(14);
	static _polyY = array_create(14);
	static _arcSteps = 6;
	
	__FRACTURE_START;
	
	var _radius = min(_w, _h) / 2;
	var _step = (_radius * 2) / _pieceCount;
	
	var _pieces = array_create(_pieceCount);
	var _index = 0;
	
	for (var _i = 0; _i < _pieceCount; _i++) {
		// Half-angle of chord at near and far planes
		var _nearDist = -_radius + _step * _i;
		var _nearAcos = darccos(_nearDist / _radius);
		
		var _farDist = _nearDist + _step;
		var _farAcos = darccos(_farDist / _radius);
		
		var _vertCount = 0;
		
		// A-side arc: sweeping from nearA to farA
		for (var _s = 0; _s <= _arcSteps; _s++) {
		    var _acos = lerp(_nearAcos, _farAcos, _s / _arcSteps);
		    var _a = -_cutAngle - 90 - _acos;
		    _polyX[_vertCount] = _centerX + _radius * dcos(_a);
		    _polyY[_vertCount] = _centerY + _radius * -dsin(_a);
		    _vertCount++;
		}

		// B-side arc, sweeping from farB to nearB
		for (var _s = 0; _s <= _arcSteps; _s++) {
		    var _acos = lerp(_farAcos, _nearAcos, _s / _arcSteps);
		    var _a = -_cutAngle - 90 + _acos;
		    _polyX[_vertCount] = _centerX + _radius * dcos(_a);
		    _polyY[_vertCount] = _centerY + _radius * -dsin(_a);
		    _vertCount++;
		}
		
		// Centroid
		var _sumX = 0, _sumY = 0;
		for (var _v = 0; _v < _vertCount; _v++) {
			_sumX += _polyX[_v];
			_sumY += _polyY[_v];
		}
		var _ox = _sumX / _vertCount;
		var _oy = _sumY / _vertCount;
		
		// Vertices. Triangle fan from centroid
		var _nTris = _vertCount;
		var _cu = lerp(_u0, _u1, _ox / _w);
		var _cv = lerp(_v0, _v1, _oy / _h);
		for (var _j = 0; _j < _nTris; _j++) {
			var _ax = _polyX[_j], _ay = _polyY[_j];
			var _bx = _polyX[(_j + 1) mod _vertCount], _by = _polyY[(_j + 1) mod _vertCount];
			vertex_position(_vb, 0, 0); __FRACTURE_VCOLOR; vertex_texcoord(_vb, _cu, _cv);
			vertex_position(_vb, _ax - _ox, _ay - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
			vertex_position(_vb, _bx - _ox, _by - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
		}
		
		// Fixture. B reversed then A reversed traces the perimeter clockwise: nearB(13) → farB(7) → farA(6) → nearA(0)
		__FRACTURE_PIECE
			__primitiveType = pr_trianglelist;
			__vertexCount = _nTris * 3;
			__vertexIndex = _vertexOffset;
			
			__FRACTURE_FIXTURE_START; {
				// Stride 2 across 6 arcSteps always lands on both chord endpoints per side
				static _fxStep = 2;
				
				for (var _f = 0; _f < 4; _f++) {
					var _fi = _vertCount - 1 - _f * _fxStep;
					physics_fixture_add_point(_fx, _polyX[_fi] - _ox, _polyY[_fi] - _oy);
				}
				for (var _f = 0; _f < 4; _f++) {
					var _fi = _arcSteps - _f * _fxStep;
					physics_fixture_add_point(_fx, _polyX[_fi] - _ox, _polyY[_fi] - _oy);
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
