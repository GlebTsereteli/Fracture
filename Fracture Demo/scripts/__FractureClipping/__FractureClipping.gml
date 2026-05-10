// feather ignore all

function __FracturePolygonClip(_polygon, _clipPolygon) {
	static _maxVerts = __FRACTURE_CIRCLE_PRECISION + 4;
	static _bufferA = array_create(_maxVerts * 2, 0);
	static _bufferB = array_create(_maxVerts * 2, 0);
	static _dists = array_create(_maxVerts, 0);
	
	var _clipCount = array_length(_clipPolygon) / 2;
	var _inCount = array_length(_polygon) / 2;
	array_copy(_bufferA, 0, _polygon, 0, _inCount * 2);
	
	var _ping = _bufferA;
	var _pong = _bufferB;
	
	for (var _i = 0; _i < _clipCount; _i++) {
		var _i2 = _i + 1;
		if (_i2 == _clipCount) {
			_i2 = 0;
		}
		
		var _ex = _clipPolygon[_i * 2];
		var _ey = _clipPolygon[_i * 2 + 1];
		var _nx = _clipPolygon[_i2 * 2 + 1] - _ey;
		var _ny = _ex - _clipPolygon[_i2 * 2];
		
		// Precompute distances and check for simple cases
		var _allInside = true;
		var _allOutside = true;
		for (var _j = 0; _j < _inCount; _j++) {
			var _dist = (_ping[_j * 2] - _ex) * _nx + (_ping[_j * 2 + 1] - _ey) * _ny;
			_dists[_j] = _dist;
			if (_dist >= 0) {
				_allOutside = false;
			}
			else {
				_allInside = false;
			}
		}
		
		if (_allInside) continue;
		if (_allOutside) return [];
		
		// Clip against this edge, write surviving vertices to pong
		var _outCount = 0;
		for (var _j = 0; _j < _inCount; _j++) {
			var _j2 = _j + 1;
			if (_j2 == _inCount) {
				_j2 = 0;
			}
			
			var _dist1 = _dists[_j];
			var _dist2 = _dists[_j2];
			var _v1Inside = (_dist1 >= 0);
			var _v1x = _ping[_j * 2];
			var _v1y = _ping[_j * 2 + 1];
			
			if (_v1Inside) {
				_pong[_outCount * 2] = _v1x;
				_pong[_outCount * 2 + 1] = _v1y;
				_outCount++;
			}
			
			if (_v1Inside != (_dist2 >= 0)) {
				var _t = _dist1 / (_dist1 - _dist2);
				var _v2x = _ping[_j2 * 2];
				var _v2y = _ping[_j2 * 2 + 1];
				_pong[_outCount * 2] = _v1x + _t * (_v2x - _v1x);
				_pong[_outCount * 2 + 1] = _v1y + _t * (_v2y - _v1y);
				_outCount++;
			}
		}
		
		// Swap buffers for the next plane
		var _swap = _ping;
		_ping = _pong;
		_pong = _swap;
		_inCount = _outCount;
		
		if (_inCount < 3) return [];
	}
	
	// Copy result out of the static buffer into a fresh array
	var _result = array_create(_inCount * 2);
	array_copy(_result, 0, _ping, 0, _inCount * 2);
	
	return _result;
}
function __FracturePolygonClipHalfPlane(_polygon, _bisectorX, _bisectorY, _normalX, _normalY) {
	var _n = array_length(_polygon) / 2;
	if (_n == 0) return [];
	
	var _result = [];
	
	var _v1x = _polygon[(_n - 1) * 2];
	var _v1y = _polygon[(_n - 1) * 2 + 1];
	var _v1Dist = ((_v1x - _bisectorX) * _normalX) + ((_v1y - _bisectorY) * _normalY);
	var _v1Inside = (_v1Dist >= 0);
	
	for (var _i = 0; _i < _n; _i++) {
		var _v2x = _polygon[_i * 2];
		var _v2y = _polygon[_i * 2 + 1];
		var _v2Dist = ((_v2x - _bisectorX) * _normalX) + ((_v2y - _bisectorY) * _normalY);
		var _v2Inside = (_v2Dist >= 0);
		
		if (_v1Inside != _v2Inside) {
			var _t = _v1Dist / (_v1Dist - _v2Dist);
			array_push(_result,
				_v1x + _t * (_v2x - _v1x),
				_v1y + _t * (_v2y - _v1y)
			);
		}
		
		if (_v2Inside) {
			array_push(_result, _v2x, _v2y);
		}
		
		_v1x = _v2x;
		_v1y = _v2y;
		_v1Dist = _v2Dist;
		_v1Inside = _v2Inside;
	}
	
	return _result;
}
