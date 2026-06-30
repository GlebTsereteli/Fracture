// feather ignore all

#region Info

#macro __FRACTURE_NAME "Fracture"
#macro __FRACTURE_VERSION "v1.0.0" // major.minor.patch
#macro __FRACTURE_DATE "2026.07.16" // year.month.day

#endregion
#region Constants

#macro __FRACTURE_CIRCLE_PRECISION 24
#macro __FRACTURE_CONVEX_HULL_PRECISION 24
#macro __FRACTURE_GOLDEN_ANGLE (180 * (3 - sqrt(5)));

#macro __FRACTURE_GRID_MAX_NOISE 0.25
#macro __FRACTURE_VORONOI_BOX_MAX_NOISE 0.4

#endregion
#region Core

#macro __FRACTURE_CATCH_RENDERER \
if (not instance_exists(__objFractureRenderer)) { \
    instance_create_depth(0, 0, 0, __objFractureRenderer); \
}

#macro __FRACTURE_VALIDATE_SHAPE \
if (_shape != FRACTURE_CONVEX_BOX and _shape != FRACTURE_CONVEX_CIRCLE and _shape != FRACTURE_CONVEX_HULL) { \
	__FractureError($"Invalid shape constant <{_shape}>. Expected FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL"); \
}

#macro __FRACTURE_START \
static _cell = array_create(8); \
var _px = 0, _py = 0; \
\
if (not sprite_exists(_inst.sprite_index)) { \
	__FractureError($"Can't fracture <{object_get_name(_inst.object_index)}>, instance has no sprite assigned"); \
} \
if ((_inst.image_xscale < 0) or (_inst.image_yscale < 0)) { \
	__FractureError($"Can't fracture <{object_get_name(_inst.object_index)}>, negative 'image_xscale' or 'image_yscale' is not supported"); \
} \
\
__FRACTURE_CATCH_RENDERER; \
if (FRACTURE_BENCHMARK) { \
	static _funcName = string_replace(array_last(string_split(_GMFUNCTION_, "_")), "Fracture", ""); \
	__FRACTURE_BENCH_START; \
} \
\
var _w = _inst.sprite_width; \
var _h = _inst.sprite_height; \
var _centerX = _inst.sprite_xoffset; \
var _centerY = _inst.sprite_yoffset; \
var _texture = sprite_get_texture(_inst.sprite_index, _inst.image_index); \
var _color = _inst.image_blend; \
var _alpha = _inst.image_alpha; \
\
var _physical = (_inst.phy_active != undefined); \
var _angle = _physical ? _inst.phy_rotation : -_inst.image_angle; \
\
var _uvs = sprite_get_uvs(_inst.sprite_index, _inst.image_index); \
var _u0 = _uvs[0]; \
var _v0 = _uvs[1]; \
var _u1 = _uvs[2]; \
var _v1 = _uvs[3]; \
\
var _vb = vertex_create_buffer(); \
vertex_begin(_vb, Fracture.__format); \
var _vertexOffset = 0; \
\
var _state = { \
	__vb: _vb, \
	__count: 0, \
} \
\
/*@ignore*/ static _physics = Fracture.__physics; \
var _collisionGroup = _physics.__collisionGroup; \
var _density = _physics.__density; \
var _restitution = _physics.__restitution; \
var _friction = _physics.__friction; \
var _linearDamping = _physics.__linearDamping; \
var _angularDamping = _physics.__angularDamping; \
\
/*@ignore*/ static _impulse = Fracture.__impulse; \
var _impulseStrength = _impulse.__strength; \
var _impulseX = _impulse.__x; \
var _impulseY = _impulse.__y; \
var _impulseHasOrigin = (_impulseX != undefined) and (_impulseY != undefined);

#macro __FRACTURE_PIECE \
var _dist = point_distance(_centerX, _centerY, _ox, _oy); \
var _dir = point_direction(_centerX, _centerY, _ox, _oy); \
var _pieceX = _inst.x + lengthdir_x(_dist, _dir - _angle); \
var _pieceY = _inst.y + lengthdir_y(_dist, _dir - _angle); \
with (instance_create_depth(_pieceX, _pieceY, _inst.depth, __objFracturePiece)) { \
	__vertexBuffer = _vb; \
	__texture = _texture; \
	__state = _state; \
	image_alpha = _alpha;

#macro __FRACTURE_FIXTURE_START \
var _fx = physics_fixture_create(); \
physics_fixture_set_collision_group(_fx, _collisionGroup); \
physics_fixture_set_density(_fx, _density); \
physics_fixture_set_restitution(_fx, _restitution); \
physics_fixture_set_friction(_fx, _friction); \
physics_fixture_set_linear_damping(_fx, _linearDamping); \
physics_fixture_set_angular_damping(_fx, _angularDamping); \
physics_fixture_set_polygon_shape(_fx);

#macro __FRACTURE_FIXTURE_END \
__fixture = physics_fixture_bind(_fx, id); \
physics_fixture_delete(_fx); \
\
phy_rotation = _angle; \
if (_physical) { \
	phy_linear_velocity_x = _inst.phy_linear_velocity_x; \
	phy_linear_velocity_y = _inst.phy_linear_velocity_y; \
	phy_angular_velocity = _inst.phy_angular_velocity; \
} \
if (_impulseStrength != 0) { \
    var _impDir = _impulseHasOrigin ? point_direction(_impulseX, _impulseY, x, y) : _dir; \
	physics_apply_impulse( \
		_impulseHasOrigin ? _impulseX : x, \
		_impulseHasOrigin ? _impulseY : y, \
	    lengthdir_x(_impulseStrength, _impDir), \
	    lengthdir_y(_impulseStrength, _impDir) \
	); \
}

#macro __FRACTURE_END \
vertex_end(_vb); \
vertex_freeze(_vb); \
_state.__count = _pieceCount; \
if (FRACTURE_AUTO_RESET) { \
	Fracture.PhysicsReset(); \
	Fracture.ImpulseReset(); \
} \
if (FRACTURE_BENCHMARK) { \
	__FractureLog($"{_funcName}: Fractured <{object_get_name(_inst.object_index)}> into {_pieceCount} pieces in {__FRACTURE_BENCH_END}ms"); \
} \
instance_destroy(_inst); \
return _pieces;

#endregion

#region Vertices

#macro __FRACTURE_VCOLOR vertex_color(_vb, _color, 1);

#macro __FRACTURE_V \
vertex_position(_vb, _px, _py); \
__FRACTURE_VCOLOR; \
vertex_texcoord(_vb, lerp(_u0, _u1, (_ox + _px) / _w), lerp(_v0, _v1, (_oy + _py) / _h));

#endregion
#region Box

#macro __FRACTURE_BOX_TRI \
var _cmx = mean(_ax, _bx, _cx); \
var _cmy = mean(_ay, _by, _cy); \
var _ox = _xl + _cmx; \
var _oy = _yt + _cmy; \
_ax -= _cmx; _bx -= _cmx; _cx -= _cmx; \
_ay -= _cmy; _by -= _cmy; _cy -= _cmy; \
_px = _ax; _py = _ay; __FRACTURE_V; \
_px = _bx; _py = _by; __FRACTURE_V; \
_px = _cx; _py = _cy; __FRACTURE_V; \
__FRACTURE_PIECE \
    __primitiveType = pr_trianglelist; \
    __vertexCount = 3; \
    __vertexIndex = _vertexOffset; \
    __FRACTURE_FIXTURE_START; { \
        physics_fixture_add_point(_fx, _ax, _ay); \
        physics_fixture_add_point(_fx, _bx, _by); \
        physics_fixture_add_point(_fx, _cx, _cy); \
        __FRACTURE_FIXTURE_END; \
    } \
    _pieces[_index++] = id; \
} \
_vertexOffset += 3;

#macro __FRACTURE_BOX_QUAD \
var _cmx = mean(_ax, _bx, _cx, _dx); \
var _cmy = mean(_ay, _by, _cy, _dy); \
var _ox = _xl + _cmx; \
var _oy = _yt + _cmy; \
_ax -= _cmx; _bx -= _cmx; _cx -= _cmx; _dx -= _cmx; \
_ay -= _cmy; _by -= _cmy; _cy -= _cmy; _dy -= _cmy; \
_px = _ax; _py = _ay; __FRACTURE_V; \
_px = _bx; _py = _by; __FRACTURE_V; \
_px = _cx; _py = _cy; __FRACTURE_V; \
_px = _ax; _py = _ay; __FRACTURE_V; \
_px = _cx; _py = _cy; __FRACTURE_V; \
_px = _dx; _py = _dy; __FRACTURE_V; \
__FRACTURE_PIECE \
    __primitiveType = pr_trianglelist; \
    __vertexCount = 6; \
    __vertexIndex = _vertexOffset; \
    __FRACTURE_FIXTURE_START; { \
        physics_fixture_add_point(_fx, _ax, _ay); \
        physics_fixture_add_point(_fx, _bx, _by); \
        physics_fixture_add_point(_fx, _cx, _cy); \
        physics_fixture_add_point(_fx, _dx, _dy); \
        __FRACTURE_FIXTURE_END; \
    } \
    _pieces[_index++] = id; \
} \
_vertexOffset += 6;

#macro __FRACTURE_BOX_HEX \
var _cmx = mean(_ax, _bx, _cx, _dx, _ex, _gx); \
var _cmy = mean(_ay, _by, _cy, _dy, _ey, _gy); \
var _ox = _xl + _cmx; \
var _oy = _yt + _cmy; \
_ax -= _cmx; _bx -= _cmx; _cx -= _cmx; _dx -= _cmx; _ex -= _cmx; _gx -= _cmx; \
_ay -= _cmy; _by -= _cmy; _cy -= _cmy; _dy -= _cmy; _ey -= _cmy; _gy -= _cmy; \
_px = _ax; _py = _ay; __FRACTURE_V; \
_px = _bx; _py = _by; __FRACTURE_V; \
_px = _cx; _py = _cy; __FRACTURE_V; \
_px = _ax; _py = _ay; __FRACTURE_V; \
_px = _cx; _py = _cy; __FRACTURE_V; \
_px = _dx; _py = _dy; __FRACTURE_V; \
_px = _ax; _py = _ay; __FRACTURE_V; \
_px = _dx; _py = _dy; __FRACTURE_V; \
_px = _ex; _py = _ey; __FRACTURE_V; \
_px = _ax; _py = _ay; __FRACTURE_V; \
_px = _ex; _py = _ey; __FRACTURE_V; \
_px = _gx; _py = _gy; __FRACTURE_V; \
__FRACTURE_PIECE \
    __primitiveType = pr_trianglelist; \
    __vertexCount = 12; \
    __vertexIndex = _vertexOffset; \
    __FRACTURE_FIXTURE_START; { \
        physics_fixture_add_point(_fx, _ax, _ay); \
        physics_fixture_add_point(_fx, _bx, _by); \
        physics_fixture_add_point(_fx, _cx, _cy); \
        physics_fixture_add_point(_fx, _dx, _dy); \
        physics_fixture_add_point(_fx, _ex, _ey); \
        physics_fixture_add_point(_fx, _gx, _gy); \
        __FRACTURE_FIXTURE_END; \
    } \
    _pieces[_index++] = id; \
} \
_vertexOffset += 12;

#endregion
#region Hulls

#macro __FRACTURE_CIRCLE_HULL \
var _radius = max(_w, _h) / 2; \
var _radiusSq = _radius * _radius; \
var _hull = array_create(__FRACTURE_CIRCLE_PRECISION * 2); \
for (var _i = 0; _i < __FRACTURE_CIRCLE_PRECISION; _i++) { \
	var _a = (_i / __FRACTURE_CIRCLE_PRECISION) * 360; \
	_hull[_i * 2] = _centerX + lengthdir_x(_radius, _a); \
	_hull[_i * 2 + 1] = _centerY + lengthdir_y(_radius, _a); \
}

#macro __FRACTURE_CONVEX_HULL \
var _hull = __FractureConvexGetHull(_inst); \
var _nHull = array_length(_hull) / 2; \
\
var _edgesX1 = array_create(_nHull); \
var _edgesY1 = array_create(_nHull); \
var _edgesDx = array_create(_nHull); \
var _edgesDy = array_create(_nHull); \
var _hullX1 = infinity, _hullX2 = -infinity; \
var _hullY1 = infinity, _hullY2 = -infinity; \
\
for (var _i = 0; _i < _nHull; _i++) { \
	var _ni = (_i + 1) mod _nHull; \
	var _hx = _hull[_i * 2]; \
	var _hy = _hull[_i * 2 + 1]; \
	\
	_edgesX1[_i] = _hx; \
	_edgesY1[_i] = _hy; \
	_edgesDx[_i] = _hull[_ni * 2] - _hx; \
	_edgesDy[_i] = _hull[_ni * 2 + 1] - _hy; \
	\
	if (_hx < _hullX1) _hullX1 = _hx; \
	if (_hx > _hullX2) _hullX2 = _hx; \
	if (_hy < _hullY1) _hullY1 = _hy; \
	if (_hy > _hullY2) _hullY2 = _hy; \
}

#endregion
#region Clip

#macro __FRACTURE_CLIP_PIECE \
var _clipped = __FracturePolygonClip(_cell, _hull); \
var _vertCount = array_length(_clipped) / 2; \
if (_vertCount >= 3) { \
	\
	var _sumX = 0, _sumY = 0; \
	for (var _v = 0; _v < _vertCount; _v++) { \
		_sumX += _clipped[_v * 2]; \
		_sumY += _clipped[_v * 2 + 1]; \
	} \
	var _ox = _sumX / _vertCount; \
	var _oy = _sumY / _vertCount; \
	\
	for (var _v = 0; _v < _vertCount; _v++) { \
		_clipped[_v * 2] -= _ox; \
		_clipped[_v * 2 + 1] -= _oy; \
	} \
	\
	var _triCount = _vertCount - 2; \
	for (var _t = 0; _t < _triCount; _t++) { \
		_px = _clipped[0]; _py = _clipped[1]; __FRACTURE_V; \
		_px = _clipped[(_t + 1) * 2]; _py = _clipped[(_t + 1) * 2 + 1]; __FRACTURE_V; \
		_px = _clipped[(_t + 2) * 2]; _py = _clipped[(_t + 2) * 2 + 1]; __FRACTURE_V; \
	} \
	\
	var _fixtureCount = min(_vertCount, 8); \
	__FRACTURE_PIECE \
		__primitiveType = pr_trianglelist; \
		__vertexCount = _triCount * 3; \
		__vertexIndex = _vertexOffset; \
		__FRACTURE_FIXTURE_START; { \
			for (var _f = 0; _f < _fixtureCount; _f++) { \
				physics_fixture_add_point(_fx, _clipped[_f * 2], _clipped[_f * 2 + 1]); \
			} \
			__FRACTURE_FIXTURE_END; \
		} \
		_pieces[_index++] = id; \
	} \
	_vertexOffset += _triCount * 3; \
}

#endregion
#region Checks

#macro __FRACTURE_CIRCLE_HIT_BBOX ((_ndx = clamp(_centerX, _minX, _maxX) - _centerX) * _ndx + (_ndy = clamp(_centerY, _minY, _maxY) - _centerY) * _ndy <= _radiusSq)
#macro __FRACTURE_CONVEX_HIT_BBOX (not (_maxX < _hullX1 or _minX > _hullX2 or _maxY < _hullY1 or _minY > _hullY2))

#endregion
#region Benchmark

#macro __FRACTURE_BENCH_START var _benchTime = get_timer();
#macro __FRACTURE_BENCH_END ((get_timer() - _benchTime) / 1000)

#endregion
#region Misc

#macro __FRACTURE_RANDOM_ANGLES \
var _angles = array_create(_pieceCount + 1); \
var _weights = array_create(_pieceCount); \
var _totalWeight = 0; \
for (var _i = 0; _i < _pieceCount; _i++) { \
    var _weight = lerp(1, random_range(0.1, 2), _angleNoise); \
    _weights[_i] = _weight; \
    _totalWeight += _weight; \
} \
\
_angles[0] = random(360); \
for (var _i = 0; _i < _pieceCount; _i++) { \
    _angles[_i + 1] = _angles[_i] + (_weights[_i] / _totalWeight) * 360; \
}

#macro __FRACTURE_MAP_ORIGIN \
var _offsetX = _originX - _inst.x; \
var _offsetY = _originY - _inst.y; \
var _offsetDist = point_distance(0, 0, _offsetX, _offsetY); \
var _offsetDir = point_direction(0, 0, _offsetX, _offsetY); \
_originX = _inst.x + lengthdir_x(_offsetDist, _offsetDir + _angle); \
_originY = _inst.y + lengthdir_y(_offsetDist, _offsetDir + _angle); \
_originX -= _inst.x - _centerX; \
_originY -= _inst.y - _centerY;

#endregion
