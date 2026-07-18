// feather ignore all

#macro __FRACTURE_GRID_SETUP \
var _spacingX = _w / _cols; \
var _spacingY = _h / _rows; \
_noiseX = clamp(_noiseX, 0, 1) * __FRACTURE_GRID_MAX_NOISE * _spacingX; \
_noiseY = clamp(_noiseY, 0, 1) * __FRACTURE_GRID_MAX_NOISE * _spacingY; \
\
var _pieceCount = _rows * _cols; \
var _pieces = array_create(_pieceCount); \
var _index = 0; \
\
var _colX = array_create(_rows + 1); \
var _colY = array_create(_rows + 1); \
var _prevColX = array_create(_rows + 1); \
var _prevColY = array_create(_rows + 1);

#macro __FRACTURE_GRID_QUAD \
var _ox = (_x1 + _x2 + _x3 + _x4) / 4; \
var _oy = (_y1 + _y2 + _y3 + _y4) / 4; \
\
vertex_position(_vb, _x1 - _ox, _y1 - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _x1 / _w), lerp(_v0, _v1, _y1 / _h)); \
vertex_position(_vb, _x2 - _ox, _y2 - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _x2 / _w), lerp(_v0, _v1, _y2 / _h)); \
vertex_position(_vb, _x4 - _ox, _y4 - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _x4 / _w), lerp(_v0, _v1, _y4 / _h)); \
vertex_position(_vb, _x3 - _ox, _y3 - _oy); __FRACTURE_VCOLOR; vertex_texcoord(_vb, lerp(_u0, _u1, _x3 / _w), lerp(_v0, _v1, _y3 / _h)); \
\
__FRACTURE_PIECE \
	__vertexCount = 4; \
	__vertexIndex = _vertexOffset; \
	__FRACTURE_FIXTURE_START; { \
		physics_fixture_add_point(_fx, _x1 - _ox, _y1 - _oy); \
		physics_fixture_add_point(_fx, _x2 - _ox, _y2 - _oy); \
		physics_fixture_add_point(_fx, _x3 - _ox, _y3 - _oy); \
		physics_fixture_add_point(_fx, _x4 - _ox, _y4 - _oy); \
		__FRACTURE_FIXTURE_END; \
	} \
	_pieces[_index++] = id; \
} \
_vertexOffset += 4;

#macro __FRACTURE_GRID_SWAP \
var _tempX = _prevColX; \
var _tempY = _prevColY; \
_prevColX = _colX; \
_prevColY = _colY; \
_colX = _tempX; \
_colY = _tempY;
