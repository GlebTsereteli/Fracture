// feather ignore all

/// @func FractureConvexRadial()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} pieceCount The number of radial pieces.
/// @param {Real} angleNoise The angle noise intensity, from 0 to 1. [Default: 0.5]
/// @param {Real} originX The x origin of the radial pattern in world space. [Default: instance center]
/// @param {Real} originY The y origin of the radial pattern in world space. [Default: instance center]
/// 
/// @desc Fractures the given convex-shaped instance into a radial pattern clipped to the convex hull, defined by the number of pieces.
/// Optional angle noise randomizes the slice angles to produce more organic-looking pieces.
/// If both originX and originY are provided, the radial pattern originates from that point. Otherwise the instance center is used.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureConvexRadial(_inst, _pieceCount, _angleNoise = 0.5, _originX = undefined, _originY = undefined) {
	__FRACTURE_START;
	_pieceCount = max(3, _pieceCount);
	
	var _hull = __FractureGetConvexHull(_inst);
	var _nHull = array_length(_hull) / 2;
	
	#region Map origin
	
	var _centroidX = 0;
	var _centroidY = 0;
	for (var _i = 0; _i < _nHull; _i++) {
		_centroidX += _hull[_i * 2];
		_centroidY += _hull[_i * 2 + 1];
	}
	_centroidX /= _nHull;
	_centroidY /= _nHull;
	
	if (_originX == undefined and _originY == undefined) {
		_originX = _centroidX;
		_originY = _centroidY;
	}
	else {
		__FRACTURE_MAP_ORIGIN;
		
		// Reset to centroid if custom origin falls outside the hull
		var _outside = false;
		for (var _i = 0; _i < _nHull; _i++) {
			var _ax = _hull[_i * 2];
			var _ay = _hull[_i * 2 + 1];
			var _bx = _hull[((_i + 1) mod _nHull) * 2];
			var _by = _hull[((_i + 1) mod _nHull) * 2 + 1];
			var _cross = (_bx - _ax) * (_originY - _ay) - (_by - _ay) * (_originX - _ax);
			if (_cross > 0) {
				_originX = _centroidX;
				_originY = _centroidY;
				break;
			}
		}
	}
	
	#endregion
	#region Cast rays to hull
	
	var _pieces = array_create(_pieceCount);
	__FRACTURE_RANDOM_ANGLES;
	
	var _hitsX = array_create(_pieceCount + 1);
	var _hitsY = array_create(_pieceCount + 1);
	for (var _i = 0; _i <= _pieceCount; _i++) {
		var _rayDirX = dcos(_angles[_i]);
		var _rayDirY = -dsin(_angles[_i]);
		var _bestT = infinity;
		var _bestHitX = 0, _bestHitY = 0;
		
		// Test against each hull edge, keep nearest hit
		for (var _j = 0; _j < _nHull; _j++) {
			var _hax = _hull[_j * 2];
			var _hay = _hull[_j * 2 + 1];
			var _hbx = _hull[((_j + 1) mod _nHull) * 2];
			var _hby = _hull[((_j + 1) mod _nHull) * 2 + 1];
			var _edgeDx = _hbx - _hax;
			var _edgeDy = _hby - _hay;
			var _denom = _rayDirX * _edgeDy - _rayDirY * _edgeDx;
			if (abs(_denom) < 0.0001) continue;
			
			var _toAx = _hax - _originX;
			var _toAy = _hay - _originY;
			var _t = (_toAx * _edgeDy - _toAy * _edgeDx) / _denom;
			var _edgeT = (_toAx * _rayDirY - _toAy * _rayDirX) / _denom;
			
			if (_t > 0.001 and _edgeT >= -0.001 and _edgeT <= 1.001 and _t < _bestT) {
				_bestT = _t;
				_bestHitX = _originX + _t * _rayDirX;
				_bestHitY = _originY + _t * _rayDirY;
			}
		}
		
		_hitsX[_i] = _bestHitX;
		_hitsY[_i] = _bestHitY;
	}
	
	#endregion
	#region Build pieces
	
	// Reused per piece: perimeter arc from hit1 to hit2
	var _fanX = array_create(_nHull + 2);
	var _fanY = array_create(_nHull + 2);
	
	// Reused per piece: hull vertices falling inside this sector
	var _cornerAngles = array_create(_nHull);
	var _cornerIndices = array_create(_nHull);
	
	var _xl = 0, _yt = 0;
	var _index = 0;
	
	for (var _i = 0; _i < _pieceCount; _i++) {
		var _a1 = _angles[_i];
		var _a2 = _angles[_i + 1];
		
		#region Collect and sort hull corners in sector
		
		_fanX[0] = _hitsX[_i];
		_fanY[0] = _hitsY[_i];
		var _fanCount = 1;
		var _cornerCount = 0;
		
		for (var _j = 0; _j < _nHull; _j++) {
			var _vx = _hull[_j * 2];
			var _vy = _hull[_j * 2 + 1];
			var _va = point_direction(_originX, _originY, _vx, _vy);
			while (_va < _a1) {
				_va += 360;
			}
			if (_va < _a2) {
				_cornerAngles[_cornerCount] = _va;
				_cornerIndices[_cornerCount] = _j;
				_cornerCount++;
			}
		}
		
		// Insertion sort by angle
		for (var _j = 1; _j < _cornerCount; _j++) {
			var _key = _cornerAngles[_j];
			var _keyIndex = _cornerIndices[_j];
			var _k = _j - 1;
			while (_k >= 0 and _cornerAngles[_k] > _key) {
				_cornerAngles[_k + 1] = _cornerAngles[_k];
				_cornerIndices[_k + 1] = _cornerIndices[_k];
				_k--;
			}
			_cornerAngles[_k + 1] = _key;
			_cornerIndices[_k + 1] = _keyIndex;
		}
		
		// Append sorted corners then second hit to close the arc
		for (var _j = 0; _j < _cornerCount; _j++) {
			_fanX[_fanCount] = _hull[_cornerIndices[_j] * 2];
			_fanY[_fanCount] = _hull[_cornerIndices[_j] * 2 + 1];
			_fanCount++;
		}
		_fanX[_fanCount] = _hitsX[_i + 1];
		_fanY[_fanCount] = _hitsY[_i + 1];
		_fanCount++;
		
		#endregion
		#region Compute piece centroid and UV origin
		
		var _ox = _originX, _oy = _originY;
		for (var _j = 0; _j < _fanCount; _j++) {
			_ox += _fanX[_j];
			_oy += _fanY[_j];
		}
		_ox /= (_fanCount + 1);
		_oy /= (_fanCount + 1);
		
		var _localOriginX = _originX - _ox;
		var _localOriginY = _originY - _oy;
		var _ou = lerp(_u0, _u1, _originX / _w);
		var _ov = lerp(_v0, _v1, _originY / _h);
		var _nTris = _fanCount - 1;
		
		#endregion
		
		// Vertices
		for (var _j = 0; _j < _nTris; _j++) {
			var _ax = _fanX[_j], _ay = _fanY[_j];
			var _bx = _fanX[_j + 1], _by = _fanY[_j + 1];
			vertex_position(_vb, _localOriginX, _localOriginY); __FRACTURE_VCOLOR; vertex_texcoord(_vb, _ou, _ov);
			vertex_position(_vb, _ax - _ox, _ay - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
			vertex_position(_vb, _bx - _ox, _by - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
		}
		
		// Piece
		__FRACTURE_PIECE
			__primitiveType = pr_trianglelist;
			__vertexCount = _nTris * 3;
			__vertexIndex = _vertexOffset;
			
			// Fixture: evenly sample fan up to the 8-point limit
			__FRACTURE_FIXTURE_START; {
				var _fxTotal = min(_fanCount, 7);
				physics_fixture_add_point(_fx, _localOriginX, _localOriginY);
				for (var _j = _fxTotal - 1; _j >= 0; _j--) {
					var _fxIndex = round(_j * (_fanCount - 1) / (_fxTotal - 1));
					physics_fixture_add_point(_fx,
						_fanX[_fxIndex] - _ox,
						_fanY[_fxIndex] - _oy
					);
				}
				__FRACTURE_FIXTURE_END;
			}
			
			_pieces[_index++] = id;
		}
		
		_vertexOffset += _nTris * 3;
	}
	
	#endregion
	
	__FRACTURE_END;
}
