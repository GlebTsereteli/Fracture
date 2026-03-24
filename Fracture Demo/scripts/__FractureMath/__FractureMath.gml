
function __FracturePolygonClipHalfPlane(_polygon, _bisectorX, _bisectorY, _normalX, _normalY) {
    var _n = array_length(_polygon) / 2;
    if (_n == 0) return [];
    
    var _result = [];
    
    for (var _i = 0; _i < _n; _i++) {
        var _v1x = _polygon[_i * 2];
        var _v1y = _polygon[_i * 2 + 1];
        var _v2x = _polygon[((_i + 1) mod _n) * 2];
        var _v2y = _polygon[((_i + 1) mod _n) * 2 + 1];
        
        // signed distance from each vertex to the bisector line
        var _v1Dist = ((_v1x - _bisectorX) * _normalX) + ((_v1y - _bisectorY) * _normalY);
        var _v2Dist = ((_v2x - _bisectorX) * _normalX) + ((_v2y - _bisectorY) * _normalY);
        var _v1Inside = (_v1Dist >= 0);
        
        // keep current vertex if on the correct side
        if (_v1Inside) {
            array_push(_result, _v1x, _v1y);
        }
        
        // if edge straddles the boundary, add the intersection point
        if (_v1Inside != (_v2Dist >= 0)) {
            var _step = _v1Dist / (_v1Dist - _v2Dist);
            array_push(_result,
                _v1x + (_step * (_v2x - _v1x)),
                _v1y + (_step * (_v2y - _v1y))
            );
        }
    }
    
    return _result;
}
function __FracturePolygonCentroid(_polygon) {
    var _n = array_length(_polygon) / 2;
    var _signedArea = 0;
    var _centroidX = 0;
    var _centroidY = 0;
    
    for (var _i = 0; _i < _n; _i++) {
        var _v1x = _polygon[_i * 2];
        var _v1y = _polygon[_i * 2 + 1];
        var _v2x = _polygon[((_i + 1) mod _n) * 2];
        var _v2y = _polygon[((_i + 1) mod _n) * 2 + 1];
        
        // cross product of consecutive edge pairs, used to weight each vertex pair by area
        var _crossWeight = (_v1x * _v2y) - (_v2x * _v1y);
        _signedArea += _crossWeight;
        
        _centroidX += (_v1x + _v2x) * _crossWeight;
        _centroidY += (_v1y + _v2y) * _crossWeight;
    }
    
    // 1 / (6 * area), derived from the polygon centroid integral
    // _signedArea is 2x true area, so we use 3 instead of 6
    var _invArea = 1 / (3 * _signedArea);
    return {
        x: _centroidX * _invArea,
        y: _centroidY * _invArea,
    };
}

function __FracturePointInCircumcircle(_ax, _ay, _bx, _by, _cx, _cy, _px, _py) {
	var _apx = _ax - _px, _apy = _ay - _py;
	var _bpx = _bx - _px, _bpy = _by - _py;
	var _cpx = _cx - _px, _cpy = _cy - _py;
	
	var _apLen = _apx * _apx + _apy * _apy;
	var _bpLen = _bpx * _bpx + _bpy * _bpy;
	var _cpLen = _cpx * _cpx + _cpy * _cpy;
	
	var _det = _apx * (_bpy * _cpLen - _cpy * _bpLen) - _apy * (_bpx * _cpLen - _cpx * _bpLen) + _apLen * (_bpx * _cpy - _bpy * _cpx);
	return (_det > 0);
}

function __FracturePointInConvexPolygon(_polygon, _px, _py) {
    var _vertexCount = array_length(_polygon) / 2;
    
    for (var _i = 0; _i < _vertexCount; _i++) {
        var _i2 = (_i + 1) mod _vertexCount;
        
        // edge vector from current vertex to next vertex
        var _edgeX = _polygon[_i2 * 2] - _polygon[_i * 2];
        var _edgeY = _polygon[_i2 * 2 + 1] - _polygon[_i * 2 + 1];
        
        // vector from current vertex to point
        var _pointVecX = _px - _polygon[_i * 2];
        var _pointVecY = _py - _polygon[_i * 2 + 1];
        
        // check cross product to see if point is outside
        if ((_edgeX * _pointVecY - _edgeY * _pointVecX) < 0) return false;
    }
    
    return true;
}
