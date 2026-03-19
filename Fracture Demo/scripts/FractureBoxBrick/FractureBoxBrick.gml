
function FractureBoxBrick(_inst, _cols, _rows, _horizontal = true) {
	__FRACTURE_FORMAT;
	
	var _w = _inst.sprite_width;
	var _h = _inst.sprite_height;
	var _xCenter = _w / 2;
	var _yCenter = _h / 2;
	var _angle = _inst.phy_rotation;
	
	var _texture = sprite_get_texture(_inst.sprite_index, _inst.image_index);
	var _pieces = [];
	var _vb = vertex_create_buffer();
	vertex_begin(_vb, _format);
	
	var _brickW = _w / _cols;
	var _brickH = _h / _rows;
	var _index = 0;
	
	if (_horizontal) {
		for (var _row = 0; _row < _rows; _row++) {
			var _offsetX = (_row mod 2 == 0) ? 0 : _brickW * 0.5;
			var _ry1 = _row * _brickH;
			var _ry2 = _ry1 + _brickH;
			var _colStart = (_row mod 2 == 0) ? 0 : -1;
			
			for (var _col = _colStart; _col < _cols; _col++) {
				var _bx1 = (_col * _brickW) + _offsetX;
				var _bx2 = _bx1 + _brickW;
				
				_bx1 = max(_bx1, 0);
				_bx2 = min(_bx2, _w);
				if (_bx2 <= _bx1) continue;
				
				var _xl = _bx1;
				var _yt = _ry1;
				
				var _dist = point_distance(_xCenter, _yCenter, _xl, _yt);
				var _dir = point_direction(_xCenter, _yCenter, _xl, _yt);
				var _pieceX = _inst.x + lengthdir_x(_dist, _dir - _angle);
				var _pieceY = _inst.y + lengthdir_y(_dist, _dir - _angle);
				
				with (instance_create_depth(_pieceX, _pieceY, _inst.depth, __objFracturePiece)) {
					vertex_position(_vb, _bx1 - _xl, _ry1 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _bx1 / _w, _ry1 / _h);
					vertex_position(_vb, _bx2 - _xl, _ry1 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _bx2 / _w, _ry1 / _h);
					vertex_position(_vb, _bx2 - _xl, _ry2 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _bx2 / _w, _ry2 / _h);
					
					vertex_position(_vb, _bx2 - _xl, _ry2 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _bx2 / _w, _ry2 / _h);
					vertex_position(_vb, _bx1 - _xl, _ry2 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _bx1 / _w, _ry2 / _h);
					vertex_position(_vb, _bx1 - _xl, _ry1 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _bx1 / _w, _ry1 / _h);
					
					__nVertices = 6;
					__vertexIndex = _index * __nVertices;
					__vertexBuffer = _vb;
					__texture = _texture;
					
					var _fx = physics_fixture_create();
					physics_fixture_set_collision_group(_fx, 1);
					physics_fixture_set_polygon_shape(_fx);
					physics_fixture_set_density(_fx, 0.5);
					physics_fixture_add_point(_fx, _bx1 - _xl, _ry1 - _yt);
					physics_fixture_add_point(_fx, _bx2 - _xl, _ry1 - _yt);
					physics_fixture_add_point(_fx, _bx2 - _xl, _ry2 - _yt);
					physics_fixture_add_point(_fx, _bx1 - _xl, _ry2 - _yt);
					__fixture = physics_fixture_bind(_fx, id);
					physics_fixture_delete(_fx);
					
					phy_linear_velocity_x = _inst.phy_linear_velocity_x;
					phy_linear_velocity_y = _inst.phy_linear_velocity_y;
					phy_angular_velocity = _inst.phy_angular_velocity;
					phy_rotation = _angle;
					
					array_push(_pieces, self);
					_index++;
				}
			}
		}
	} else {
		for (var _col = 0; _col < _cols; _col++) {
			var _offsetY = (_col mod 2 == 0) ? 0 : _brickH * 0.5;
			var _rx1 = _col * _brickW;
			var _rx2 = _rx1 + _brickW;
			var _rowStart = (_col mod 2 == 0) ? 0 : -1;
			
			for (var _row = _rowStart; _row < _rows; _row++) {
				var _by1 = (_row * _brickH) + _offsetY;
				var _by2 = _by1 + _brickH;
				
				_by1 = max(_by1, 0);
				_by2 = min(_by2, _h);
				if (_by2 <= _by1) continue;
				
				var _xl = _rx1;
				var _yt = _by1;
				
				var _dist = point_distance(_xCenter, _yCenter, _xl, _yt);
				var _dir = point_direction(_xCenter, _yCenter, _xl, _yt);
				var _pieceX = _inst.x + lengthdir_x(_dist, _dir - _angle);
				var _pieceY = _inst.y + lengthdir_y(_dist, _dir - _angle);
				
				with (instance_create_depth(_pieceX, _pieceY, _inst.depth, __objFracturePiece)) {
					vertex_position(_vb, _rx1 - _xl, _by1 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _rx1 / _w, _by1 / _h);
					vertex_position(_vb, _rx2 - _xl, _by1 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _rx2 / _w, _by1 / _h);
					vertex_position(_vb, _rx2 - _xl, _by2 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _rx2 / _w, _by2 / _h);
					
					vertex_position(_vb, _rx2 - _xl, _by2 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _rx2 / _w, _by2 / _h);
					vertex_position(_vb, _rx1 - _xl, _by2 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _rx1 / _w, _by2 / _h);
					vertex_position(_vb, _rx1 - _xl, _by1 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _rx1 / _w, _by1 / _h);
					
					__nVertices = 6;
					__vertexIndex = _index * __nVertices;
					__vertexBuffer = _vb;
					__texture = _texture;
					
					var _fx = physics_fixture_create();
					physics_fixture_set_collision_group(_fx, 1);
					physics_fixture_set_polygon_shape(_fx);
					physics_fixture_set_density(_fx, 0.5);
					physics_fixture_add_point(_fx, _rx1 - _xl, _by1 - _yt);
					physics_fixture_add_point(_fx, _rx2 - _xl, _by1 - _yt);
					physics_fixture_add_point(_fx, _rx2 - _xl, _by2 - _yt);
					physics_fixture_add_point(_fx, _rx1 - _xl, _by2 - _yt);
					__fixture = physics_fixture_bind(_fx, id);
					physics_fixture_delete(_fx);
					
					phy_linear_velocity_x = _inst.phy_linear_velocity_x;
					phy_linear_velocity_y = _inst.phy_linear_velocity_y;
					phy_angular_velocity = _inst.phy_angular_velocity;
					phy_rotation = _angle;
					
					array_push(_pieces, self);
					_index++;
				}
			}
		}
	}
	
	vertex_end(_vb);
	vertex_freeze(_vb);
	
	var _group = instance_create_depth(0, 0, _inst.depth, __objFracturePack);
	_group.__vertexBuffer = _vb;
	_group.__pieces = _pieces;
	_group.__n = array_length(_pieces);
	
	instance_destroy(_inst);
	
	return _group;
}