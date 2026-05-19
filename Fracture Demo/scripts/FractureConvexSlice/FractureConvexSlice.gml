// feather ignore all

/// @func FractureConvexSlice()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} pieceCount The number of slices.
/// @param {Real} cutAngle The angle of the cuts. [Default: random]
/// 
/// @desc Fractures the given convex-shaped instance into parallel slices clipped to the convex hull, defined by the number of pieces.
/// The cut angle controls the orientation of the slices.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureConvexSlice(_inst, _pieceCount, _cutAngle = random(360)) {
	static _projs = array_create(__FRACTURE_CONVEX_HULL_PRECISION + 4);
	static _polyX = array_create(__FRACTURE_CONVEX_HULL_PRECISION + 4);
	static _polyY = array_create(__FRACTURE_CONVEX_HULL_PRECISION + 4);
	
	__FRACTURE_START;
	__FRACTURE_CONVEX_HULL;
	
	// Project hull vertices onto cut normal, find extent
	var _nx = -dsin(_cutAngle);
	var _ny = dcos(_cutAngle);
	
	var _projMin = infinity;
	var _projMax = -infinity;
	for (var _i = 0; _i < _nHull; _i++) {
		var _proj = _hull[_i * 2] * _nx + _hull[_i * 2 + 1] * _ny;
		_projs[_i] = _proj;
		if (_proj < _projMin) _projMin = _proj;
		if (_proj > _projMax) _projMax = _proj;
	}
	var _step = (_projMax - _projMin) / _pieceCount;
	
	var _pieces = array_create(_pieceCount);
	var _index = 0;
	
	for (var _i = 0; _i < _pieceCount; _i++) {
		var _nearBound = _projMin + _step * _i;
		var _farBound = _nearBound + _step;
		
		// Walk hull edges, collect inside vertices and boundary intersections
		var _polyCount = 0;
		for (var _j = 0; _j < _nHull; _j++) {
			var _j2 = (_j + 1) mod _nHull;
			var _pj = _projs[_j], _pj2 = _projs[_j2];
			var _vjx = _hull[_j * 2], _vjy = _hull[_j * 2 + 1];
			var _vj2x = _hull[_j2 * 2], _vj2y = _hull[_j2 * 2 + 1];
			
			if (_pj >= _nearBound and _pj <= _farBound) {
				_polyX[_polyCount] = _vjx;
				_polyY[_polyCount] = _vjy;
				_polyCount++;
			}
			
			var _crossesNear = (_pj < _nearBound) != (_pj2 < _nearBound);
			var _crossesFar = (_pj > _farBound) != (_pj2 > _farBound);
			
			if (_crossesNear and _crossesFar) {
				// Edge spans both planes. Sort by t so intersections are added in traversal order
				var _tNear = (_nearBound - _pj) / (_pj2 - _pj);
				var _tFar = (_farBound - _pj) / (_pj2 - _pj);
				var _tFirst = min(_tNear, _tFar);
				var _tSecond = max(_tNear, _tFar);
				
				// Strict bounds exclude edge endpoints already added as inside vertices
				if (_tFirst > 0 and _tFirst < 1) {
					_polyX[_polyCount] = lerp(_vjx, _vj2x, _tFirst);
					_polyY[_polyCount] = lerp(_vjy, _vj2y, _tFirst);
					_polyCount++;
				}
				if (_tSecond > 0 and _tSecond < 1) {
					_polyX[_polyCount] = lerp(_vjx, _vj2x, _tSecond);
					_polyY[_polyCount] = lerp(_vjy, _vj2y, _tSecond);
					_polyCount++;
				}
			}
			else {
				// Strict bounds exclude edge endpoints already added as inside vertices
				if (_crossesNear) {
					var _tNear = (_nearBound - _pj) / (_pj2 - _pj);
					if (_tNear > 0 and _tNear < 1) {
						_polyX[_polyCount] = lerp(_vjx, _vj2x, _tNear);
						_polyY[_polyCount] = lerp(_vjy, _vj2y, _tNear);
						_polyCount++;
					}
				}
				if (_crossesFar) {
					var _tFar = (_farBound - _pj) / (_pj2 - _pj);
					if (_tFar > 0 and _tFar < 1) {
						_polyX[_polyCount] = lerp(_vjx, _vj2x, _tFar);
						_polyY[_polyCount] = lerp(_vjy, _vj2y, _tFar);
						_polyCount++;
					}
				}
			}
		}
		if (_polyCount < 3) continue;
		
		// Centroid
		var _sumX = 0, _sumY = 0;
		for (var _v = 0; _v < _polyCount; _v++) {
			_sumX += _polyX[_v];
			_sumY += _polyY[_v];
		}
		var _ox = _sumX / _polyCount;
		var _oy = _sumY / _polyCount;
		
		// Vertices. Triangle fan from vertex 0
		var _triCount = _polyCount - 2;
		for (var _t = 0; _t < _triCount; _t++) {
			_px = _polyX[0] - _ox; _py = _polyY[0] - _oy; __FRACTURE_V;
			_px = _polyX[_t + 1] - _ox; _py = _polyY[_t + 1] - _oy; __FRACTURE_V;
			_px = _polyX[_t + 2] - _ox; _py = _polyY[_t + 2] - _oy; __FRACTURE_V;
		}
		
		// Fixture
		var _fixtureCount = min(_polyCount, 8);
		__FRACTURE_PIECE
			__primitiveType = pr_trianglelist;
			__vertexCount = _triCount * 3;
			__vertexIndex = _vertexOffset;
			
			// Stride evenly around the perimeter so the 8-point cap covers
			// the whole polygon instead of one side. Reverse for CW winding
			__FRACTURE_FIXTURE_START; {
				for (var _f = _fixtureCount - 1; _f >= 0; _f--) {
					var _fi = (_f * _polyCount) div _fixtureCount;
					physics_fixture_add_point(_fx, _polyX[_fi] - _ox, _polyY[_fi] - _oy);
				}
				__FRACTURE_FIXTURE_END;
			}
			
			_pieces[_index++] = id;
		}
		
		_vertexOffset += _triCount * 3;
	}
	
	_pieceCount = _index;
	array_resize(_pieces, _pieceCount);
	
	__FRACTURE_END;
}
