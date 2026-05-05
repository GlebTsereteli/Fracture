
demo.Draw();

// debug
var _flags = (coms * phy_debug_render_coms) | (shapes * phy_debug_render_shapes) | (aabb * phy_debug_render_aabb);
physics_world_draw_debug(_flags);

if (outlines) {
	with (all) {
		physics_draw_debug();
	}
}
