// feather ignore all

/// @func FractureConvexHex()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// @param {Bool} flat Whether to use flat-top (true) or pointy-top (false) hexagons. [Default: true]
/// 
/// @desc Fractures the given convex-shaped instance into a hex pattern clipped to the convex hull boundary, defined by the number of columns and rows.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureConvexHex(_inst, _cols, _rows, _flat = true) {
    var _func = _flat ? __FractureConvexHexFlat : __FractureConvexHexPointy;
    return _func(_inst, _cols, _rows);
}
