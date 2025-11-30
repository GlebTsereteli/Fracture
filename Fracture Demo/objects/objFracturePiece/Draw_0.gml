
var _matrix = matrix_build(phy_position_x, phy_position_y, 0, 0, 0, -phy_rotation, 1, 1, 1);
matrix_set(matrix_world, _matrix);

var _texture = sprite_get_texture(sprite, frame);
vertex_submit(vb, pr_trianglestrip, _texture);

matrix_set(matrix_world, matrixIdentity);
