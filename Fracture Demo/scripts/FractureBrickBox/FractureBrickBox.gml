// feather ignore all

/// @func FractureBrickBox()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// @param {Bool} horizontal Whether the bricks are laid horizontally or vertically. [Default: true]
/// 
/// @desc Fractures the given rectangle-shaped instance into a brick pattern filling the full sprite area, defined by the number of columns and rows.
/// Alternating rows or columns are offset by half a brick width to produce the interlocking brick layout.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureBrickBox(_inst, _cols, _rows, _horizontal = true) {
	__FRACTURE_START;
	__FRACTURE_BRICK_SETUP;
	
	for (var _strip = 0; _strip < _stripCount; _strip++) {
		var _even = (_strip mod 2 == 0);
		var _brickOffset = _even ? 0 : _brickSize / 2;
		var _brickStart = _even ? 0 : -1;
		var _stripA = _strip * _stripSize;
		var _stripB = _stripA + _stripSize;
		
		for (var _brick = _brickStart; _brick < _brickCount; _brick++) {
			var _brickA = _brick * _brickSize + _brickOffset;
			var _brickB = min(_brickA + _brickSize, _axisLen);
			_brickA = max(_brickA, 0);
			
			// Skip degenerate bricks
			if (_brickB <= _brickA) continue;
			
			var _x1 = _horizontal ? _brickA : _stripA;
			var _x2 = _horizontal ? _brickB : _stripB;
			var _y1 = _horizontal ? _stripA : _brickA;
			var _y2 = _horizontal ? _stripB : _brickB;
			
			__FRACTURE_BRICK_QUAD;
		}
	}
	
	__FRACTURE_END;
}
