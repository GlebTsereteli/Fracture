// feather ignore all

function __FractureLogBase(_message) {
	show_debug_message($"[{__FRACTURE_NAME}] {_message}.");
}
function __FractureLog(_message) {
	if (not FRACTURE_DEBUG) return;
	
	__FractureLogBase(_message);
}
function __FractureError(_message) {
	show_error($"[{__FRACTURE_NAME} {__FRACTURE_VERSION}] Error.\n-----------------------------------\n{_message}.\n\n", true);
}

function __FractureFormat() {
	static _format = (function() {
		vertex_format_begin();
		vertex_format_add_position();
		vertex_format_add_color();
		vertex_format_add_texcoord();
		return vertex_format_end();
	})();
	return _format;
}

function __FractureMatrix() {
	__FRACTURE_MATRIX;
}
function __FractureMatrixIdentity() {
	__FRACTURE_MATRIX;
}

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
