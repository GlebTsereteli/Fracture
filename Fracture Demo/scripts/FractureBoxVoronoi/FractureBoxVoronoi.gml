
function FractureBoxVoronoi(_inst, _count, _minDist = 0) {
	__FRACTURE_FORMAT;
	
	var _w = _inst.sprite_width;
	var _h = _inst.sprite_height;
	var _xCenter = _w / 2;
	var _yCenter = _h / 2;
	var _angle = _inst.phy_rotation;
	
	var _texture = sprite_get_texture(_inst.sprite_index, _inst.image_index);
	var _pieces = array_create(_count);
	var _vb = vertex_create_buffer();
	vertex_begin(_vb, _format);
	
	// generate seeds in sprite-local space
	var _seeds = [];
	var _attempts = 0;
	var _maxAttempts = _count * 100;
	
	while ((array_length(_seeds) < _count) and (_attempts < _maxAttempts)) {
		_attempts++;
		var _sx = random(_w);
		var _sy = random(_h);
		var _tooClose = false;
		for (var _k = 0; _k < array_length(_seeds); _k++) {
			if (point_distance(_sx, _sy, _seeds[_k].x, _seeds[_k].y) < _minDist) {
				_tooClose = true;
				break;
			}
		}
		if (not _tooClose) {
			array_push(_seeds, { x: _sx, y: _sy });
		}
	}
	
	var _nSeeds = array_length(_seeds);
	var _index = 0;
	var _vertexOffset = 0;
	
	for (var _i = 0; _i < _nSeeds; _i++) {
		var _polygon = [
			{ x: 0,  y: 0  },
			{ x: _w, y: 0  },
			{ x: _w, y: _h },
			{ x: 0,  y: _h },
		];
		
		var _iSeed = _seeds[_i];
		for (var _j = 0; _j < _nSeeds; _j++) {
			if (_i == _j) continue;
			if (array_length(_polygon) == 0) break;
			
			var _jSeed = _seeds[_j];
			var _midX = mean(_iSeed.x, _jSeed.x);
			var _midY = mean(_iSeed.y, _jSeed.y);
			var _normalX = _iSeed.x - _jSeed.x;
			var _normalY = _iSeed.y - _jSeed.y;
			_polygon = __FracturePolygonClipHalfPlane(_polygon, _midX, _midY, _normalX, _normalY);
		}
		
		var _nVerts = array_length(_polygon);
		if (_nVerts < 3) continue;
		
		var _nTriangles = _nVerts - 2;
		var _nVerticesForPiece = _nTriangles * 3;
		
		var _xl = _polygon[0].x;
		var _yt = _polygon[0].y;
		for (var _k = 1; _k < _nVerts; _k++) {
			_xl = min(_xl, _polygon[_k].x);
			_yt = min(_yt, _polygon[_k].y);
		}
		
		var _dist = point_distance(_xCenter, _yCenter, _xl, _yt);
		var _dir = point_direction(_xCenter, _yCenter, _xl, _yt);
		var _pieceX = _inst.x + lengthdir_x(_dist, _dir - _angle);
		var _pieceY = _inst.y + lengthdir_y(_dist, _dir - _angle);
		
		with (instance_create_depth(_pieceX, _pieceY, _inst.depth, __objFracturePiece)) {
			for (var _k = 1; _k < _nVerts - 1; _k++) {
				var _p0 = _polygon[0];
				var _pk = _polygon[_k];
				var _pk1 = _polygon[_k + 1];
				vertex_position(_vb, _p0.x - _xl,  _p0.y - _yt);  vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _p0.x / _w,  _p0.y / _h);
				vertex_position(_vb, _pk.x - _xl,  _pk.y - _yt);  vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _pk.x / _w,  _pk.y / _h);
				vertex_position(_vb, _pk1.x - _xl, _pk1.y - _yt); vertex_colour(_vb, c_white, 1); vertex_texcoord(_vb, _pk1.x / _w, _pk1.y / _h);
			}
			
			__nVertices = _nVerticesForPiece;
			__vertexIndex = _vertexOffset;
			__vertexBuffer = _vb;
			__texture = _texture;
			
			var _fx = physics_fixture_create();
			physics_fixture_set_collision_group(_fx, 1);
			physics_fixture_set_polygon_shape(_fx);
			physics_fixture_set_density(_fx, 0.5);
			for (var _k = 0; _k < _nVerts; _k++) {
				physics_fixture_add_point(_fx, _polygon[_k].x - _xl, _polygon[_k].y - _yt);
			}
			__fixture = physics_fixture_bind(_fx, id);
			physics_fixture_delete(_fx);
			
			phy_linear_velocity_x = _inst.phy_linear_velocity_x;
			phy_linear_velocity_y = _inst.phy_linear_velocity_y;
			phy_angular_velocity = _inst.phy_angular_velocity;
			phy_rotation = _angle;
			
			var _force = 0.5;
			var _xImpulse = lengthdir_x(_force, _dir);
			var _yImpulse = lengthdir_y(_force, _dir);
			physics_apply_impulse(x, y, _xImpulse, _yImpulse);
			
			_pieces[_index] = self;
		}
		
		_vertexOffset += _nVerticesForPiece;
		_index++;
	}
	
	vertex_end(_vb);
	vertex_freeze(_vb);
	
	var _group = instance_create_depth(0, 0, _inst.depth, __objFracturePack);
	_group.__vertexBuffer = _vb;
	_group.__pieces = _pieces;
	_group.__n = _index;
	
	instance_destroy(_inst);
	
	return _group;
}