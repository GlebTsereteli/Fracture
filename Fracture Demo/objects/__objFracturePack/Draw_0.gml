/// @desc Render bodies.

var _prevMatrix = matrix_get(matrix_world);
var _matrix = __FractureMatrix();
var _uAlpha = __FractureAlphaUniform();

shader_set(__FRACTURE_SHADER);

var _i = 0; repeat (array_length(__bodies)) {
	with (__bodies[_i++]) {
		matrix_build(phy_position_x, phy_position_y, 0, 0, 0, -phy_rotation, 1, 1, 1, _matrix);
		matrix_set(matrix_world, _matrix);
	    shader_set_uniform_f(_uAlpha, image_alpha);
	    vertex_submit_ext(__vertexBuffer, __primitiveType, __texture, __vertexIndex, __nVertices);
	}
}

matrix_set(matrix_world, _prevMatrix);
shader_reset();
