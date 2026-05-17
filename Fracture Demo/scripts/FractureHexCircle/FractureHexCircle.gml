// feather ignore all

/// @func FractureHexCircle()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// @param {Bool} flat Whether to use flat-top (true) or pointy-top (false) hexagons. [Default: true]
/// 
/// @desc Fractures the given circle-shaped instance into a hex pattern clipped to the circle boundary, defined by the number of columns and rows.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureHexCircle(_inst, _cols, _rows, _flat = true) {
	var _func = _flat ? __FractureHexCircleFlat : __FractureHexCirclePointy;
	return _func(_inst, _cols, _rows);
}
