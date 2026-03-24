// feather ignore all

function FractureBoxGrid(_inst, _cols, _rows, _noiseX = 1, _noiseY = _noiseX) {
	static _maxNoise = 0.25;
	
	__FRACTURE_START;
	
	var _spacingX = _w / _cols;
	var _spacingY = _h / _rows;
	_noiseX = clamp(_noiseX, 0, 1) * _maxNoise * _spacingX;
	_noiseY = clamp(_noiseY, 0, 1) * _maxNoise * _spacingY;
	
	var _bodyCount = _rows * _cols;
	var _bodies = array_create(_bodyCount);
	
	var _index = 0;
	var _colX = array_create(_rows + 1);
	var _colY = array_create(_rows + 1);
	var _prevColX = array_create(_rows + 1);
	var _prevColY = array_create(_rows + 1);
	
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
			
			var _xl = min(_x1, _x4);
			var _yt = min(_y1, _y2);
			
			// vertices
			vertex_position(_vb, _x1 - _xl, _y1 - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _x1 / _w), lerp(_v0, _v1, _y1 / _h));
			vertex_position(_vb, _x2 - _xl, _y2 - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _x2 / _w), lerp(_v0, _v1, _y2 / _h));
			vertex_position(_vb, _x4 - _xl, _y4 - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _x4 / _w), lerp(_v0, _v1, _y4 / _h));
			vertex_position(_vb, _x3 - _xl, _y3 - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _x3 / _w), lerp(_v0, _v1, _y3 / _h));
						
			// body
			__FRACTURE_BODY
				__nVertices = 4;
				__vertexIndex = _index * __nVertices;
				
				__FRACTURE_FIXTURE_START; {
					physics_fixture_add_point(_fx, _x1 - _xl, _y1 - _yt);
					physics_fixture_add_point(_fx, _x2 - _xl, _y2 - _yt);
					physics_fixture_add_point(_fx, _x3 - _xl, _y3 - _yt);
					physics_fixture_add_point(_fx, _x4 - _xl, _y4 - _yt);
					__FRACTURE_FIXTURE_END;
				}
				
				//var _force = 0.2;
				//var _xImpulse = lengthdir_x(_force, _dir);
				//var _yImpulse = lengthdir_y(_force, _dir);
				//physics_apply_impulse(x, y, _xImpulse, _yImpulse);
				
				_bodies[_index++] = id;
			}
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
