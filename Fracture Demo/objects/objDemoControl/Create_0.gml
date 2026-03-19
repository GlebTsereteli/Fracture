
var _pad = 8;
var _x = _pad;
var _y = _pad + 19;
var _w = 400;
var _h = window_get_height() - _y - _pad;
view = dbg_view($"{__FRACTURE_NAME} {__FRACTURE_VERSION} Demo", true, _x, _y, _w, _h);

outlines = true;
coms = false;
shapes = false;
aabb = false;

dbg_section("Debug"); {
	dbg_checkbox(ref_create(self, "outlines"), "Outlines");
	dbg_checkbox(ref_create(self, "coms"), "Coms");
	dbg_checkbox(ref_create(self, "shapes"), "Shapes");
	dbg_checkbox(ref_create(self, "aabb"), "AABB");
}
