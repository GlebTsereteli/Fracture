
image_xscale = random_range(1.5, 2);
image_yscale = image_xscale;
image_index = irandom(image_number - 1);

var _fx = physics_fixture_create(); {
	var _halfW = sprite_width / 2;
	var _halfH = sprite_height / 2
	
	physics_fixture_set_collision_group(_fx, 1);
	physics_fixture_set_box_shape(_fx, _halfW, _halfH);
	physics_fixture_set_density(_fx, 0.5);
	physics_fixture_set_restitution(_fx, 0.5);
	
	var _offsetX = _halfW - sprite_xoffset;
	var _offsetY = _halfH - sprite_yoffset;
	fixture = physics_fixture_bind_ext(_fx, id, _offsetX, _offsetY);
	physics_fixture_delete(_fx);
}
