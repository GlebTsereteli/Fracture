/// @desc Destroy pieces.

var _i = 0; repeat (__n) {
	instance_destroy(__pieces[_i]);
	_i++;
}
vertex_delete_buffer(__vertexBuffer);
