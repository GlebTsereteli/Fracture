// feather ignore all

/// @func FractureBoxVoronoi()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} pieceCount The number of Voronoi cells.
/// @param {Real} noise The seed noise intensity, from 0 to 1, where 0 produces a perfect grid and 1 is most organic. [Default: 1]
/// 
/// @desc Fractures the given rectangle-shaped instance into a Voronoi pattern filling the full sprite area, defined by the number of cells.
/// Optional noise randomizes the seed positions to produce more organic-looking pieces.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureBoxVoronoi(_inst, _pieceCount, _noise = 1) {
	__FRACTURE_START;
	
	// Seeds
	_noise = clamp(_noise, 0, 1) * __FRACTURE_VORONOI_BOX_MAX_NOISE;
	
	var _nSeeds = _pieceCount;
	var _cols = max(1, round(sqrt(_pieceCount * _w / _h)));
	var _rows = max(1, ceil(_pieceCount / _cols));
	var _cellW = _w / _cols;
	var _cellH = _h / _rows;
	
	var _seeds = array_create(_nSeeds * 2);
	var _index = 0;
	for (var _row = 0; _row < _rows; _row++) {
	    for (var _col = 0; _col < _cols; _col++) {
	        if (_index >= _nSeeds * 2) break;
			
	        _seeds[_index++] = (_col + 0.5 + (_row mod 2) * 0.5 * _noise + random_range(-_noise, _noise)) * _cellW;
	        _seeds[_index++] = (_row + 0.5 + random_range(-_noise, _noise)) * _cellH;
	    }
	}
	
	// Voronoi
	var _pieces = array_create(_pieceCount);
	_index = 0;
	
	for (var _i = 0; _i < _nSeeds; _i++) {
	   var _polygon = [0, 0, 0, _h, _w, _h, _w, 0];
		
	    __FRACTURE_VORONOI_CLIP;
	    __FRACTURE_VORONOI_VERTS;
		__FRACTURE_VORONOI_PIECE;
	}
	
	__FRACTURE_END;
}
