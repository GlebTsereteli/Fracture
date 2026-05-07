
demo.Draw();

// Debug
var _flags = (coms * phy_debug_render_coms) | (shapes * phy_debug_render_shapes);
physics_world_draw_debug(_flags);

if (outlines) {
	with (all) {
		physics_draw_debug();
	}
}
