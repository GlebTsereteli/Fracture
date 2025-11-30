
function FractureGrid() constructor {
	width = 400;
	height = 400;
	gridDivsX = 5;
	gridDivsY = 5;
	spacingX = width / gridDivsX;
	spacingY = height / gridDivsY;
	noise = 0.2;
	noiseX = spacingX * noise;
	noiseY = spacingY * noise;
	cells = [];
	
	xOffset = (room_width - width) / 2;
	yOffset = (room_height - height) / 2;
	
	vertex_format_begin();
	vertex_format_add_position();
	vertex_format_add_color();
	format = vertex_format_end();
	
	static Generate = function() {
		cells = array_create(gridDivsX * gridDivsY);
		
		var _prevCol = undefined;
		var _notFirst = false;
		var _index = 0;
		
		var _xPrev = undefined;
		var _yPrev = undefined;
		
		for (var _i = 0; _i <= gridDivsX; _i++) {
		    var _col = array_create(gridDivsY);
			
		    for (var _j = 0; _j <= gridDivsY; _j++) {
		        var _x = _i * spacingX;
		        var _y = _j * spacingY;
		
		        var _onEdge = ((_i == 0) or (_i == gridDivsX) or (_j == 0) or (_j == gridDivsY));
		        if (_onEdge) {
					if ((_i > 0) and (_i < gridDivsX)) {
						_x += random_range(-noiseX, noiseX);
					}
					if ((_j > 0) and (_j < gridDivsY)) {
						_y += random_range(-noiseY, noiseY);
					}
				}
				else {
		            _x += random_range(-noiseX, noiseX);
		            _y += random_range(-noiseY, noiseY);
		        }
		
				_x = round(_x);
				_y = round(_y);
				
		        _col[_j] = [_x, _y];
				
		        if ((_i > 0) and (_j > 0)) {
		            var _tl = _prevCol[_j - 1];
		            var _tr = _col[_j - 1];
		            var _br = _col[_j];
		            var _bl = _prevCol[_j];
					
					var _x1 = _tl[0], _y1 = _tl[1];
					var _x2 = _tr[0], _y2 = _tr[1];
					var _x3 = _br[0], _y3 = _br[1];
					var _x4 = _bl[0], _y4 = _bl[1];
					
					//var _color = make_color_hsv(_index * 10, 200, 200);
					var _color = c_white;
					
					var _vb = vertex_create_buffer(); {
						vertex_begin(_vb, format);
						
						vertex_position(_vb, _x1, _y1); vertex_colour(_vb, _color, 1);
						vertex_position(_vb, _x2, _y2); vertex_colour(_vb, _color, 1);
						vertex_position(_vb, _x3, _y3); vertex_colour(_vb, _color, 1);
						
						vertex_position(_vb, _x3, _y3); vertex_colour(_vb, _color, 1);
						vertex_position(_vb, _x4, _y4); vertex_colour(_vb, _color, 1);
						vertex_position(_vb, _x1, _y1); vertex_colour(_vb, _color, 1);
						
						vertex_end(_vb);
						vertex_freeze(_vb);
					}
					var _w = max(_x2, _x3) - min(_x1, _x4);
					var _h = max(_y2, _y3) - min(_y1, _y4);
		            cells[_index++] = new FractureGridCell(_vb, _w, _h);
		        }
		    }
		    _prevCol = _col;
		}
	};
	
	static Draw = function() {
		__FRACTURE_LOCAL_MATRICES;
		
		var _t = get_timer();
		
		matrix_build(xOffset, yOffset, 0, 0, 0, 0, 1, 1, 1, _matrixA);
		matrix_set(matrix_world, _matrixA);
		
		array_foreach(cells, function(_cell) {
			_cell.Draw();
		});
		
		show_debug_message((get_timer() - _t) / 1000);
		
		with (cells[0]) {
		    var _angle = current_time / 10
		    matrix_build(mouse_x, mouse_y, 0, 0, 0, _angle, 1, 1, 1, _matrixA);
		    matrix_build(-w / 2, -h / 2, 0, 0, 0, 0, 1, 1, 1, _matrixB);
			matrix_multiply(_matrixB, _matrixA, _matrixC)
		    matrix_set(matrix_world, _matrixC);
		    Draw();
		}
		
		matrix_set(matrix_world, _matrixIdentity);
	};
}
function FractureGridCell(_vb, _w, _h) constructor {
	vb = _vb;
	w = _w;
	h = _w;
	
	static Draw = function() {
		vertex_submit(vb, pr_linestrip, -1);
	};
	static Cleanup = function() {
		vertex_delete_buffer(vb);
	};
}
