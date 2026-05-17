// feather ignore all

/// @func FractureGridBox()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// @param {Real} noiseX The horizontal grid noise intensity, from 0 to 1. [Default: 1]
/// @param {Real} noiseY The vertical grid noise intensity, from 0 to 1. [Default: noiseX]
/// 
/// @desc Fractures the given rectangle-shaped instance into a grid of quads filling the full sprite area, defined by the number of columns and rows.
/// Optional noise offsets the grid vertices to produce more organic-looking pieces.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureGridBox(_inst, _cols, _rows, _noiseX = 1, _noiseY = _noiseX) {
	__FRACTURE_START;
	__FRACTURE_GRID_SETUP;
	
	for (var _i = 0; _i <= _cols; _i++) {
		var _iFirst = (_i == 0);
		var _iOnEdge = (_iFirst or (_i == _cols));
		
		for (var _j = 0; _j <= _rows; _j++) {
			var _x3 = _i * _spacingX;
			var _y3 = _j * _spacingY;
			
			if (not _iOnEdge) {
				_x3 += random_range(-_noiseX, _noiseX);
			}
			if ((_j > 0) and (_j < _rows)) {
				_y3 += random_range(-_noiseY, _noiseY);
			}
			
			_colX[_j] = _x3;
			_colY[_j] = _y3;
			
			// Skip until we have a full quad
			if (_iFirst or (_j == 0)) continue;
			
			var _x1 = _prevColX[_j - 1], _y1 = _prevColY[_j - 1];
			var _x2 = _colX[_j - 1], _y2 = _colY[_j - 1];
			var _x4 = _prevColX[_j], _y4 = _prevColY[_j];
			
			__FRACTURE_GRID_QUAD;
		}
		
		__FRACTURE_GRID_SWAP;
	}
	
	__FRACTURE_END;
}
