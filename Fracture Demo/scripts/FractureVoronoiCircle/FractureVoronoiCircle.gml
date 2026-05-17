// feather ignore all

/// @func FractureVoronoiCircle()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} pieceCount The number of Voronoi cells.
/// @param {Real} noise The seed noise intensity, from 0 to 1, where 0 produces a perfect grid and 1 is most organic. [Default: 1]
/// 
/// @desc Fractures the given circle-shaped instance into a Voronoi pattern clipped to the circle boundary, defined by the number of cells.
/// Optional noise randomizes the seed positions to produce more organic-looking pieces.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureVoronoiCircle(_inst, _pieceCount) {
	__FRACTURE_START;
	__FRACTURE_CIRCLE_HULL;
	
	// Seeds
	var _nSeeds = _pieceCount;
	var _seeds = array_create(_nSeeds * 2);
	
	for (var _i = 0; _i < _nSeeds; _i++) {
		var _a = _i * __FRACTURE_GOLDEN_ANGLE;
		var _r = _radius * sqrt(_i / _nSeeds);
		_seeds[_i * 2] = _centerX + lengthdir_x(_r, _a);
		_seeds[_i * 2 + 1] = _centerY + lengthdir_y(_r, _a);
	}
	
	// Main
	var _index = 0;
	var _pieces = array_create(_pieceCount);
	
	for (var _i = 0; _i < _nSeeds; _i++) {
	    var _polygon = _hull;
	    __FRACTURE_VORONOI_CLIP;
	    __FRACTURE_VORONOI_VERTS;
	    __FRACTURE_VORONOI_PIECE;
	}
	
	__FRACTURE_END;
}
