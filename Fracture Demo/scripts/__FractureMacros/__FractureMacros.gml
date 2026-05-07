// feather ignore all

#region Info

#macro __FRACTURE_NAME "Fracture"
#macro __FRACTURE_VERSION "v1.0.0" // major.minor.patch
#macro __FRACTURE_DATE "2026.XX.XX" // year.month.day

#endregion
#region Constants

#macro __FRACTURE_CIRCLE_PRECISION 32

#macro __FRACTURE_IMPULSE_FORCE 0
#macro __FRACTURE_IMPULSE_DIR undefined

#endregion
#region Core

#macro __FRACTURE_CATCH_RENDERER \
if (not instance_exists(__objFractureRenderer)) { \
    instance_create_depth(0, 0, 0, __objFractureRenderer); \
}

#macro __FRACTURE_START \
__FRACTURE_CATCH_RENDERER; \
if (FRACTURE_BENCHMARK) { \
	static _funcName = string_replace(array_last(string_split(_GMFUNCTION_, "_")), "Fracture", ""); \
	var _timer = get_timer(); \
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
var _vertexOffset = 0; \
\
var _state = { \
	__vb: _vb, \
	__count: 0, \
} \
\
static _system = __FractureSystem(); \
var _collisionGroup = _system.__collisionGroup; \
var _density = _system.__density; \
var _restitution = _system.__restitution; \
var _friction = _system.__friction; \
var _linearDamping = _system.__linearDamping; \
var _angularDamping = _system.__angularDamping; \
\
var _impulseForce = _system.__impulseForce; \
var _impulseDir = _system.__impulseDir;

#macro __FRACTURE_PIECE \
var _dist = point_distance(_centerX, _centerY, _ox, _oy); \
var _dir = point_direction(_centerX, _centerY, _ox, _oy); \
var _pieceX = _inst.x + lengthdir_x(_dist, _dir - _angle); \
var _pieceY = _inst.y + lengthdir_y(_dist, _dir - _angle); \
with (instance_create_depth(_pieceX, _pieceY, _inst.depth, __objFracturePiece)) { \
	__vertexBuffer = _vb; \
	__texture = _texture; \
	__state = _state;

#macro __FRACTURE_END \
vertex_end(_vb); \
vertex_freeze(_vb); \
_state.__count = _pieceCount; \
if (FRACTURE_AUTO_RESET) { \
	FracturePieceReset(); \
	FractureImpulseReset(); \
} \
if (FRACTURE_BENCHMARK) { \
	__FractureLog($"{_funcName}: Fractured <{object_get_name(_inst.object_index)}> into {_pieceCount} pieces in {(get_timer() - _timer) / 1000}ms"); \
} \
instance_destroy(_inst); \
return _pieces;

#endregion
#region Fixtures

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
if (_impulseForce != 0) { \
	var _impDir = _impulseDir ?? _dir; \
	physics_apply_local_impulse(0, 0, \
		lengthdir_x(_impulseForce, _impDir), \
		lengthdir_y(_impulseForce, _impDir) \
	); \
}

#endregion
#region Box Blocks

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

#macro __FRACTURE_VERT \
vertex_position(_vb, _px, _py); \
vertex_color(_vb, c_white, 1); \
vertex_texcoord(_vb, lerp(_u0, _u1, (_ox + _px) / _w), lerp(_v0, _v1, (_oy + _py) / _h));

#macro __FRACTURE_BOX_TRI \
var _cmx = mean(_ax, _bx, _cx); \
var _cmy = mean(_ay, _by, _cy); \
var _ox = _xl + _cmx; \
var _oy = _yt + _cmy; \
_ax -= _cmx; _bx -= _cmx; _cx -= _cmx; \
_ay -= _cmy; _by -= _cmy; _cy -= _cmy; \
_px = _ax; _py = _ay; __FRACTURE_VERT; \
_px = _bx; _py = _by; __FRACTURE_VERT; \
_px = _cx; _py = _cy; __FRACTURE_VERT; \
__FRACTURE_PIECE \
    __primitiveType = pr_trianglelist; \
    __nVertices = 3; \
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
_px = _ax; _py = _ay; __FRACTURE_VERT; \
_px = _bx; _py = _by; __FRACTURE_VERT; \
_px = _cx; _py = _cy; __FRACTURE_VERT; \
_px = _ax; _py = _ay; __FRACTURE_VERT; \
_px = _cx; _py = _cy; __FRACTURE_VERT; \
_px = _dx; _py = _dy; __FRACTURE_VERT; \
__FRACTURE_PIECE \
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
__FRACTURE_PIECE \
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
    _pieces[_index++] = id; \
} \
_vertexOffset += 12;

#endregion
