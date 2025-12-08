
grid.Draw();

with (all) {
	physics_draw_debug();
}

//__FRACTURE_FORMAT

//vb = vertex_create_buffer();
//vertex_begin(vb, _format);

//var _sprite = sprAnimal;
//var _w = sprite_get_width(_sprite);
//var _h = sprite_get_height(_sprite);
//var _texture = sprite_get_texture(_sprite, 0);

//vertex_position(vb, 0, 0); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 0, 0);
//vertex_position(vb, _w, 0); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 1, 0);
//vertex_position(vb, _w, _h); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 1, 1);

//vertex_position(vb, _w, _h); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 1, 1);
//vertex_position(vb, 0, _h); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 0, 1);
//vertex_position(vb, 0, 0); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 0, 0);

//vertex_end(vb);

//vertex_submit_ext(vb, pr_trianglestrip, _texture, 0, 3);
//vertex_submit_ext(vb, pr_trianglestrip, _texture, 3, 3);

//vertex_delete_buffer(vb);
