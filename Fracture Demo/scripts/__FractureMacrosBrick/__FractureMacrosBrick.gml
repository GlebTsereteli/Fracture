// feather ignore all

#macro __FRACTURE_BRICK_SETUP \
var _pieceCount = _horizontal ? (_cols * _rows + (_rows div 2)) : (_cols * _rows + (_cols div 2)); \
var _pieces = array_create(_pieceCount); \
\
var _index = 0; \
var _stripCount = _horizontal ? _rows : _cols; \
var _brickCount = _horizontal ? _cols : _rows; \
var _brickW = _w / _cols; \
var _brickH = _h / _rows; \
var _stripSize = _horizontal ? _brickH : _brickW; \
var _brickSize = _horizontal ? _brickW : _brickH; \
var _axisLen = _horizontal ? _w : _h;

#macro __FRACTURE_BRICK_QUAD \
var _hw = (_x2 - _x1) / 2; \
var _hh = (_y2 - _y1) / 2; \
var _ox = _x1 + _hw; \
var _oy = _y1 + _hh; \
vertex_position(_vb, -_hw, -_hh); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _x1 / _w), lerp(_v0, _v1, _y1 / _h)); \
vertex_position(_vb, _hw, -_hh); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _x2 / _w), lerp(_v0, _v1, _y1 / _h)); \
vertex_position(_vb, -_hw, _hh); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _x1 / _w), lerp(_v0, _v1, _y2 / _h)); \
vertex_position(_vb, _hw, _hh); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _x2 / _w), lerp(_v0, _v1, _y2 / _h)); \
__FRACTURE_PIECE \
    __vertexCount = 4; \
    __vertexIndex = _vertexOffset; \
    __FRACTURE_FIXTURE_START; { \
        physics_fixture_set_box_shape(_fx, _hw, _hh); \
        __FRACTURE_FIXTURE_END; \
    } \
    _pieces[_index++] = id; \
} \
_vertexOffset += 4;
