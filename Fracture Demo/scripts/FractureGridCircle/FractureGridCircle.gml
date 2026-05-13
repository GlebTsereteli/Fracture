// feather ignore all

function FractureGridCircle(_inst, _cols, _rows, _noiseX = 1, _noiseY = _noiseX) {
	__FRACTURE_START;
	__FRACTURE_GRID_SETUP;
	__FRACTURE_CIRCLE_HULL;
	
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
			
			// Reject cells whose nearest AABB point is outside the circle
			var _nearX = clamp(_centerX, min(_x1, _x2, _x3, _x4), max(_x1, _x2, _x3, _x4));
			var _nearY = clamp(_centerY, min(_y1, _y2, _y3, _y4), max(_y1, _y2, _y3, _y4));
			var _nearDx = _nearX - _centerX;
			var _nearDy = _nearY - _centerY;
			if (_nearDx * _nearDx + _nearDy * _nearDy > _radiusSq) continue;
			
			// Check if all 4 corners are inside the circle
			var _dx1 = _x1 - _centerX, _dy1 = _y1 - _centerY;
			var _dx2 = _x2 - _centerX, _dy2 = _y2 - _centerY;
			var _dx3 = _x3 - _centerX, _dy3 = _y3 - _centerY;
			var _dx4 = _x4 - _centerX, _dy4 = _y4 - _centerY;
			var _fullyInside = (
				_dx1 * _dx1 + _dy1 * _dy1 <= _radiusSq and
				_dx2 * _dx2 + _dy2 * _dy2 <= _radiusSq and
				_dx3 * _dx3 + _dy3 * _dy3 <= _radiusSq and
				_dx4 * _dx4 + _dy4 * _dy4 <= _radiusSq
			);
			
			if (_fullyInside) {
				__FRACTURE_GRID_QUAD;
			}
			else {
				_cell[0] = _x1; _cell[1] = _y1;
				_cell[2] = _x2; _cell[3] = _y2;
				_cell[4] = _x3; _cell[5] = _y3;
				_cell[6] = _x4; _cell[7] = _y4;
				__FRACTURE_CLIP_PIECE;
			}
		}
		
		__FRACTURE_GRID_SWAP;
	}
	
	_pieceCount = _index;
	array_resize(_pieces, _pieceCount);
	
	__FRACTURE_END;
}
