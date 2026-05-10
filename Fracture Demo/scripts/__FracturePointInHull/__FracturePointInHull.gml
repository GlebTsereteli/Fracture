// feather ignore all

function __FracturePointInHull(_x, _y, _hull, _hullCount, _windingSign) {
	for (var _i1 = 0; _i1 < _hullCount; _i1++) {
		var _i2 = (_i1 + 1) mod _hullCount;
		var _x1 = _hull[_i1 * 2], _y1 = _hull[_i1 * 2 + 1];
		var _x2 = _hull[_i2 * 2], _y2 = _hull[_i2 * 2 + 1];
		
		var _cross = (_x2 - _x1) * (_y - _y1) - (_y2 - _y1) * (_x - _x1);
		if ((_cross * _windingSign) < 0) {
			return false;
		}
	}
	return true;
}
