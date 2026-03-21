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

var _prevDepth = undefined;
var _prevAlpha = undefined;
with (__objFractureBody) {
    if (depth != _prevDepth) {
        gpu_set_depth(depth);
        _prevDepth = depth;
    }
    matrix_build(phy_position_x, phy_position_y, 0, 0, 0, -phy_rotation, 1, 1, 1, _matrix);
	matrix_set(matrix_world, _matrix);
    if (image_alpha != _prevAlpha) {
        shader_set_uniform_f(_uAlpha, image_alpha);
        _prevAlpha = image_alpha;
    }
    vertex_submit_ext(__vertexBuffer, pr_trianglestrip, __texture, __vertexIndex, __nVertices);
}

matrix_set(matrix_world, _prevMatrix);
shader_reset();
gpu_set_depth(_depth);
gpu_set_zwriteenable(_zwrite);
gpu_set_ztestenable(_ztest);
