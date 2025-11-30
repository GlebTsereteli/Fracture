
var _fx = physics_fixture_create(); {
	physics_fixture_set_collision_group(_fx, 1);
	physics_fixture_set_box_shape(_fx, sprite_width / 2, sprite_height / 2)
	physics_fixture_set_density(_fx, 0.5);

	fixture = physics_fixture_bind(_fx, id);
	physics_fixture_delete(_fx);
}

image_index = irandom(image_number - 1);
