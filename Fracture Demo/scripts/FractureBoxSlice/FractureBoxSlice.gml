// feather ignore all

function FractureBoxSlice(_inst, _bodyCount, _cutAngle = 45) {
    __FRACTURE_START;
    
    var _dx = lengthdir_x(1, _cutAngle + 90);
	var _dy = lengthdir_y(1, _cutAngle + 90);
    
    var _projTL = 0;
    var _projTR = _w * _dx;
    var _projBR = _w * _dx + _h * _dy;
    var _projBL = _h * _dy;
    
    var _minProj = min(_projTL, _projTR, _projBR, _projBL);
    var _step = (max(_projTL, _projTR, _projBR, _projBL) - _minProj) / _bodyCount;
    
    // CW corners: TL, TR, BR, BL
    var _cornerX = [0, _w, _w, 0];
    var _cornerY = [0, 0, _h, _h];
    var _cornerProj = [_projTL, _projTR, _projBR, _projBL];
    
    var _bodies = array_create(_bodyCount);
    
    // Max 6 verts per strip (convex quad + 2 cut planes), reused each iteration
    var _vertX = array_create(6);
    var _vertY = array_create(6);
    
    for (var _i = 0; _i < _bodyCount; _i++) {
        var _near = _minProj + (_step * _i);
        var _far = _minProj + (_step * (_i + 1));
        var _vertCount = 0;
        
        for (var _edge1 = 0; _edge1 < 4; _edge1++) {
            var _edge2 = (_edge1 + 1) mod 4;
            var _ax = _cornerX[_edge1], _ay = _cornerY[_edge1], _aProj = _cornerProj[_edge1];
            var _bx = _cornerX[_edge2], _by = _cornerY[_edge2], _bProj = _cornerProj[_edge2];
            
            if (_aProj >= _near and _aProj <= _far) {
                _vertX[_vertCount] = _ax;
                _vertY[_vertCount] = _ay;
                _vertCount++;
            }
            
            var _projDelta = _bProj - _aProj;
            if (_projDelta != 0) {
                var _tNear = (_near - _aProj) / _projDelta;
                var _tFar = (_far - _aProj) / _projDelta;
                var _t1 = min(_tNear, _tFar);
                var _t2 = max(_tNear, _tFar);
                
                if (_t1 > 0 and _t1 < 1) {
                    _vertX[_vertCount] = lerp(_ax, _bx, _t1);
                    _vertY[_vertCount] = lerp(_ay, _by, _t1);
                    _vertCount++;
                }
                
                if (_t2 != _t1 and _t2 > 0 and _t2 < 1) {
                    _vertX[_vertCount] = lerp(_ax, _bx, _t2);
                    _vertY[_vertCount] = lerp(_ay, _by, _t2);
                    _vertCount++;
                }
            }
        }
        
        var _sumX = 0, _sumY = 0;
        for (var _v = 0; _v < _vertCount; _v++) {
            _sumX += _vertX[_v];
            _sumY += _vertY[_v];
        }
        var _pcx = _sumX / _vertCount;
        var _pcy = _sumY / _vertCount;
        
        var _xl = _pcx, _yt = _pcy;
        for (var _v = 0; _v < _vertCount; _v++) {
            _xl = min(_xl, _vertX[_v]);
            _yt = min(_yt, _vertY[_v]);
        }
        
        // Vertices. Fan from centroid through closed polygon boundary
        var _nTris = _vertCount;
        var _cu = lerp(_u0, _u1, _pcx / _w);
        var _cv = lerp(_v0, _v1, _pcy / _h);
        for (var _j = 0; _j < _nTris; _j++) {
            var _ax = _vertX[_j], _ay = _vertY[_j];
            var _bx = _vertX[(_j + 1) mod _vertCount], _by = _vertY[(_j + 1) mod _vertCount];
            vertex_position(_vb, _pcx - _xl, _pcy - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, _cu, _cv);
            vertex_position(_vb, _ax - _xl, _ay - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
            vertex_position(_vb, _bx - _xl, _by - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
        }
        
        // Body
        __FRACTURE_BODY
            __nVertices = _nTris * 3;
            __vertexIndex = _vertexOffset;
            
            __FRACTURE_FIXTURE_START; {
                for (var _j = 0; _j < _vertCount; _j++) {
                    physics_fixture_add_point(_fx, _vertX[_j] - _xl, _vertY[_j] - _yt);
                }
                __FRACTURE_FIXTURE_END;
            }
            
            _bodies[_i] = id;
        }
        _vertexOffset += _nTris * 3;
    }
    
    __FRACTURE_END;
}
