/// @desc Render bodies.

var _zwrite = gpu_get_zwriteenable();
var _ztest = gpu_get_ztestenable();
var _depth = gpu_get_depth();
var _prevMatrix = matrix_get(matrix_world);
var _matrix = __FractureMatrix();

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);

var _uAlpha = __uAlpha;
shader_set(__shader);

with (__objFracturePack) {
	gpu_set_depth(depth);
	
	var _i = 0; repeat (__n) {
		with (__bodies[_i]) {
			matrix_build(phy_position_x, phy_position_y, 0, 0, 0, -phy_rotation, 1, 1, 1, _matrix);
			matrix_set(matrix_world, _matrix);
			shader_set_uniform_f(_uAlpha, image_alpha);
			vertex_submit_ext(__vertexBuffer, pr_trianglestrip, __texture, __vertexIndex, __nVertices);
		}
		_i++;
	}
}

shader_reset();

matrix_set(matrix_world, _prevMatrix);
gpu_set_depth(_depth);
gpu_set_zwriteenable(_zwrite);
gpu_set_ztestenable(_ztest);
