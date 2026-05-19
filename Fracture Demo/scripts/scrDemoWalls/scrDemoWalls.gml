
function DemoWalls() : Demo("Walls") constructor {
	// Shared
	Update = function() {
		if (skin != prevSkin) {
			var _sprite = skin.sprite;
			with (obj) {
				sprite_index = _sprite;
			}
		}
		
		x = clamp(x1 + ((mouse_x - x1) div size) * size, x1, x2 - size);
		y = clamp(y1 + ((mouse_y - y1) div size) * size, y1, y2 - size);
		
		if (not is_mouse_over_debug_overlay()) {
			// Paint
			if (mouse_check_button(mb_left)) {
				if (not IsColliding(x, y)) {
				    Create(x, y);
				    AutoTile(x, y);
				}
			}
			
			// Erase
			if (mouse_check_button(mb_right)) {
				var _tile = Get(x, y);
				if (_tile != noone) {
					impulse.Set(x + size / 2, y + size / 2);
					FractureBoxRadial(_tile, 6);
					AutoTile(x, y);
				}
			}
		}
	};
	Draw = function() {
		draw_rectangle(x1, y1, x2, y2, true);
		draw_rectangle(x, y, x + size, y + size, true);
	};
	RefreshInterface = function() {
		DbgSelector("Skin", skins, array_map(skins, function(_skin) {
			return _skin.name;
		}));
		
		impulse.RefreshInterface();
	};
	
	// Custom
	size = 100;
	obj = objDemoWallsTile;
	
	var _pad = size / 2;
	x1 = ceil(_pad / size) * size;
	y1 = ceil(_pad / size) * size;
	x2 = (room_width - _pad) div size * size;
	y2 = (room_height - _pad) div size * size;
	
	x = -size;
	y = -size;
	
	skins = [
		new DemoWallsSkin("Water"),
		new DemoWallsSkin("Lava"),
		new DemoWallsSkin("Ice"),
	];
	skin = array_first(skins);
	prevSkin = skin;
	
	impulse = new DemoImpulse(0.5);
	
	Create = function(_x, _y) {
		with (instance_create_depth(_x, _y, 0, obj)) {
			sprite_index = other.skin.sprite;
			image_index = image_number - 1;
			
			return id;
		}
	};
	AutoTile = function(_x, _y) {
		static _GetIndex = function(_x, _y) {
			static _lookup = [
			   -001, 255, 247, 253, 245, 127, 119, 125,
				117, 223, 215, 221, 213, 095, 087, 093,
				085, 199, 197, 071, 069, 241, 113, 209,
				081, 124, 092, 116, 084, 031, 023, 029,
				021, 068, 017, 193, 065, 112, 080, 028,
				020, 007, 005, 064, 001, 004, 016, 000,
			];
			var _r = _x + size;
			var _u = _y - size;
			var _l = _x - size;
			var _d = _y + size;
			var _e = IsColliding(_r, _y);
			var _ne = IsColliding(_r, _u);
			var _n = IsColliding(_x, _u);
			var _nw = IsColliding(_l, _u);
			var _w = IsColliding(_l, _y);
			var _sw = IsColliding(_l, _d);
			var _s = IsColliding(_x, _d);
			var _se = IsColliding(_r, _d);
			var _index = (_e * 1) + ((_ne & _e & _n) * 2) + (_n * 4) + ((_nw & _w & _n) * 8) + (_w * 16) + ((_sw & _s & _w) * 32) + (_s * 64) + ((_se & _e & _s) * 128);
			
			return array_get_index(_lookup, _index);
		};
		static _offsets = [0, 0, 1, 0, 1, -1, 0, -1, -1, -1, -1, 0, -1, 1, 0, 1, 1, 1];
		
		for (var _i = 0; _i < 9; _i++) {
		    var _ix = _x + (_offsets[_i * 2] * size);
		    var _iy = _y + (_offsets[_i * 2 + 1] * size);
			
		    var _tile = Get(_ix, _iy);
		    if (_tile != noone) {
		        _tile.image_index = _GetIndex(_ix, _iy);
		    }
		}
	};
	
	IsColliding = function(_x, _y) {
		return position_meeting(_x, _y, obj);
	};
	Get = function(_x, _y) {
		return instance_position(_x, _y, obj);
	};
}
