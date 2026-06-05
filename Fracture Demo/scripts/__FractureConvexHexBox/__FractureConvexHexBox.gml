// feather ignore all

/// @ignore
function __FractureConvexHexBox(_inst, _cols, _rows, _flat) {
	var _func = _flat ? __FractureConvexHexBoxFlat : __FractureConvexHexBoxPointy;
	return _func(_inst, _cols, _rows);
}
