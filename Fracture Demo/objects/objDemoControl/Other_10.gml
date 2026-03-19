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
	view = dbg_view($"{__FRACTURE_NAME} {__FRACTURE_VERSION} Demo", true, _x, _y, _w, _h);
	
	dbg_section("Type"); {
		var _names = array_map(types, function(_type) {
			return _type.name;
		});
		dbg_drop_down(ref_create(self, "type"), types, _names, "Type");
		
		dbg_same_line();
		var _size = 19;
		dbg_button("-", function() {
			var _index = Mod2(array_get_index(types, type) - 1, array_length(types));
			type = types[_index];
		}, _size, _size);
		dbg_same_line();
		dbg_button("+", function() {
			var _index = Mod2(array_get_index(types, type) + 1, array_length(types));
			type = types[_index];
		}, _size, _size);
		
		dbg_text_separator($"{type.name} Parameters");
		
		type.Init();
	}
	dbg_section("Debug"); {
		dbg_checkbox(ref_create(self, "outlines"), "Outlines");
		dbg_checkbox(ref_create(self, "coms"), "Coms");
		dbg_checkbox(ref_create(self, "shapes"), "Shapes");
		dbg_checkbox(ref_create(self, "aabb"), "AABB");
	}
};
Fracture = function(_inst) {
	var _t = get_timer();
	
	var _args = type.GetArguments(_inst);
	array_insert(_args, 0, _inst);
	method_call(type.func, _args);
	
	show_debug_message((get_timer() - _t) / 1000);
};
