// feather ignore all

/// @ignore
function __FractureConvexZigzagBox(_inst, _pieceCount, _tipNoise) {
	__FRACTURE_START;
	
	_pieceCount = max(_pieceCount, 2);
	
	// Tips alternate between left and right edges, going top to bottom.
	// First and last tips are paired with opposite corners to close the shape.
	var _tipCount = _pieceCount + 2;
	var _tipX = array_create(_tipCount);
	var _tipY = array_create(_tipCount);
	
	var _tipStep = _h / (_pieceCount - 1);
	var _maxOffset = _tipStep * __FRACTURE_ZIGZAG_MAX_NOISE * _tipNoise;
	var _noisy = (_maxOffset > 0);
	
	for (var _i = 0; _i < _pieceCount; _i++) {
		var _y = _tipStep * _i;
		if (_noisy and (_i > 0) and (_i < _pieceCount - 1)) {
			_y += random_range(-_maxOffset, _maxOffset);
		}
		
		_tipX[_i + 1] = ((_i mod 2) == 0) ? 0 : _w;
		_tipY[_i + 1] = _y;
	}
	
	// Closing corners
	_tipX[0] = _w - _tipX[1];
	_tipY[0] = 0;
	_tipX[_tipCount - 1] = _w - _tipX[_tipCount - 2];
	_tipY[_tipCount - 1] = _h;
	
	var _xl = 0;
	var _yt = 0;
	var _pieces = array_create(_pieceCount);
	var _index = 0;
	
	for (var _i = 0; _i < _pieceCount; _i++) {
		var _ax = _tipX[_i], _ay = _tipY[_i];
		var _bx = _tipX[_i + 1], _by = _tipY[_i + 1];
		var _cx = _tipX[_i + 2], _cy = _tipY[_i + 2];
		
		// Alternating triangles wind in opposite directions, we need CW
		if (((_bx - _ax) * (_cy - _ay) - (_by - _ay) * (_cx - _ax)) < 0) {
			var _tx = _bx; _bx = _cx; _cx = _tx;
			var _ty = _by; _by = _cy; _cy = _ty;
		}
		
		__FRACTURE_BOX_TRI;
	}
	
	__FRACTURE_END;
}
