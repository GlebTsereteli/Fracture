event_inherited();

var _fx = physics_fixture_create(); {
	physics_fixture_set_collision_group(_fx, FRACTURE_DEFAULT_COLLISION_GROUP);
	physics_fixture_set_polygon_shape(_fx);
	
	var _points = [70, 0, 77, 0, 147, 54, 147, 62, 120, 147, 27, 147, 0, 62, 0, 54];
	for (var _i = 0; _i < array_length(_points); _i += 2) {
		physics_fixture_add_point(_fx,
			(_points[_i] * image_xscale) - sprite_xoffset,
			(_points[_i + 1] * image_yscale) - sprite_yoffset
		);
	}
	
	physics_fixture_set_density(_fx, 0.5);
	physics_fixture_set_restitution(_fx, 0.5);
	fixture = physics_fixture_bind(_fx, id);
	physics_fixture_delete(_fx);
}
