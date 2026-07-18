// feather ignore all

/// @ignore
function __FractureConvexGetHull(_inst) {
	static _hulls = {};
	
	var _key = $"{_inst.sprite_index},{_inst.image_index}";
	_hulls[$ _key] ??= sprite_get_convex_hull(_inst.sprite_index, __FRACTURE_CONVEX_HULL_PRECISION, _inst.image_index);
	var _hull = _hulls[$ _key];
	
	var _n = array_length(_hull) / 2;
	var _poly = array_create(_n * 2);
	
	var _scaleX = _inst.image_xscale;
	var _scaleY = _inst.image_yscale;
	var _offsetX = _inst.sprite_xoffset;
	var _offsetY = _inst.sprite_yoffset;
	
	for (var _i = 0; _i < _n; _i++) {
		_poly[_i * 2] = _hull[_i * 2] * _scaleX + _offsetX;
		_poly[_i * 2 + 1] = _hull[_i * 2 + 1] * _scaleY + _offsetY;
	}
	
	return _poly;
}
