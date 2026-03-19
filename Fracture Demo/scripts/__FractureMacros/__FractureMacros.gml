
#region info

#macro __FRACTURE_NAME "Fracture"
#macro __FRACTURE_VERSION "v1.0.0" // major.minor.patch
#macro __FRACTURE_DATE "2026.XX.XX" // year.month.day
#macro __FRACTURE_LOG_PREFIX ("[" + __FRACTURE_NAME + "]")

#endregion
#region core

#macro __FRACTURE_START \
static _format = __FractureFormat(); \
var _vb = vertex_create_buffer(); \
vertex_begin(_vb, _format)

#macro __FRACTURE_BOX_START \
__FRACTURE_START; \
var _w = _inst.sprite_width; \
var _h = _inst.sprite_height; \
var _centerX = _w / 2; \
var _centerY = _h / 2; \
var _angle = _inst.phy_rotation; \
var _texture = sprite_get_texture(_inst.sprite_index, _inst.image_index)

#macro __FRACTURE_MATRIX \
static _matrix = matrix_build_identity(); \
return _matrix

#endregion
