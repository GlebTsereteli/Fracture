// feather ignore all

/// @ignore
function __FractureConvexHexCircle(_inst, _cols, _rows, _flat = true) {
	var _func = _flat ? __FractureConvexHexCircleFlat : __FractureConvexHexCirclePointy;
	return _func(_inst, _cols, _rows);
}
