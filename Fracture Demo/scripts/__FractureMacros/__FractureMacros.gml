
#macro __FRACTURE_FORMAT var _format = __FractureFormat()

#macro __FRACTURE_MATRIX \
static _matrix = matrix_build_identity(); \
return _matrix;

#macro __FRACTURE_LOCAL_MATRICES \
var _matrixA = __FractureMatrixA(); \
var _matrixB = __FractureMatrixB(); \
var _matrixC = __FractureMatrixC(); \
var _matrixIdentity = __FractureMatrixIdentity()

#macro __FRACTURE_MATRICES \
matrixA = __FractureMatrixA(); \
matrixB = __FractureMatrixB(); \
matrixC = __FractureMatrixC(); \
matrixIdentity = __FractureMatrixIdentity()
