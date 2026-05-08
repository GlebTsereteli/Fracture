// feather ignore all

function FractureBoxRadial(_inst, _pieceCount, _angleNoise = 0.5, _originX = undefined, _originY = undefined) {
	__FRACTURE_START;
	_pieceCount = max(3, _pieceCount);
	
	// Map origin to local space
	if (_originX != undefined and _originY != undefined) {
		__FRACTURE_MAP_ORIGIN;
		_originX = clamp(_originX, 1, _w - 1);
		_originY = clamp(_originY, 1, _h - 1);
	}
	
	// CCW perimeter walk: TR, TL, BL, BR, TR
	var _cornerX = [_w, 0, 0, _w];
	var _cornerY = [0, 0, _h, _h];
	
	var _pieces = array_create(_pieceCount);
	__FRACTURE_RANDOM_ANGLES;
	
	// Cast each ray from origin to bbox
	var _hitsX = array_create(_pieceCount + 1);
	var _hitsY = array_create(_pieceCount + 1);
	var _edgePositions = array_create(_pieceCount + 1);
	for (var _i = 0; _i <= _pieceCount; _i++) {
		var _rayDirX = dcos(_angles[_i]);
		var _rayDirY = -dsin(_angles[_i]);
		
		var _distTop = infinity, _distBot = infinity, _distLeft = infinity, _distRight = infinity;
		if (_rayDirY < 0) _distTop = -_originY / _rayDirY;
		if (_rayDirY > 0) _distBot = (_h - _originY) / _rayDirY;
		if (_rayDirX < 0) _distLeft = -_originX / _rayDirX;
		if (_rayDirX > 0) _distRight = (_w - _originX) / _rayDirX;
		var _hitDist = min(_distTop, _distBot, _distLeft, _distRight);
		
		var _hitX, _hitY, _edgePos;
		if (_hitDist == _distTop) {
			_hitX = _originX + _hitDist * _rayDirX;
			_hitY = 0;
			_edgePos = 1 - _hitX / _w;
		}
		else if (_hitDist == _distBot) {
			_hitX = _originX + _hitDist * _rayDirX;
			_hitY = _h;
			_edgePos = 2 + _hitX / _w;
		}
		else if (_hitDist == _distLeft) {
			_hitX = 0;
			_hitY = _originY + _hitDist * _rayDirY;
			_edgePos = 1 + _hitY / _h;
		}
		else {
			_hitX = _w;
			_hitY = _originY + _hitDist * _rayDirY;
			_edgePos = 4 - _hitY / _h;
		}
		
		_hitsX[_i] = _hitX;
		_hitsY[_i] = _hitY;
		_edgePositions[_i] = _edgePos;
	}
	
	// Arc buffer per piece: hit1, 0-4 corners, hit2
	var _fanX = array_create(6);
	var _fanY = array_create(6);
	
	for (var _i = 0; _i < _pieceCount; _i++) {
		var _hit1X = _hitsX[_i], _hit1Y = _hitsY[_i];
		var _hit2X = _hitsX[_i + 1], _hit2Y = _hitsY[_i + 1];
		var _edgePos1 = _edgePositions[_i];
		var _edgePos2 = _edgePositions[_i + 1];
		if (_edgePos2 < _edgePos1) _edgePos2 += 4;
		
		var _cornerStart = floor(_edgePos1) + 1;
		var _cornerEnd = ceil(_edgePos2) - 1;
		var _cornerCount = max(0, _cornerEnd - _cornerStart + 1);
		var _fanCount = 2 + _cornerCount;
		
		_fanX[0] = _hit1X;
		_fanY[0] = _hit1Y;
		for (var _j = 0; _j < _cornerCount; _j++) {
			var _cornerIndex = (_cornerStart + _j) mod 4;
			_fanX[_j + 1] = _cornerX[_cornerIndex];
			_fanY[_j + 1] = _cornerY[_cornerIndex];
		}
		_fanX[_fanCount - 1] = _hit2X;
		_fanY[_fanCount - 1] = _hit2Y;
		
		// Centroid over origin + all fan points
		var _ox = _originX, _oy = _originY;
		for (var _j = 0; _j < _fanCount; _j++) {
			_ox += _fanX[_j];
			_oy += _fanY[_j];
		}
		_ox /= (_fanCount + 1);
		_oy /= (_fanCount + 1);
		
		// Vertices
		var _localOriginX = _originX - _ox;
		var _localOriginY = _originY - _oy;
		var _ou = lerp(_u0, _u1, _originX / _w);
		var _ov = lerp(_v0, _v1, _originY / _h);
		var _nTris = _fanCount - 1;
		for (var _j = 0; _j < _nTris; _j++) {
			var _ax = _fanX[_j], _ay = _fanY[_j];
			var _bx = _fanX[_j + 1], _by = _fanY[_j + 1];
			vertex_position(_vb, _localOriginX, _localOriginY); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _ou, _ov);
			vertex_position(_vb, _ax - _ox, _ay - _oy); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
			vertex_position(_vb, _bx - _ox, _by - _oy); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
		}
		
		// Piece
		__FRACTURE_PIECE
			__vertexCount = _nTris * 3;
			__vertexIndex = _vertexOffset;
			
			__FRACTURE_FIXTURE_START; {
				physics_fixture_add_point(_fx, _localOriginX, _localOriginY);
				for (var _j = _fanCount - 1; _j >= 0; _j--) {
					physics_fixture_add_point(_fx, _fanX[_j] - _ox, _fanY[_j] - _oy);
				}
				__FRACTURE_FIXTURE_END;
			}
			
			_pieces[_i] = id;
		}
		_vertexOffset += _nTris * 3;
	}
	
	__FRACTURE_END;
}
