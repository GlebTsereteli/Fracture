
/// @func FractureGrid()
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} divisionsX The amount of divisions on the X axis.
/// @param {Real} divisionsY The amount of divisions on the Y axis.
/// @returns {Id.Instance.objFracturePieceGroup}
function FractureGrid(_inst, _divX = 3, _divY = 3, _noise = 0.35) {
	if (not sprite_exists(_inst.sprite_index)) {
		show_error("no sprite", true);
	}
	
	__FRACTURE_FORMAT;
	
	var _w = _inst.sprite_width;
	var _h = _inst.sprite_height;
	var _xCenter = _w / 2;
	var _yCenter = _h / 2;
	var _angle = _inst.phy_rotation;
	
	var _spacingX = _w / _divX;
	var _spacingY = _h / _divY;
	
	var _noiseX = _spacingX * _noise;
	var _noiseY = _spacingY * _noise;
	
	var _texture = sprite_get_texture(_inst.sprite_index, _inst.image_index);
	
	var _vb = vertex_create_buffer();
	vertex_begin(_vb, _format);
	
	var _prevCol = undefined;
	var _index = 0;
	var _n = _divX * _divY;
	
	var _prevX = undefined;
	var _prevY = undefined;
	var _prevXX = undefined;
	var _prevYY = undefined;
	
	var _pieces = array_create(_n);
	for (var _i = 0; _i <= _divX; _i++) {
		var _col = array_create(_divY);
		var _xx = undefined;
		var _yy = undefined;
		
		for (var _j = 0; _j <= _divY; _j++) {
		    var _x3 = _i * _spacingX;
		    var _y3 = _j * _spacingY;
			
		    var _onEdge = ((_i == 0) or (_i == _divX) or (_j == 0) or (_j == _divY));
		    if (_onEdge) {
				if ((_i > 0) and (_i < _divX)) {
					_x3 += random_range(-_noiseX, _noiseX);
				}
				if ((_j > 0) and (_j < _divY)) {
					_y3 += random_range(-_noiseY, _noiseY);
				}
			}
			else {
		        _x3 += random_range(-_noiseX, _noiseX);
		        _y3 += random_range(-_noiseY, _noiseY);
		    }
			
		    _col[_j] = [_x3, _y3];
			
		    if ((_i > 0) and (_j > 0)) {
				var _tl = _prevCol[_j - 1];
		        var _tr = _col[_j - 1];
		        var _bl = _prevCol[_j];
				
				var _x1 = _tl[0], _y1 = _tl[1];
				var _x2 = _tr[0], _y2 = _tr[1];
				var _x4 = _bl[0], _y4 = _bl[1];
				
				var _xLeft = min(_x1, _x4);
				var _yTop = min(_y1, _y2);
				
				var _dist = point_distance(_xCenter, _yCenter, _xLeft, _yTop);
				var _dir = point_direction(_xCenter, _yCenter, _xLeft, _yTop);
				var _pieceX = _inst.x + lengthdir_x(_dist, _dir - _angle);
				var _pieceY = _inst.y + lengthdir_y(_dist, _dir - _angle);
				
				var _piece = instance_create_depth(_pieceX, _pieceY, _inst.depth, objFracturePiece);
				with (_piece) {
					vertex_position(_vb, _x1 - _xLeft, _y1 - _yTop); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x1 / _w, _y1 / _h);
					vertex_position(_vb, _x2 - _xLeft, _y2 - _yTop); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x2 / _w, _y2 / _h);
					vertex_position(_vb, _x3 - _xLeft, _y3 - _yTop); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x3 / _w, _y3 / _h);
					
					vertex_position(_vb, _x3 - _xLeft, _y3 - _yTop); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x3 / _w, _y3 / _h);
					vertex_position(_vb, _x4 - _xLeft, _y4 - _yTop); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x4 / _w, _y4 / _h);
					vertex_position(_vb, _x1 - _xLeft, _y1 - _yTop); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x1 / _w, _y1 / _h);
					
					__vertexIndex = _index * 6;
					__vertexBuffer = _vb;
					__texture = _texture;
					
					var _fx = physics_fixture_create();
					physics_fixture_set_collision_group(_fx, 1);
					physics_fixture_set_polygon_shape(_fx);
					physics_fixture_set_density(_fx, 0.5);
					physics_fixture_add_point(_fx, _x1 - _xLeft, _y1 - _yTop);
					physics_fixture_add_point(_fx, _x2 - _xLeft, _y2 - _yTop);
					physics_fixture_add_point(_fx, _x3 - _xLeft, _y3 - _yTop);
					physics_fixture_add_point(_fx, _x4 - _xLeft, _y4 - _yTop);
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
				}
				_pieces[_index++] = _piece;
		    }
		}
		_prevXX = _prevX;
		_prevYY = _prevY;
		
		_prevX = _x3;
		_prevY = _x3;
		
		_prevCol = _col;
	}
	
	vertex_end(_vb);
	vertex_freeze(_vb);
	
	var _group = instance_create_depth(0, 0, _inst.depth, objFracturePieceGroup);
	_group.__vertexBuffer = _vb;
	_group.__pieces = _pieces;
	_group.__n = _n;
	
	instance_destroy(_inst);
	
	return _group;
}
