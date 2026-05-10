// feather ignore all

function FractureBoxGrid(_inst, _cols, _rows, _noiseX = 1, _noiseY = _noiseX) {
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
			
			if (_iFirst or (_j == 0)) continue;
			
			var _x1 = _prevColX[_j - 1], _y1 = _prevColY[_j - 1];
			var _x2 = _colX[_j - 1], _y2 = _colY[_j - 1];
			var _x4 = _prevColX[_j], _y4 = _prevColY[_j];
			
			var _ox = (_x1 + _x2 + _x3 + _x4) * 0.25;
			var _oy = (_y1 + _y2 + _y3 + _y4) * 0.25;
			
			__FRACTURE_GRID_QUAD;
		}
		
		var _tempX = _prevColX;
		var _tempY = _prevColY;
		_prevColX = _colX;
		_prevColY = _colY;
		_colX = _tempX;
		_colY = _tempY;
	}
	
	__FRACTURE_END;
}
