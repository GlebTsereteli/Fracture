// feather ignore all

#region Info

#macro __FRACTURE_NAME "Fracture"
#macro __FRACTURE_VERSION "v1.0.0" // major.minor.patch
#macro __FRACTURE_DATE "2026.XX.XX" // year.month.day

#endregion
#region Core

#macro __FRACTURE_START \
if (FRACTURE_BENCHMARK) { \
	static _funcName = array_last(string_split(_GMFUNCTION_, "_")); \
} \
\
if (not instance_exists(__objFractureRenderer)) { \
    instance_create_depth(0, 0, 0, __objFractureRenderer); \
} \
\
var _w = _inst.sprite_width; \
var _h = _inst.sprite_height; \
var _centerX = _inst.sprite_xoffset; \
var _centerY = _inst.sprite_yoffset; \
var _texture = sprite_get_texture(_inst.sprite_index, _inst.image_index); \
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
static _format = __FractureFormat(); \
var _vb = vertex_create_buffer(); \
vertex_begin(_vb, _format); \
\
var _state = { \
	__vb: _vb, \
	__count: 0, \
} \
var _vertexOffset = 0; \
var _timer = get_timer();

#macro __FRACTURE_END \
vertex_end(_vb); \
vertex_freeze(_vb); \
_state.__count = _bodyCount; \
if (FRACTURE_BENCHMARK) { \
	__FractureLog($"{_funcName}: Fractured \"{_inst}\" of \"{object_get_name(_inst.object_index)}\" into {_bodyCount} pieces in {(get_timer() - _timer) / 1000}ms"); \
} \
instance_destroy(_inst); \
return _bodies;

#macro __FRACTURE_BODY \
var _dist = point_distance(_centerX, _centerY, _xl, _yt); \
var _dir = point_direction(_centerX, _centerY, _xl, _yt); \
var _bodyX = _inst.x + lengthdir_x(_dist, _dir - _angle); \
var _bodyY = _inst.y + lengthdir_y(_dist, _dir - _angle); \
with (instance_create_depth(_bodyX, _bodyY, _inst.depth, __objFractureBody)) { \
	__state = _state; \
	__vertexBuffer = _vb; \
	__texture = _texture;

#endregion
#region Fixtures

#macro __FRACTURE_FIXTURE_START \
var _fx = physics_fixture_create(); \
physics_fixture_set_collision_group(_fx, FRACTURE_COLLISION_GROUP); \
physics_fixture_set_density(_fx, FRACTURE_DENSITY); \
physics_fixture_set_restitution(_fx, FRACTURE_RESTITUTION); \
physics_fixture_set_friction(_fx, FRACTURE_FRICTION); \
physics_fixture_set_linear_damping(_fx, FRACTURE_LINEAR_DAMPING); \
physics_fixture_set_angular_damping(_fx, FRACTURE_ANGULAR_DAMPING); \
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
}

#endregion
#region Common Blocks

#macro __FRACTURE_RANDOM_ANGLES \
var _angles = array_create(_bodyCount + 1); \
var _weights = array_create(_bodyCount); \
var _totalWeight = 0; \
for (var _i = 0; _i < _bodyCount; _i++) { \
    var _weight = lerp(1, random_range(0.1, 2), _angleNoise); \
    _weights[_i] = _weight; \
    _totalWeight += _weight; \
} \
\
_angles[0] = random(360); \
for (var _i = 0; _i < _bodyCount; _i++) { \
    _angles[_i + 1] = _angles[_i] + (_weights[_i] / _totalWeight) * 360; \
}

#macro __FRACTURE_VERT \
vertex_position(_vb, _px, _py); \
vertex_color(_vb, c_white, 1); \
vertex_texcoord(_vb, lerp(_u0, _u1, (_xl + _px) / _w), lerp(_v0, _v1, (_yt + _py) / _h));

#macro __FRACTURE_BOX_TRI \
_px = _ax; _py = _ay; __FRACTURE_VERT; \
_px = _bx; _py = _by; __FRACTURE_VERT; \
_px = _cx; _py = _cy; __FRACTURE_VERT; \
__FRACTURE_BODY \
    __primitiveType = pr_trianglelist; \
    __nVertices = 3; \
    __vertexIndex = _vertexOffset; \
    __FRACTURE_FIXTURE_START; { \
        physics_fixture_add_point(_fx, _ax, _ay); \
        physics_fixture_add_point(_fx, _bx, _by); \
        physics_fixture_add_point(_fx, _cx, _cy); \
        __FRACTURE_FIXTURE_END; \
    } \
    _bodies[_index++] = id; \
} \
_vertexOffset += 3;

#macro __FRACTURE_BOX_QUAD \
_px = _ax; _py = _ay; __FRACTURE_VERT; \
_px = _bx; _py = _by; __FRACTURE_VERT; \
_px = _cx; _py = _cy; __FRACTURE_VERT; \
_px = _ax; _py = _ay; __FRACTURE_VERT; \
_px = _cx; _py = _cy; __FRACTURE_VERT; \
_px = _dx; _py = _dy; __FRACTURE_VERT; \
__FRACTURE_BODY \
    __primitiveType = pr_trianglelist; \
    __nVertices = 6; \
    __vertexIndex = _vertexOffset; \
    __FRACTURE_FIXTURE_START; { \
        physics_fixture_add_point(_fx, _ax, _ay); \
        physics_fixture_add_point(_fx, _bx, _by); \
        physics_fixture_add_point(_fx, _cx, _cy); \
        physics_fixture_add_point(_fx, _dx, _dy); \
        __FRACTURE_FIXTURE_END; \
    } \
    _bodies[_index++] = id; \
} \
_vertexOffset += 6;

#macro __FRACTURE_BOX_HEX \
_px = _ax; _py = _ay; __FRACTURE_VERT; \
_px = _bx; _py = _by; __FRACTURE_VERT; \
_px = _cx; _py = _cy; __FRACTURE_VERT; \
_px = _ax; _py = _ay; __FRACTURE_VERT; \
_px = _cx; _py = _cy; __FRACTURE_VERT; \
_px = _dx; _py = _dy; __FRACTURE_VERT; \
_px = _ax; _py = _ay; __FRACTURE_VERT; \
_px = _dx; _py = _dy; __FRACTURE_VERT; \
_px = _ex; _py = _ey; __FRACTURE_VERT; \
_px = _ax; _py = _ay; __FRACTURE_VERT; \
_px = _ex; _py = _ey; __FRACTURE_VERT; \
_px = _gx; _py = _gy; __FRACTURE_VERT; \
__FRACTURE_BODY \
    __primitiveType = pr_trianglelist; \
    __nVertices = 12; \
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
    _bodies[_index++] = id; \
} \
_vertexOffset += 12;

#endregion
