/// @desc Methods

RefreshInterface = function() {
	if (view != undefined) {
		dbg_view_delete(view);
	}
	
	var _pad = 8;
	var _x = _pad;
	var _y = _pad + 19;
	var _w = 400;
	var _totalH = room_height; //display_get_gui_height();
	var _h = _totalH - _y - _pad;
	var _name = $"{__FRACTURE_NAME} {__FRACTURE_VERSION} Demo: {demo.name}";
	view = dbg_view(_name, true, _x, _y, _w, _h);
	window_set_caption(_name);
	
	DbgSelector("Demo", demos);
	
	dbg_section(demo.name);
	demo.RefreshInterface();
	
	dbg_section("Debug"); {
		dbg_checkbox(ref_create(self, "outlines"), "Outlines");
		dbg_checkbox(ref_create(self, "coms"), "Coms");
		dbg_checkbox(ref_create(self, "shapes"), "Shapes");
	}
	
	if (room != demo.rm) {
		room_goto(demo.rm);
	}
};
