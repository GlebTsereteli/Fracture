/// @desc Clean up fixture and vertex buffer.

physics_fixture_delete(__fixture);

__state.__count--;
if (__state.__count <= 0) {
    vertex_delete_buffer(__state.__vb);
}
