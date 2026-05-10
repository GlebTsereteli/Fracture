// feather ignore all

function FractureConvexGrid(_inst, _cols, _rows, _noiseX = 1, _noiseY = _noiseX) {
	static _cell = array_create(8);
	
	__FRACTURE_START;
	__FRACTURE_GRID_SETUP;
	
	var _hull = __FractureGetConvexHull(_inst);
	var _nHull = array_length(_hull) / 2;
	
	// Precompute hull edges and bbox
	var _edgesX1 = array_create(_nHull);
	var _edgesY1 = array_create(_nHull);
	var _edgesDx = array_create(_nHull);
	var _edgesDy = array_create(_nHull);
	var _hullX1 = infinity, _hullX2 = -infinity;
	var _hullY1 = infinity, _hullY2 = -infinity;
	
	for (var _i = 0; _i < _nHull; _i++) {
		var _ni = (_i + 1) mod _nHull;
		var _hx = _hull[_i * 2];
		var _hy = _hull[_i * 2 + 1];
		
		_edgesX1[_i] = _hx;
		_edgesY1[_i] = _hy;
		_edgesDx[_i] = _hull[_ni * 2] - _hx;
		_edgesDy[_i] = _hull[_ni * 2 + 1] - _hy;
		
		if (_hx < _hullX1) _hullX1 = _hx;
		if (_hx > _hullX2) _hullX2 = _hx;
		if (_hy < _hullY1) _hullY1 = _hy;
		if (_hy > _hullY2) _hullY2 = _hy;
	}
	
	var _px = 0, _py = 0;
	
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
			if (max(_x1, _x2, _x3, _x4) < _hullX1 or min(_x1, _x2, _x3, _x4) > _hullX2 or
				max(_y1, _y2, _y3, _y4) < _hullY1 or min(_y1, _y2, _y3, _y4) > _hullY2) continue;
			
			// For each edge, check all 4 corners at once. Break if any corner is outside the hull
			var _fullyInside = true;
			for (var _e = 0; _e < _nHull; _e++) {
			    var _edgeX1 = _edgesX1[_e], _edgeY1 = _edgesY1[_e];
			    var _edgeDx = _edgesDx[_e], _edgeDy = _edgesDy[_e];
			    if ((_edgeDx * (_y1 - _edgeY1) - _edgeDy * (_x1 - _edgeX1)) < 0 or
			        (_edgeDx * (_y2 - _edgeY1) - _edgeDy * (_x2 - _edgeX1)) < 0 or
			        (_edgeDx * (_y3 - _edgeY1) - _edgeDy * (_x3 - _edgeX1)) < 0 or
			        (_edgeDx * (_y4 - _edgeY1) - _edgeDy * (_x4 - _edgeX1)) < 0) {
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
