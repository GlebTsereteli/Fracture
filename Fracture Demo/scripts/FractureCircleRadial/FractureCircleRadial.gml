// feather ignore all
function FractureCircleRadial(_inst, _bodyCount, _angleNoise = 0.5, _originX = undefined, _originY = undefined) {
    __FRACTURE_START;
    _bodyCount = max(3, _bodyCount);
	
    var _radius = max(_w, _h) * 0.5;
	
    // Map origin to local space
	if (_originX != undefined and _originY != undefined) {
        var _dist = min(point_distance(_inst.x, _inst.y, _originX, _originY), _radius - 1);
        var _dir = point_direction(_inst.x, _inst.y, _originX, _originY);
        _originX = _centerX + lengthdir_x(_dist, _dir + _angle);
        _originY = _centerY + lengthdir_y(_dist, _dir + _angle);
    }
    else {
        _originX = _centerX;
        _originY = _centerY;
    }
	
    var _nArc = max(1, round(__FRACTURE_CIRCLE_PRECISION / _bodyCount));
    var _nArcFx = min(_nArc, 6);
    var _bodies = array_create(_bodyCount);
	
    __FRACTURE_RANDOM_ANGLES;
	
    // Main
    for (var _i = 0; _i < _bodyCount; _i++) {
        var _a1 = _angles[_i];
        var _a2 = _angles[_i + 1];
		
        var _p1x = _centerX + lengthdir_x(_radius, _a1);
        var _p1y = _centerY + lengthdir_y(_radius, _a1);
        var _p2x = _centerX + lengthdir_x(_radius, _a2);
        var _p2y = _centerY + lengthdir_y(_radius, _a2);
		
        var _xl = min(_originX, _p1x, _p2x);
        var _yt = min(_originY, _p1y, _p2y);
		
        // Vertices
        for (var _j = 0; _j < _nArc; _j++) {
            var _ta1 = lerp(_a1, _a2, _j / _nArc);
            var _ta2 = lerp(_a1, _a2, (_j + 1) / _nArc);
            var _ax = _centerX + lengthdir_x(_radius, _ta1);
            var _ay = _centerY + lengthdir_y(_radius, _ta1);
            var _bx = _centerX + lengthdir_x(_radius, _ta2);
            var _by = _centerY + lengthdir_y(_radius, _ta2);
            vertex_position(_vb, _originX - _xl, _originY - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _originX / _w), lerp(_v0, _v1, _originY / _h));
            vertex_position(_vb, _ax - _xl, _ay - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
            vertex_position(_vb, _bx - _xl, _by - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
        }
		
        // Body
        __FRACTURE_BODY
            __nVertices = _nArc * 3;
            __vertexIndex = _vertexOffset;
			
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
