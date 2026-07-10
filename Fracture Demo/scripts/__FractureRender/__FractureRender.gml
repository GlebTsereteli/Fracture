// feather ignore all

/// @ignore
function __FractureRender() {
	static _matrix = matrix_build_identity();
	static _uAlpha = shader_get_uniform(__FractureShader, "uAlpha");
	
	if (not instance_exists(__FracturePiece)) return;
	
	var _prevMatrix = matrix_get(matrix_world);
	
	shader_set(__FractureShader);
	
	with (__FracturePiece) {
		matrix_build(phy_position_x, phy_position_y, 0, 0, 0, -phy_rotation, 1, 1, 1, _matrix);
		matrix_set(matrix_world, _matrix);
		
		shader_set_uniform_f(_uAlpha, image_alpha);
		
		vertex_submit_ext(__vertexBuffer, __primitiveType, __texture, __vertexIndex, __vertexCount);
	}
	
	matrix_set(matrix_world, _prevMatrix);
	
	shader_reset();
}
