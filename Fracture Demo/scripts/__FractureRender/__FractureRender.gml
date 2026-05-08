
function __FractureRender() {
	static _matrix = matrix_build_identity();
	static _uAlpha = shader_get_uniform(__shdFracture, "uAlpha");
	
	var _prevMatrix = matrix_get(matrix_world);
	
	if (FRACTURE_FADE_ENABLED) {
		shader_set(__shdFracture);
	}
	
	with (__objFracturePiece) {
	    matrix_build(phy_position_x, phy_position_y, 0, 0, 0, -phy_rotation, 1, 1, 1, _matrix);
		matrix_set(matrix_world, _matrix);
		
		if (FRACTURE_FADE_ENABLED) {
			shader_set_uniform_f(_uAlpha, image_alpha);
		}
		
		vertex_submit_ext(__vertexBuffer, __primitiveType, __texture, __vertexIndex, __vertexCount);
	}
	
	matrix_set(matrix_world, _prevMatrix);
	
	if (FRACTURE_FADE_ENABLED) {
		shader_reset();
	}
}
