// feather ignore all

function FractureBoxBrick(_inst, _cols, _rows, _horizontal) {
	__FRACTURE_START;
	
	var _brickW = _w / _cols;
	var _brickH = _h / _rows;
	
	var _bodyCount = _horizontal ? (_cols * _rows + (_rows div 2)) : (_cols * _rows + (_cols div 2));
	var _bodies = array_create(_bodyCount);
	var _index = 0;
	
	if (_horizontal) {
		for (var _row = 0; _row < _rows; _row++) {
			var _even = (_row mod 2 == 0);
			var _offsetX = _even ? 0 : _brickW * 0.5;
			var _ry1 = _row * _brickH;
			var _ry2 = _ry1 + _brickH;
			var _colStart = _even ? 0 : -1;
			
			for (var _col = _colStart; _col < _cols; _col++) {
				var _bx1 = (_col * _brickW) + _offsetX;
				var _bx2 = _bx1 + _brickW;
				_bx1 = max(_bx1, 0);
				_bx2 = min(_bx2, _w);
				if (_bx2 <= _bx1) continue;
				
				var _halfW = (_bx2 - _bx1) * 0.5;
				var _halfH = (_ry2 - _ry1) * 0.5;
				var _cx = _bx1 + _halfW;
				var _cy = _ry1 + _halfH;
				
				var _dist = point_distance(_centerX, _centerY, _cx, _cy);
				var _dir = point_direction(_centerX, _centerY, _cx, _cy);
				var _bodyX = _inst.x + lengthdir_x(_dist, _dir - _angle);
				var _bodyY = _inst.y + lengthdir_y(_dist, _dir - _angle);
				
				with (instance_create_depth(_bodyX, _bodyY, _inst.depth, __objFractureBody)) {
					vertex_position(_vb, -_halfW, -_halfH); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _bx1 / _w, _ry1 / _h);
					vertex_position(_vb, _halfW, -_halfH); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _bx2 / _w, _ry1 / _h);
					vertex_position(_vb, -_halfW, _halfH); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _bx1 / _w, _ry2 / _h);
					vertex_position(_vb, _halfW, _halfH); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _bx2 / _w, _ry2 / _h);
					
					__nVertices = 4;
					__vertexIndex = _index * __nVertices;
					__vertexBuffer = _vb;
					__texture = _texture;
					
					__FRACTURE_FIXTURE_START; {
						physics_fixture_set_box_shape(_fx, _halfW, _halfH);
						__FRACTURE_FIXTURE_END;
					}
					
					_bodies[_index++] = id;
				}
			}
		}
	}
	else {
		for (var _col = 0; _col < _cols; _col++) {
			var _even = (_col mod 2 == 0);
			var _offsetY = _even ? 0 : _brickH * 0.5;
			var _rx1 = _col * _brickW;
			var _rx2 = _rx1 + _brickW;
			var _rowStart = _even ? 0 : -1;
			
			for (var _row = _rowStart; _row < _rows; _row++) {
				var _by1 = (_row * _brickH) + _offsetY;
				var _by2 = _by1 + _brickH;
				_by1 = max(_by1, 0);
				_by2 = min(_by2, _h);
				if (_by2 <= _by1) continue;
				
				var _halfW = (_rx2 - _rx1) * 0.5;
				var _halfH = (_by2 - _by1) * 0.5;
				var _cx = _rx1 + _halfW;
				var _cy = _by1 + _halfH;
				
				var _dist = point_distance(_centerX, _centerY, _cx, _cy);
				var _dir = point_direction(_centerX, _centerY, _cx, _cy);
				var _bodyX = _inst.x + lengthdir_x(_dist, _dir - _angle);
				var _bodyY = _inst.y + lengthdir_y(_dist, _dir - _angle);
				
				with (instance_create_depth(_bodyX, _bodyY, _inst.depth, __objFractureBody)) {
					vertex_position(_vb, -_halfW, -_halfH); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _rx1 / _w, _by1 / _h); // TL
					vertex_position(_vb, _halfW, -_halfH); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _rx2 / _w, _by1 / _h); // TR
					vertex_position(_vb, -_halfW, _halfH); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _rx1 / _w, _by2 / _h); // BL
					vertex_position(_vb, _halfW, _halfH); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _rx2 / _w, _by2 / _h); // BR
					
					__nVertices = 4;
					__vertexIndex = _index * __nVertices;
					__vertexBuffer = _vb;
					__texture = _texture;
					
					__FRACTURE_FIXTURE_START; {
						physics_fixture_set_box_shape(_fx, _halfW, _halfH);
						__FRACTURE_FIXTURE_END;
					}
					
					_bodies[_index++] = id;
				}
			}
		}
	}
	
	__FRACTURE_END;
}
