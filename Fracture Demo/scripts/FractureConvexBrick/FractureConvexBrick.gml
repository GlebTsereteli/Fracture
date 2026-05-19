// feather ignore all

/// @func FractureConvexBrick()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// @param {Bool} horizontal Whether the bricks are laid horizontally or vertically. [Default: true]
/// 
/// @desc Fractures the given convex-shaped instance into a brick pattern clipped to the convex hull, defined by the number of columns and rows.
/// Alternating rows or columns are offset by half a brick width to produce the interlocking brick layout.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureConvexBrick(_inst, _cols, _rows, _horizontal = true) {
	__FRACTURE_START;
	__FRACTURE_BRICK_SETUP;
	__FRACTURE_CONVEX_HULL;
	
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
			
			// Reject bricks outside hull
			if (_x2 < _hullX1 or _x1 > _hullX2 or _y2 < _hullY1 or _y1 > _hullY2) continue;
			
			// Check all corners for each edge. Break if any corner is outside the hull
			var _fullyInside = true;
			for (var _e = 0; _e < _nHull; _e++) {
				var _edgeX1 = _edgesX1[_e], _edgeY1 = _edgesY1[_e];
				var _edgeDx = _edgesDx[_e], _edgeDy = _edgesDy[_e];
				if ((_edgeDx * (_y1 - _edgeY1) - _edgeDy * (_x1 - _edgeX1)) < 0 or
					(_edgeDx * (_y1 - _edgeY1) - _edgeDy * (_x2 - _edgeX1)) < 0 or
					(_edgeDx * (_y2 - _edgeY1) - _edgeDy * (_x1 - _edgeX1)) < 0 or
					(_edgeDx * (_y2 - _edgeY1) - _edgeDy * (_x2 - _edgeX1)) < 0) {
					_fullyInside = false;
					break;
				}
			}
			
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
