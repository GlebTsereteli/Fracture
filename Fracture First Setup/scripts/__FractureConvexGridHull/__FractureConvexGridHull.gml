// feather ignore all

/// @ignore
function __FractureConvexGridHull(_inst, _cols, _rows, _noiseX, _noiseY) {
	__FRACTURE_START;
	__FRACTURE_GRID_SETUP;
	__FRACTURE_CONVEX_HULL;
	
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
			
			// Bbox reject before the hull test
			if ((max(_x1, _x2, _x3, _x4) < _hullX1) or (min(_x1, _x2, _x3, _x4) > _hullX2)) continue;
			if ((max(_y1, _y2, _y3, _y4) < _hullY1) or (min(_y1, _y2, _y3, _y4) > _hullY2)) continue;
			
			// Check all corners for each edge. Break if any corner is outside the hull
			var _fullyInside = true;
			for (var _e = 0; _e < _nHull; _e++) {
			    var _edgeX1 = _edgesX1[_e], _edgeY1 = _edgesY1[_e];
			    var _edgeDx = _edgesDx[_e], _edgeDy = _edgesDy[_e];
			    if (((_edgeDx * (_y1 - _edgeY1) - _edgeDy * (_x1 - _edgeX1)) < 0) or
			        ((_edgeDx * (_y2 - _edgeY1) - _edgeDy * (_x2 - _edgeX1)) < 0) or
			        ((_edgeDx * (_y3 - _edgeY1) - _edgeDy * (_x3 - _edgeX1)) < 0) or
			        ((_edgeDx * (_y4 - _edgeY1) - _edgeDy * (_x4 - _edgeX1)) < 0)) {
			        _fullyInside = false;
			        break;
			    }
			}
			
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
