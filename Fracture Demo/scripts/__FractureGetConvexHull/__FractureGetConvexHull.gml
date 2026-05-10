// feather ignore all

function __FractureGetConvexHull(_inst) {
	static _hulls = {};
	
	var _key = $"{_inst.sprite_index},{_inst.image_index}";
	_hulls[$ _key] ??= sprite_get_convex_hull(_inst.sprite_index, undefined, _inst.image_index);
	var _hull = _hulls[$ _key];
	
	var _n = array_length(_hull) / 2;
	var _poly = array_create(_n * 2);
	
	for (var _i = 0; _i < _n; _i++) {
		_poly[_i * 2] = _hull[_i * 2] * _inst.image_xscale;
		_poly[_i * 2 + 1] = _hull[_i * 2 + 1] * _inst.image_yscale;
	}
	
	return _poly;
}
