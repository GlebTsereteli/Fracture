/// @desc Clean up fixture and vertex buffer.

physics_fixture_delete(__fixture);

__state.__n--;
if (__state.__n <= 0) {
    vertex_delete_buffer(__state.__vb);
}
