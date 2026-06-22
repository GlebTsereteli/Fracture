
/// @func FractureConvexGrid()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// @param {Real} noiseX The horizontal grid noise intensity, from 0 to 1. [Default: 1]
/// @param {Real} noiseY The vertical grid noise intensity, from 0 to 1. [Default: noiseX]
/// 
/// @desc Fractures the given convex instance into a grid of Pieces clipped to the shape boundary, defined by the number of columns and rows.
/// Optional noise offsets the grid vertices to produce more organic-looking pieces.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureConvexGrid(_inst, _shape, _cols, _rows, _noiseX = 1, _noiseY = _noiseX) {
    static _funcs = [__FractureConvexGridBox, __FractureConvexGridCircle, __FractureConvexGridHull];
    return _funcs[_shape](_inst, _cols, _rows, _noiseX, _noiseY);
}

/// @func FractureConvexBrick()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// @param {Bool} horizontal Whether bricks are laid horizontally (true) or vertically (false). [Default: true]
/// 
/// @desc Fractures the given convex instance into a brick pattern of Pieces clipped to the shape boundary, defined by the number of columns and rows.
/// Horizontal layout offsets every other row, vertical layout offsets every other column.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureConvexBrick(_inst, _shape, _cols, _rows, _horizontal = true) {
    static _funcs = [__FractureConvexBrickBox, __FractureConvexBrickCircle, __FractureConvexBrickHull];
    return _funcs[_shape](_inst, _cols, _rows, _horizontal);
}

/// @func FractureConvexDiamond()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// 
/// @desc Fractures the given convex instance into a diamond pattern of Pieces clipped to the shape boundary, defined by the number of columns and rows.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureConvexDiamond(_inst, _shape, _cols, _rows) {
    static _funcs = [__FractureConvexDiamondBox, __FractureConvexDiamondCircle, __FractureConvexDiamondHull];
    return _funcs[_shape](_inst, _cols, _rows);
}

/// @func FractureConvexHex()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// @param {Bool} flat Whether hexagons are flat-topped (true) or pointy-topped (false). [Default: true]
/// 
/// @desc Fractures the given convex instance into a hexagonal pattern of Pieces clipped to the shape boundary, defined by the number of columns and rows.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureConvexHex(_inst, _shape, _cols, _rows, _flat = true) {
    static _funcs = [__FractureConvexHexBox, __FractureConvexHexCircle, __FractureConvexHexHull];
	var _pieces = _funcs[_shape](_inst, _cols, _rows, _flat);
}

/// @func FractureConvexRadial()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
/// @param {Real} pieceCount The number of Pieces.
/// @param {Real} angleNoise The angular noise intensity, from 0 to 1. [Default: 0]
/// 
/// @desc Fractures the given convex instance into a radial pattern of Pieces clipped to the shape boundary, defined by the number of Pieces.
/// Optional noise varies the angular size of each Piece to produce more organic-looking results.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureConvexRadial(_inst, _shape, _pieceCount, _angleNoise = 0) {
    static _funcs = [__FractureConvexRadialBox, __FractureConvexRadialCircle, __FractureConvexRadialHull];
    return _funcs[_shape](_inst, _pieceCount, _angleNoise);
}

/// @func FractureConvexSlice()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
/// @param {Real} pieceCount The number of Pieces.
/// @param {Real} cutAngle The angle of the slice cuts in degrees. [Default: random(360)]
/// 
/// @desc Fractures the given convex instance into a series of parallel slices clipped to the shape boundary, defined by the number of Pieces.
/// A fixed angle produces consistent results, a random angle produces natural-looking variation.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureConvexSlice(_inst, _shape, _pieceCount, _cutAngle = random(360)) {
    static _funcs = [__FractureConvexSliceBox, __FractureConvexSliceCircle, __FractureConvexSliceHull];
    return _funcs[_shape](_inst, _pieceCount, _cutAngle);
}

/// @func FractureConvexVoronoi()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
/// @param {Real} pieceCount The number of Voronoi cells.
/// @param {Real} noise The seed noise intensity, from 0 to 1, where 0 produces a perfect grid and 1 is most organic. [Default: 1]
/// 
/// @desc Fractures the given convex instance into a Voronoi pattern of Pieces clipped to the shape boundary, defined by the number of cells.
/// Optional noise randomizes seed positions to produce more organic-looking pieces.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureConvexVoronoi(_inst, _shape, _pieceCount, _noise = 1) {
    static _funcs = [__FractureConvexVoronoiBox, __FractureConvexVoronoiCircle, __FractureConvexVoronoiHull];
    return _funcs[_shape](_inst, _pieceCount, _noise);
}
