// feather ignore all

function FractureBoxZigzag(_inst, _pieceCount, _horizontal, _noise = 0.5) {
	__FRACTURE_START;
	
	var _pieces = array_create(_pieceCount);
	var _edgeA = 0;
	var _edgeB = _horizontal ? _w : _h;
	var _fixedB = _horizontal ? _h : _w;
	var _step = _fixedB / (_pieceCount - 1);
	var _jitter = _noise * _step;
	
	var _ax = 0;
	var _ay = 0;
	var _bx = _horizontal ? _w : 0;
	var _by = _horizontal ? 0 : _h;
	
	for (var _i = 0; _i < _pieceCount; _i++) {
		var _pos = (_i >= _pieceCount - 2) ? _fixedB : (_step * (_i + 1)) + random_range(-_jitter, _jitter);
		var _even = (_i mod 2 == 0);
		var _side = _even ? _edgeA : _edgeB;
		
		var _cx = _horizontal ? _side : _pos;
		var _cy = _horizontal ? _pos : _side;
		
		var _ox = mean(_ax, _bx, _cx);
		var _oy = mean(_ay, _by, _cy);
		
		vertex_position(_vb, _ax - _ox, _ay - _oy); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
		vertex_position(_vb, _bx - _ox, _by - _oy); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
		vertex_position(_vb, _cx - _ox, _cy - _oy); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _cx / _w), lerp(_v0, _v1, _cy / _h));
		
		__FRACTURE_PIECE
			__nVertices = 3;
			__vertexIndex = _i * __nVertices;
			
			__FRACTURE_FIXTURE_START; {
				physics_fixture_add_point(_fx, _ax - _ox, _ay - _oy);
				if (_horizontal == _even) {
					physics_fixture_add_point(_fx, _bx - _ox, _by - _oy);
					physics_fixture_add_point(_fx, _cx - _ox, _cy - _oy);
				}
				else {
					physics_fixture_add_point(_fx, _cx - _ox, _cy - _oy);
					physics_fixture_add_point(_fx, _bx - _ox, _by - _oy);
				}
				__FRACTURE_FIXTURE_END;
			}
			
			_pieces[_i] = id;
		}
		
		_ax = _bx; _ay = _by;
		_bx = _cx; _by = _cy;
	}
	
	__FRACTURE_END;
}
