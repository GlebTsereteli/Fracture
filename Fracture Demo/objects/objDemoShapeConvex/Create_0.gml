
image_xscale = random_range(1, 1.5);
image_yscale = image_xscale;
image_index = irandom(image_number - 1);

var _fx = physics_fixture_create(); {
	physics_fixture_set_collision_group(_fx, FRACTURE_COLLISION_GROUP);
	physics_fixture_set_polygon_shape(_fx);
	
	var _points = [36, -120, 84, -95, 121, -31, 0, 121, -120, -31, -84, -96, -37, -120];
	for (var _i = 0; _i < array_length(_points); _i += 2) {
		physics_fixture_add_point(_fx, _points[_i] * image_xscale, _points[_i + 1] * image_yscale);
	}
	
	physics_fixture_set_density(_fx, 0.5);
	physics_fixture_set_restitution(_fx, 0.5);
	
	var _offsetX = (sprite_width / 2) - sprite_xoffset;
	var _offsetY = (sprite_height / 2) - sprite_yoffset;
	fixture = physics_fixture_bind_ext(_fx, id, _offsetX, _offsetY);
	physics_fixture_delete(_fx);
}
