/// @desc Methods

RefreshInterface = function() {
	if (view != undefined) {
		dbg_view_delete(view);
	}
	
	var _pad = 8;
	var _x = _pad;
	var _y = _pad + 19;
	var _w = 400;
	var _h = window_get_height() - _y - _pad;
	var _name = $"{__FRACTURE_NAME} {__FRACTURE_VERSION} Demo: {demo.name}";
	view = dbg_view(_name, true, _x, _y, _w, _h);
	window_set_caption(_name);
	
	var _names = array_map(demos, function(_demo) {
		return _demo.name;
	});
	dbg_drop_down(ref_create(self, "demo"), demos, _names, "Demo");
	
	dbg_same_line();
	var _size = 19;
	dbg_button("-", function() {
		var _index = Mod2(array_get_index(demos, demo) - 1, array_length(demos));
		demo = demos[_index];
	}, _size, _size);
	dbg_same_line();
	dbg_button("+", function() {
		var _index = Mod2(array_get_index(demos, demo) + 1, array_length(demos));
		demo = demos[_index];
	}, _size, _size);
	
	dbg_section(demo.name);
	demo.RefreshInterface();
	
	dbg_section("Debug"); {
		dbg_checkbox(ref_create(self, "outlines"), "Outlines");
		dbg_checkbox(ref_create(self, "coms"), "Coms");
		dbg_checkbox(ref_create(self, "shapes"), "Shapes");
		dbg_checkbox(ref_create(self, "aabb"), "AABB");
	}
	
	if (room != demo.rm) {
		room_goto(demo.rm);
	}
};
