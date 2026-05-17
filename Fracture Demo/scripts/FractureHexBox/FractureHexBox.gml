// feather ignore all

/// @func FractureHexBox()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// @param {Bool} pointy Whether the hexagons are pointy-topped (true) or flat-topped (false).
/// 
/// @desc Fractures the given rectangle-shaped instance into a hexagonal grid filling the full sprite area, defined by the number of columns and rows.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureHexBox(_inst, _cols, _rows, _pointy) {
	var _func = _pointy ? __FractureBoxHexPointy : __FractureBoxHexFlat;
	return _func(_inst, _cols, _rows);
}
