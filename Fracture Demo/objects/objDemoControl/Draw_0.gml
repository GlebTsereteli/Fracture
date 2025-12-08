
var _matrix = __FractureMatrixA();
with (objFracturePiece) {
	matrix_build(phy_position_x, phy_position_y, 0, 0, 0, -phy_rotation, 1, 1, 1, _matrix);
	matrix_set(matrix_world, _matrix);
	vertex_submit(__vb, pr_trianglestrip, __texture);
}
matrix_set(matrix_world, __FractureMatrixIdentity());

grid.Draw();

with (all) {
	physics_draw_debug();
}
