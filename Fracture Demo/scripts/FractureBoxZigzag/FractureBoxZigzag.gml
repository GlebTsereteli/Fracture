
function FractureBoxZigzag(_inst, _bodyCount, _vertical, _noise = 0.5) {
	__FRACTURE_BOX_START;
	
	var _bodies = array_create(_bodyCount);
	var _edgeA = 0;
	var _edgeB = _vertical ? _w : _h;
	var _fixedB = _vertical ? _h : _w;
	var _step = _fixedB / (_bodyCount - 1);
	var _jitter = _noise * _step;
	
	var _ax = 0;
	var _ay = 0;
	var _bx = _vertical ? _w : 0;
	var _by = _vertical ? 0 : _h;
	
	for (var _i = 0; _i < _bodyCount; _i++) {
		var _pos = (_i >= _bodyCount - 2) ? _fixedB : (_step * (_i + 1)) + random_range(-_jitter, _jitter);
		var _even = (_i mod 2 == 0);
		var _side = _even ? _edgeA : _edgeB;
		
		var _cx = _vertical ? _side : _pos;
		var _cy = _vertical ? _pos  : _side;
		
		var _xl = min(_ax, _bx, _cx);
		var _yt = min(_ay, _by, _cy);
		
		var _dist = point_distance(_centerX, _centerY, _xl, _yt);
		var _dir = point_direction(_centerX, _centerY, _xl, _yt);
		var _bodyX = _inst.x + lengthdir_x(_dist, _dir - _angle);
		var _bodyY = _inst.y + lengthdir_y(_dist, _dir - _angle);
		
		with (instance_create_depth(_bodyX, _bodyY, _inst.depth, __objFractureBody)) {
			vertex_position(_vb, _ax - _xl, _ay - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _ax / _w, _ay / _h);
			vertex_position(_vb, _bx - _xl, _by - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _bx / _w, _by / _h);
			vertex_position(_vb, _cx - _xl, _cy - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _cx / _w, _cy / _h);
			
			__nVertices = 3;
			__vertexIndex = _i * __nVertices;
			__vertexBuffer = _vb;
			__texture = _texture;
			
			var _fx = physics_fixture_create();
			physics_fixture_set_collision_group(_fx, 1);
			physics_fixture_set_polygon_shape(_fx);
			physics_fixture_set_density(_fx, 0.5);
			physics_fixture_add_point(_fx, _ax - _xl, _ay - _yt);
			if (_vertical == _even) {
			    physics_fixture_add_point(_fx, _bx - _xl, _by - _yt);
			    physics_fixture_add_point(_fx, _cx - _xl, _cy - _yt);
			}
			else {
			    physics_fixture_add_point(_fx, _cx - _xl, _cy - _yt);
			    physics_fixture_add_point(_fx, _bx - _xl, _by - _yt);
			}
			__fixture = physics_fixture_bind(_fx, id);
			physics_fixture_delete(_fx);
			
			phy_linear_velocity_x = _inst.phy_linear_velocity_x;
			phy_linear_velocity_y = _inst.phy_linear_velocity_y;
			phy_angular_velocity = _inst.phy_angular_velocity;
			phy_rotation = _angle;
			
			_bodies[_i] = self;
		}
		
		_ax = _bx; _ay = _by;
		_bx = _cx; _by = _cy;
	}
	
	vertex_end(_vb);
	vertex_freeze(_vb);
	
	var _pack = instance_create_depth(0, 0, _inst.depth, __objFracturePack);
	_pack.__vertexBuffer = _vb;
	_pack.__bodies = _bodies;
	_pack.__n = _bodyCount;
	
	instance_destroy(_inst);
	
	return _pack;
}