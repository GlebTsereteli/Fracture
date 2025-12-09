
FractureGrid()

/**
* @param {Id.Instance} inst The instance to fracture. Must have a sprite and be physics-enabled.
* @param {Real} rows Number of rows in the fracture grid (minimum 1).
* @param {Real} columns Number of columns in the fracture grid (minimum 1).
* @param {Real} noise Randomization factor for internal grid points (0 = perfect grid, higher = more jagged). Applied as a percentage of cell size on non-edge points.
*
* @returns {Id.Instance} 
*
* @desc Fractures a physics-enabled instance into a grid of irregular polygonal pieces.
* Each piece becomes an instance of objFracturePiece with its own physics fixture, sharing a single frozen vertex buffer for efficient rendering.
* 
* The original instance is destroyed, and an instance of objFracturePieceGroup that owns all pieces and the shared vertex buffer is returned. Use this to manage or clean up the fracture.
*/
function FractureGrid(_inst, _rows = 1, _cols = 3, _noise = 0.35) {
	__FRACTURE_FORMAT;
	
	var _w = _inst.sprite_width;
	var _h = _inst.sprite_height;
	var _xCenter = _w / 2;
	var _yCenter = _h / 2;
	var _angle = _inst.phy_rotation;
	
	var _spacingX = _w / _cols;
	var _spacingY = _h / _rows;
	
	var _noiseX = _spacingX * _noise;
	var _noiseY = _spacingY * _noise;
	
	var _texture = sprite_get_texture(_inst.sprite_index, _inst.image_index);
	
	var _prevColX = undefined;
	var _prevColY = undefined;
	var _index = 0;
	var _n = _rows * _cols;
	
	var _pieces = array_create(_n);
	var _vb = vertex_create_buffer();
	vertex_begin(_vb, _format);
	
	for (var _i = 0; _i <= _cols; _i++) {
		var _colX = array_create(_rows);
		var _colY = array_create(_rows);
		var _iFirst = (_i == 0);
		var _iOnEdge = (_iFirst or (_i == _cols));
		
		for (var _j = 0; _j <= _rows; _j++) {
		    var _jOnEdge = ((_j == 0) or (_j == _rows));
			
			var _x3 = _i * _spacingX;
		    var _y3 = _j * _spacingY;
			
		    if (_iOnEdge or _jOnEdge) {
				if (not _iOnEdge) {
					_x3 += random_range(-_noiseX, _noiseX);
				}
				if (not _jOnEdge) {
					_y3 += random_range(-_noiseY, _noiseY);
				}
			}
			else {
		        _x3 += random_range(-_noiseX, _noiseX);
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
			
			var _dist = point_distance(_xCenter, _yCenter, _xl, _yt);
			var _dir = point_direction(_xCenter, _yCenter, _xl, _yt);
			var _pieceX = _inst.x + lengthdir_x(_dist, _dir - _angle);
			var _pieceY = _inst.y + lengthdir_y(_dist, _dir - _angle);
			
			with (instance_create_depth(_pieceX, _pieceY, _inst.depth, objFracturePiece)) {
				vertex_position(_vb, _x1 - _xl, _y1 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x1 / _w, _y1 / _h);
				vertex_position(_vb, _x2 - _xl, _y2 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x2 / _w, _y2 / _h);
				vertex_position(_vb, _x3 - _xl, _y3 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x3 / _w, _y3 / _h);
				
				vertex_position(_vb, _x3 - _xl, _y3 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x3 / _w, _y3 / _h);
				vertex_position(_vb, _x4 - _xl, _y4 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x4 / _w, _y4 / _h);
				vertex_position(_vb, _x1 - _xl, _y1 - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _x1 / _w, _y1 / _h);
				
				__vertexIndex = _index * 6;
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
	
	var _group = instance_create_depth(0, 0, _inst.depth, objFracturePieceGroup);
	_group.__vertexBuffer = _vb;
	_group.__pieces = _pieces;
	_group.__n = _n;
	
	instance_destroy(_inst);
	
	return _group;
}
