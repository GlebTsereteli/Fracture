/// @desc Destroy bodies, clean up VB.

var _i = 0; repeat (array_length(__bodies)) {
	instance_destroy(__bodies[_i++]);
}
vertex_delete_buffer(__vertexBuffer);
