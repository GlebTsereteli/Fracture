/// @desc Draw bodies

var _prevMatrix = matrix_get(matrix_world);
var _matrix = __FractureMatrix();
var _i = 0; repeat (__n) {
	with (__bodies[_i]) {
		matrix_build(phy_position_x, phy_position_y, 0, 0, 0, -phy_rotation, 1, 1, 1, _matrix);
		matrix_set(matrix_world, _matrix);
		vertex_submit_ext(__vertexBuffer, pr_trianglestrip, __texture, __vertexIndex, __nVertices);
	}
	_i++;
}
matrix_set(matrix_world, _prevMatrix);
