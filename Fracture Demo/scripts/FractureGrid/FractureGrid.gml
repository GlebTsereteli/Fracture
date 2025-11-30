
function FractureGrid(_inst, _divX = 3, _divY = 3, _noise = 0.3) {
	if (not sprite_exists(_inst.sprite_index)) {
		show_error("no sprite", true);
	}
	
	var _w = _inst.sprite_width;
	var _h = _inst.sprite_height;
	
	var _spacingX = _w / _divX;
	var _spacingY = _h / _divX;
	
	var _noiseX = _spacingX * _noise;
	var _noiseY = _spacingY * _noise;
	
	__FRACTURE_FORMAT;
	
	var _pieces = array_create(_divX * _divY);
	
	var _prevCol = undefined;
	var _notFirst = false;
	var _index = 0;
	
	var _prevX = undefined;
	var _prevY = undefined;
	
	for (var _i = 0; _i <= _divX; _i++) {
		var _col = array_create(_divY);
		
		for (var _j = 0; _j <= _divY; _j++) {
		    var _x = _i * _spacingX;
		    var _y = _j * _spacingY;
			
		    var _onEdge = ((_i == 0) or (_i == _divX) or (_j == 0) or (_j == _divY));
		    if (_onEdge) {
				if ((_i > 0) and (_i < _divX)) {
					_x += random_range(-_noiseX, _noiseX);
				}
				if ((_j > 0) and (_j < _divY)) {
					_y += random_range(-_noiseY, _noiseY);
				}
			}
			else {
		        _x += random_range(-_noiseX, _noiseX);
		        _y += random_range(-_noiseY, _noiseY);
		    }
			
		    _col[_j] = [_x, _y];
			
		    if ((_i > 0) and (_j > 0)) {
				var _tl = _prevCol[_j - 1];
		        var _tr = _col[_j - 1];
		        var _bl = _prevCol[_j];
				
				var _x1 = _tl[0], _y1 = _tl[1];
				var _x2 = _tr[0], _y2 = _tr[1];
				var _x3 = _x, _y3 = _y;
				var _x4 = _bl[0], _y4 = _bl[1];
				
				var _xLeft = min(_x1, _x2, _x3, _x4);
				var _yTop = min(_y1, _y2, _y3, _y4);
				
				var _piece = instance_create_depth(_inst.bbox_left + _xLeft, _inst.bbox_top + _yTop, _inst.depth, objFracturePiece);
				with (_piece) {
					vb = vertex_create_buffer(); {
						vertex_begin(vb, _format);
						
						vertex_position(vb, _x1 - _xLeft, _y1 - _yTop); vertex_colour(vb, c_white, 1); vertex_texcoord(vb, _x1 / _w, _y1 / _h);
						vertex_position(vb, _x2 - _xLeft, _y2 - _yTop); vertex_colour(vb, c_white, 1); vertex_texcoord(vb, _x2 / _w, _y2 / _h);
						vertex_position(vb, _x3 - _xLeft, _y3 - _yTop); vertex_colour(vb, c_white, 1); vertex_texcoord(vb, _x3 / _w, _y3 / _h);
						
						vertex_position(vb, _x3 - _xLeft, _y3 - _yTop); vertex_colour(vb, c_white, 1); vertex_texcoord(vb, _x3 / _w, _y3 / _h);
						vertex_position(vb, _x4 - _xLeft, _y4 - _yTop); vertex_colour(vb, c_white, 1); vertex_texcoord(vb, _x4 / _w, _y4 / _h);
						vertex_position(vb, _x1 - _xLeft, _y1 - _yTop); vertex_colour(vb, c_white, 1); vertex_texcoord(vb, _x1 / _w, _y1 / _h);
						
						vertex_end(vb);
						vertex_freeze(vb);
					}
					
					sprite = _inst.sprite_index;
					frame = _inst.image_index;
					
					var _fx = physics_fixture_create();
					physics_fixture_set_collision_group(_fx, 1);
					physics_fixture_set_polygon_shape(_fx);
					physics_fixture_set_density(_fx, 0.5);
					physics_fixture_add_point(_fx, _x1 - _xLeft, _y1 - _yTop);
					physics_fixture_add_point(_fx, _x2 - _xLeft, _y2 - _yTop);
					physics_fixture_add_point(_fx, _x3 - _xLeft, _y3 - _yTop);
					physics_fixture_add_point(_fx, _x4 - _xLeft, _y4 - _yTop);
					fixture = physics_fixture_bind(_fx, id);
					phy_speed_x = _inst.phy_speed_x;
					phy_speed_y = _inst.phy_speed_y;
				}
				_pieces[_index++] = _piece;
		    }
		}
		_prevCol = _col;
		_prevX = _x;
		_prevY = _y;
	}
	
	instance_destroy(_inst);
	
	return _pieces;
}
