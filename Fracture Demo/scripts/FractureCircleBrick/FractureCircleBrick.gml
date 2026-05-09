// feather ignore all

function FractureCircleBrick(_inst, _cols, _rows, _horizontal) {
	__FRACTURE_START;
	__FRACTURE_BRICK_SETUP;
	
	var _radius = min(_w, _h) / 2;
	var _radiusSq = _radius * _radius;
	var _hull = array_create(__FRACTURE_CIRCLE_PRECISION * 2);
	for (var _i = 0; _i < __FRACTURE_CIRCLE_PRECISION; _i++) {
		var _a = (_i / __FRACTURE_CIRCLE_PRECISION) * 360;
		_hull[_i * 2] = _centerX + lengthdir_x(_radius, _a);
		_hull[_i * 2 + 1] = _centerY + lengthdir_y(_radius, _a);
	}
	
	var _px = 0, _py = 0;
	
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
				var _cell = [_x1, _y1, _x2, _y1, _x2, _y2, _x1, _y2];
				var _clipped = __FracturePolygonClip(_cell, _hull);
				var _vertCount = array_length(_clipped) / 2;
				
				if (_vertCount < 3) continue;
				
				// Mean centroid
				var _sumX = 0, _sumY = 0;
				for (var _v = 0; _v < _vertCount; _v++) {
					_sumX += _clipped[_v * 2];
					_sumY += _clipped[_v * 2 + 1];
				}
				var _ox = _sumX / _vertCount;
				var _oy = _sumY / _vertCount;
				
				for (var _v = 0; _v < _vertCount; _v++) {
					_clipped[_v * 2] -= _ox;
					_clipped[_v * 2 + 1] -= _oy;
				}
				
				// Vertices
				var _triCount = _vertCount - 2;
				for (var _t = 0; _t < _triCount; _t++) {
					_px = _clipped[0]; _py = _clipped[1]; __FRACTURE_V;
					_px = _clipped[(_t + 1) * 2]; _py = _clipped[(_t + 1) * 2 + 1]; __FRACTURE_V;
					_px = _clipped[(_t + 2) * 2]; _py = _clipped[(_t + 2) * 2 + 1]; __FRACTURE_V;
				}
				
				// Piece
				var _fixtureCount = min(_vertCount, 8);
				var _vertStep = _triCount * 3;
				
				__FRACTURE_PIECE
					__primitiveType = pr_trianglelist;
					__vertexCount = _vertStep;
					__vertexIndex = _vertexOffset;
					
					__FRACTURE_FIXTURE_START; {
						for (var _f = 0; _f < _fixtureCount; _f++) {
							physics_fixture_add_point(_fx, _clipped[_f * 2], _clipped[_f * 2 + 1]);
						}
						__FRACTURE_FIXTURE_END;
					}
					
					_pieces[_index++] = id;
				}
				
				_vertexOffset += _vertStep;
			}
		}
	}
	
	_pieceCount = _index;
	array_resize(_pieces, _pieceCount);
	__FRACTURE_END;
}
