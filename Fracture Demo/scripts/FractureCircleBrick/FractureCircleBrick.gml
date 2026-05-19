// feather ignore all

/// @func FractureCircleBrick()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// @param {Bool} horizontal Whether the bricks are laid horizontally or vertically. [Default: true]
/// 
/// @desc Fractures the given circle-shaped instance into a brick pattern clipped to the circle boundary, defined by the number of columns and rows.
/// Alternating rows or columns are offset by half a brick width to produce the interlocking brick layout.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureCircleBrick(_inst, _cols, _rows, _horizontal = true) {
	__FRACTURE_START;
	__FRACTURE_BRICK_SETUP;
	__FRACTURE_CIRCLE_HULL;
	
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
			
			// Reject bricks outside radius
			var _nearX = clamp(_centerX, _x1, _x2);
			var _nearY = clamp(_centerY, _y1, _y2);
			var _nearDx = _nearX - _centerX;
			var _nearDy = _nearY - _centerY;
			if (_nearDx * _nearDx + _nearDy * _nearDy > _radiusSq) continue;
			
			// Check if all 4 corners are inside the circle
			var _dx1 = _x1 - _centerX, _dy1 = _y1 - _centerY;
			var _dx2 = _x2 - _centerX, _dy2 = _y2 - _centerY;
			var _fullyInside = (
				_dx1 * _dx1 + _dy1 * _dy1 <= _radiusSq and
				_dx2 * _dx2 + _dy1 * _dy1 <= _radiusSq and
				_dx1 * _dx1 + _dy2 * _dy2 <= _radiusSq and
				_dx2 * _dx2 + _dy2 * _dy2 <= _radiusSq
			);
			
			if (_fullyInside) {
				__FRACTURE_BRICK_QUAD;
			}
			else {
				_cell[0] = _x1; _cell[1] = _y1;
				_cell[2] = _x2; _cell[3] = _y1;
				_cell[4] = _x2; _cell[5] = _y2;
				_cell[6] = _x1; _cell[7] = _y2;
				__FRACTURE_CLIP_PIECE;
			}
		}
	}
	
	_pieceCount = _index;
	array_resize(_pieces, _pieceCount);
	__FRACTURE_END;
}
