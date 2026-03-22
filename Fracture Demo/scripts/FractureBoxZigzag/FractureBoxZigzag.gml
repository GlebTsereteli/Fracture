// feather ignore all

function FractureBoxZigzag(_inst, _bodyCount, _horizontal, _noise = 0.5) {
	__FRACTURE_START;
	
	var _bodies = array_create(_bodyCount);
	var _edgeA = 0;
	var _edgeB = _horizontal ? _w : _h;
	var _fixedB = _horizontal ? _h : _w;
	var _step = _fixedB / (_bodyCount - 1);
	var _jitter = _noise * _step;
	
	var _ax = 0;
	var _ay = 0;
	var _bx = _horizontal ? _w : 0;
	var _by = _horizontal ? 0 : _h;
	
	for (var _i = 0; _i < _bodyCount; _i++) {
		var _pos = (_i >= _bodyCount - 2) ? _fixedB : (_step * (_i + 1)) + random_range(-_jitter, _jitter);
		var _even = (_i mod 2 == 0);
		var _side = _even ? _edgeA : _edgeB;
		
		var _cx = _horizontal ? _side : _pos;
		var _cy = _horizontal ? _pos : _side;
		
		var _xl = min(_ax, _bx, _cx);
		var _yt = min(_ay, _by, _cy);
		
		var _dist = point_distance(_centerX, _centerY, _xl, _yt);
		var _dir = point_direction(_centerX, _centerY, _xl, _yt);
		var _bodyX = _inst.x + lengthdir_x(_dist, _dir - _angle);
		var _bodyY = _inst.y + lengthdir_y(_dist, _dir - _angle);
		
		with (instance_create_depth(_bodyX, _bodyY, _inst.depth, __objFractureBody)) {
			vertex_position(_vb, _ax - _xl, _ay - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _ax / _w, _ay / _h);
			vertex_position(_vb, _bx - _xl, _by - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _bx / _w, _by / _h);
			vertex_position(_vb, _cx - _xl, _cy - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _cx / _w, _cy / _h);
			
			__nVertices = 3;
			__vertexIndex = _i * __nVertices;
			__vertexBuffer = _vb;
			__texture = _texture;
			
			__FRACTURE_FIXTURE_START; {
				physics_fixture_add_point(_fx, _ax - _xl, _ay - _yt);
				if (_horizontal == _even) {
					physics_fixture_add_point(_fx, _bx - _xl, _by - _yt);
					physics_fixture_add_point(_fx, _cx - _xl, _cy - _yt);
				}
				else {
					physics_fixture_add_point(_fx, _cx - _xl, _cy - _yt);
					physics_fixture_add_point(_fx, _bx - _xl, _by - _yt);
				}
				__FRACTURE_FIXTURE_END;
			}
			
			_bodies[_i] = id;
		}
		
		_ax = _bx; _ay = _by;
		_bx = _cx; _by = _cy;
	}
	
	__FRACTURE_END;
}
