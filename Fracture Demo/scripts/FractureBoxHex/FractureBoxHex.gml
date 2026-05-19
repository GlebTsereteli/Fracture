// feather ignore all

/// @func FractureBoxHex()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// @param {Bool} flat Whether to use flat-top (true) or pointy-top (false) hexagons. [Default: true]
/// 
/// @desc Fractures the given rectangle-shaped instance into a hexagonal grid filling the full sprite area, defined by the number of columns and rows.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureBoxHex(_inst, _cols, _rows, _flat = true) {
	var _func = _flat ? __FractureBoxHexFlat : __FractureBoxHexPointy;
	return _func(_inst, _cols, _rows);
}
