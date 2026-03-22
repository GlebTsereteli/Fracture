// feather ignore all

#region info

#macro __FRACTURE_NAME "Fracture"
#macro __FRACTURE_VERSION "v1.0.0" // major.minor.patch
#macro __FRACTURE_DATE "2026.XX.XX" // year.month.day

#endregion
#region core

#macro __FRACTURE_START \
if (not instance_exists(__objFractureRenderer)) { \
    instance_create_depth(0, 0, 0, __objFractureRenderer); \
} \
\
var _w = _inst.sprite_width; \
var _h = _inst.sprite_height; \
var _centerX = _inst.sprite_xoffset; \
var _centerY = _inst.sprite_yoffset; \
var _angle = _inst.phy_rotation; \
var _texture = sprite_get_texture(_inst.sprite_index, _inst.image_index); \
\
var _uvs = sprite_get_uvs(_inst.sprite_index, _inst.image_index); \
var _u0 = _uvs[0]; \
var _v0 = _uvs[1]; \
var _u1 = _uvs[2]; \
var _v1 = _uvs[3]; \
\
static _format = __FractureFormat(); \
var _vb = vertex_create_buffer(); \
vertex_begin(_vb, _format);

#macro __FRACTURE_END \
vertex_end(_vb); \
vertex_freeze(_vb); \
\
var _pack = instance_create_depth(0, 0, _inst.depth, __objFracturePack); \
_pack.__vertexBuffer = _vb; \
_pack.__bodies = _bodies; \
_pack.__bodyCount = _bodyCount; \
\
instance_destroy(_inst); \
\
return _pack;

#macro __FRACTURE_MATRIX \
static _matrix = matrix_build_identity(); \
return _matrix;

#endregion
#region fixtures

#macro __FRACTURE_FIXTURE_START \
var _fx = physics_fixture_create(); \
physics_fixture_set_collision_group(_fx, FRACTURE_COLLISION_GROUP); \
physics_fixture_set_polygon_shape(_fx); \
physics_fixture_set_density(_fx, 0.5);

#macro __FRACTURE_FIXTURE_END \
__fixture = physics_fixture_bind(_fx, id); \
physics_fixture_delete(_fx); \
\
phy_rotation = _angle; \
phy_linear_velocity_x = _inst.phy_linear_velocity_x; \
phy_linear_velocity_y = _inst.phy_linear_velocity_y; \
phy_angular_velocity = _inst.phy_angular_velocity;

#endregion
