// feather ignore all

function FractureBoxBrick(_inst, _cols, _rows, _horizontal) {
	__FRACTURE_START;
	
	// full bricks + half-bricks on staggered edges
	var _bodyCount = _horizontal ? (_cols * _rows + (_rows div 2)) : (_cols * _rows + (_cols div 2));
	var _bodies = array_create(_bodyCount);
	var _index = 0;
	
	var _stripCount = _horizontal ? _rows : _cols;
	var _brickCount = _horizontal ? _cols : _rows;
	var _brickW = _w / _cols;
	var _brickH = _h / _rows;
	var _stripSize = _horizontal ? _brickH : _brickW;
	var _brickSize = _horizontal ? _brickW : _brickH;
	var _axisLen = _horizontal ? _w : _h;
	
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
			
			if (_brickB <= _brickA) continue;
			
			var _x1 = _horizontal ? _brickA : _stripA;
			var _x2 = _horizontal ? _brickB : _stripB;
			var _y1 = _horizontal ? _stripA : _brickA;
			var _y2 = _horizontal ? _stripB : _brickB;
			
			var _halfW = (_x2 - _x1) / 2;
			var _halfH = (_y2 - _y1) / 2;
			var _xl = _x1 + _halfW;
			var _yt = _y1 + _halfH;
			
			// vertices
			vertex_position(_vb, -_halfW, -_halfH); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _x1 / _w), lerp(_v0, _v1, _y1 / _h));
			vertex_position(_vb, _halfW, -_halfH); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _x2 / _w), lerp(_v0, _v1, _y1 / _h));
			vertex_position(_vb, -_halfW, _halfH); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _x1 / _w), lerp(_v0, _v1, _y2 / _h));
			vertex_position(_vb, _halfW, _halfH); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _x2 / _w), lerp(_v0, _v1, _y2 / _h));
			
			// body
			__FRACTURE_BODY
				__nVertices = 4;
				__vertexIndex = _index * __nVertices;
				
				__FRACTURE_FIXTURE_START; {
					physics_fixture_set_box_shape(_fx, _halfW, _halfH);
					__FRACTURE_FIXTURE_END;
				}
				
				_bodies[_index++] = id;
			}
		}
	}
	
	__FRACTURE_END;
}
