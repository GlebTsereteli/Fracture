// feather ignore all

/// @func FractureVoronoiConvex()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} pieceCount The number of Voronoi cells.
/// @param {Real} noise The seed noise intensity, from 0 to 1, where 0 produces a perfect grid and 1 is most organic. [Default: 1]
/// 
/// @desc Fractures the given convex-shaped instance into a Voronoi pattern clipped to the convex hull, defined by the number of cells.
/// Optional noise randomizes the seed positions to produce more organic-looking pieces.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureVoronoiConvex(_inst, _pieceCount) {
	__FRACTURE_START;
	
	var _hull = __FractureGetConvexHull(_inst);
	var _nHull = array_length(_hull) / 2;
	
	// Seeds
	var _centroidX = 0, _centroidY = 0;
	for (var _i = 0; _i < _nHull; _i++) {
	    _centroidX += _hull[_i * 2];
	    _centroidY += _hull[_i * 2 + 1];
	}
	_centroidX /= _nHull;
	_centroidY /= _nHull;
	
	var _seeds = array_create(_pieceCount * 2);
	for (var _i = 0; _i < _pieceCount; _i++) {
	    var _vi = (_i * _nHull div _pieceCount) mod _nHull;
	    var _vx = _hull[_vi * 2];
	    var _vy = _hull[_vi * 2 + 1];
	    var _t = random_range(0.2, 0.8);
	    _seeds[_i * 2] = lerp(_centroidX, _vx, _t);
	    _seeds[_i * 2 + 1] = lerp(_centroidY, _vy, _t);
	}
	
	// Main
	var _nSeeds = array_length(_seeds) / 2;
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
