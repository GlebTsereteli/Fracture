// feather ignore all

/// @ignore
function __FractureConvexVoronoiCircle(_inst, _pieceCount) {
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
