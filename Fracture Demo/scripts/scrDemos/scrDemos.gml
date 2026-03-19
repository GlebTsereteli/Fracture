
#macro DEMOS global.__demos

function Demos() constructor {
	pool = [
		new DemoGrid(),
	];
	n = array_length(pool);
	index = 0;
	index2 = 0;
	x1 = undefined;
	y1 = undefined;
	x2 = undefined;
	y2 = undefined;
	xCenter = undefined;
	yCenter = undefined;
	w = undefined;
	h = undefined;
	
	static Init = function() {
		RefreshInterface();
	};
	static RefreshInterface = function() {
		static _view = undefined;
		
		var _pad = 8;
		var _x = _pad;
		var _y = _pad + 19;
		var _w = 400;
		var _h = window_get_height() - _y - _pad;
		
		x1 = _x + _w + _pad;
		y1 = _y;
		x2 = room_width - _pad;
		y2 = room_height - _pad;
		xCenter = mean(x1, x2);
		yCenter = mean(y1, y2);
		w = x2 - x1;
		h = y2 - y1;
		
		if (_view != undefined) {
			dbg_view_delete(_view);
		}
		
		_view = dbg_view($"{__FRACTURE_NAME} {__FRACTURE_VERSION} Demo", true, _x, _y, _w, _h);
	};
}
