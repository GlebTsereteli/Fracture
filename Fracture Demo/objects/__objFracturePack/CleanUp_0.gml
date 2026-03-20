/// @desc Destroy bodies & vertex buffer.

var _i = 0; repeat (__bodyCount) {
	instance_destroy(__bodies[_i++]);
}
vertex_delete_buffer(__vertexBuffer);
