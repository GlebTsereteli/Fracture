// feather ignore all

function FractureCircleRadial(_inst, _bodyCount, _angleNoise = 0.5, _centerNoise = 0.15, _startAngle = random(360)) {
    __FRACTURE_START;
    _bodyCount = max(3, _bodyCount);
	
    var _radius = max(_w, _h) * 0.5;
	
    var _jitter = clamp(_centerNoise, 0, 0.3) * _radius;
    var _originX = _centerX + random_range(-_jitter, _jitter);
    var _originY = _centerY + random_range(-_jitter, _jitter);
	
    var _nArc = max(1, round(64 / _bodyCount));
    var _nArcFx = min(_nArc, 6);
    
	var _bodies = array_create(_bodyCount);
    var _vertexOffset = 0;
    
	// angles
    var _angles = array_create(_bodyCount + 1);
    var _weights = array_create(_bodyCount);
    var _totalWeight = 0;
    for (var _i = 0; _i < _bodyCount; _i++) {
        var _weight = lerp(1, random_range(0.1, 2), _angleNoise);
        _weights[_i] = _weight;
        _totalWeight += _weight;
    }
	
    _angles[0] = _startAngle;
    for (var _i = 0; _i < _bodyCount; _i++) {
        _angles[_i + 1] = _angles[_i] + (_weights[_i] / _totalWeight) * 360;
    }
    
	// main
    for (var _i = 0; _i < _bodyCount; _i++) {
        var _a1 = _angles[_i];
        var _a2 = _angles[_i + 1];
        var _p0x = _originX;
        var _p0y = _originY;
        var _p1x = _centerX + lengthdir_x(_radius, _a1);
        var _p1y = _centerY + lengthdir_y(_radius, _a1);
        var _p2x = _centerX + lengthdir_x(_radius, _a2);
        var _p2y = _centerY + lengthdir_y(_radius, _a2);
        var _xl = min(_p0x, _p1x, _p2x);
        var _yt = min(_p0y, _p1y, _p2y);
		
		// vertices
		for (var _j = 0; _j < _nArc; _j++) {
            var _ta1 = lerp(_a1, _a2, _j / _nArc);
            var _ta2 = lerp(_a1, _a2, (_j + 1) / _nArc);
            var _ax = _centerX + lengthdir_x(_radius, _ta1);
            var _ay = _centerY + lengthdir_y(_radius, _ta1);
            var _bx = _centerX + lengthdir_x(_radius, _ta2);
            var _by = _centerY + lengthdir_y(_radius, _ta2);
            vertex_position(_vb, _p0x - _xl, _p0y - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _p0x / _w), lerp(_v0, _v1, _p0y / _h));
            vertex_position(_vb, _ax - _xl, _ay - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
            vertex_position(_vb, _bx - _xl, _by - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
        }
		
		// body
        var _dist = point_distance(_centerX, _centerY, _xl, _yt);
        var _dir = point_direction(_centerX, _centerY, _xl, _yt);
        var _bodyX = _inst.x + lengthdir_x(_dist, _dir - _angle);
        var _bodyY = _inst.y + lengthdir_y(_dist, _dir - _angle);
		
        with (instance_create_depth(_bodyX, _bodyY, _inst.depth, __objFractureBody)) {
			__state = _state;
            __nVertices = _nArc * 3;
            __vertexIndex = _vertexOffset;
            __vertexBuffer = _vb;
            __texture = _texture;
			
            __FRACTURE_FIXTURE_START; {
			    physics_fixture_add_point(_fx, _originX - _xl, _originY - _yt);
			    for (var _j = _nArcFx; _j >= 0; _j--) {
			        var _a = lerp(_a1, _a2, _j / _nArcFx);
			        physics_fixture_add_point(_fx,
						_centerX + lengthdir_x(_radius, _a) - _xl,
						_centerY + lengthdir_y(_radius, _a) - _yt
					);
			    }
			    __FRACTURE_FIXTURE_END;
			}
			
            _bodies[_i] = id;
        }
        _vertexOffset += _nArc * 3;
    }
	
    __FRACTURE_END;
}