
function FractureBoxGrid(_inst, _cols, _rows, _noiseX = 0.3, _noiseY = _noiseX) {
	__FRACTURE_BOX_START;
	
	var _spacingX = _w / _cols;
	var _spacingY = _h / _rows;
	_noiseX *= _spacingX;
	_noiseY *= _spacingY;
	
	var _n = _rows * _cols;
	var _pieces = array_create(_n);
	
	var _index = 0;
	var _prevColX = undefined;
	var _prevColY = undefined;
	
	for (var _i = 0; _i <= _cols; _i++) {
		var _colX = array_create(_rows);
		var _colY = array_create(_rows);
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
			
			var _dist = point_distance(_centerX, _centerY, _xl, _yt);
			var _dir = point_direction(_centerX, _centerY, _xl, _yt);
			var _pieceX = _inst.x + lengthdir_x(_dist, _dir - _angle);
			var _pieceY = _inst.y + lengthdir_y(_dist, _dir - _angle);
			
			with (instance_create_depth(_pieceX, _pieceY, _inst.depth, __objFracturePiece)) {
				vertex_position(_vb, _x1 - _xl, _y1 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x1 / _w, _y1 / _h);
				vertex_position(_vb, _x2 - _xl, _y2 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x2 / _w, _y2 / _h);
				vertex_position(_vb, _x3 - _xl, _y3 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x3 / _w, _y3 / _h);
				
				vertex_position(_vb, _x3 - _xl, _y3 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x3 / _w, _y3 / _h);
				vertex_position(_vb, _x4 - _xl, _y4 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x4 / _w, _y4 / _h);
				vertex_position(_vb, _x1 - _xl, _y1 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x1 / _w, _y1 / _h);
				
				__nVertices = 6;
				__vertexIndex = _index * __nVertices;
				__vertexBuffer = _vb;
				__texture = _texture;
				
				var _fx = physics_fixture_create();
				physics_fixture_set_collision_group(_fx, 1);
				physics_fixture_set_polygon_shape(_fx);
				physics_fixture_set_density(_fx, 0.5);
				physics_fixture_add_point(_fx, _x1 - _xl, _y1 - _yt);
				physics_fixture_add_point(_fx, _x2 - _xl, _y2 - _yt);
				physics_fixture_add_point(_fx, _x3 - _xl, _y3 - _yt);
				physics_fixture_add_point(_fx, _x4 - _xl, _y4 - _yt);
				__fixture = physics_fixture_bind(_fx, id);
				physics_fixture_delete(_fx);
				
				phy_linear_velocity_x = _inst.phy_linear_velocity_x;
			    phy_linear_velocity_y = _inst.phy_linear_velocity_y;
			    phy_angular_velocity = _inst.phy_angular_velocity;
				phy_rotation = _angle;
				
				//var _force = 0.2;
				//var _xImpulse = lengthdir_x(_force, _dir);
				//var _yImpulse = lengthdir_y(_force, _dir);
				//physics_apply_impulse(x, y, _xImpulse, _yImpulse);
				
				_pieces[_index++] = self;
			}
		}
		_prevColX = _colX;
		_prevColY = _colY;
	}
	
	vertex_end(_vb);
	vertex_freeze(_vb);
	
	var _group = instance_create_depth(0, 0, _inst.depth, __objFracturePack);
	_group.__vertexBuffer = _vb;
	_group.__pieces = _pieces;
	_group.__n = _n;
	
	instance_destroy(_inst);
	
	return _group;
}
