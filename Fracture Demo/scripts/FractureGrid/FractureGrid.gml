
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
	
	static Generate = function() {
		cells = array_create(gridDivsX * gridDivsY);
		
		var _prevCol = undefined;
		var _notFirst = false;
		var _index = 0;
		
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
		
		        var _px = round(_x);
		        var _py = round(_y);
		        _col[_j] = [_px, _py];
		
		        if ((_i > 0) and (_j > 0)) {
		            var _tl = _prevCol[_j - 1];
		            var _tr = _col[_j - 1];
		            var _br = _col[_j];
		            var _bl = _prevCol[_j];
            
		            cells[_index++] = {
		                x1: _tl[0], y1: _tl[1],
		                x2: _tr[0], y2: _tr[1],
		                x3: _br[0], y3: _br[1],
		                x4: _bl[0], y4: _bl[1]
		            };
		        }
		    }
		    _prevCol = _col;
		}
	};
	static Draw = function() {
		var _matrix = matrix_build(xOffset, yOffset, 0, 0, 0, 0, 1, 1, 1);
		matrix_set(matrix_world, _matrix);
		
		array_foreach(cells, function(_cell) {
			draw_primitive_begin(pr_linestrip);
			with (_cell) {
				draw_vertex(x1, y1); draw_circle(x1, y1, 4, false);
				draw_vertex(x2, y2); draw_circle(x2, y2, 4, false);
				draw_vertex(x3, y3); draw_circle(x3, y3, 4, false);
				draw_vertex(x4, y4); draw_circle(x4, y4, 4, false);
				draw_vertex(x1, y1); draw_circle(x1, y1, 4, false);
			}
			draw_primitive_end();
		});
		
		matrix_set(matrix_world, matrix_build_identity());
	};
}
