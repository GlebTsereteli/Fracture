// feather ignore all

function FractureBoxDiamond(_inst, _cols, _rows) {
	__FRACTURE_START;
	
	_cols = round(_cols);
	_rows = round(_rows);
	
	var _cellW = _w / _cols;
	var _hw = _cellW * 0.5;
	var _cellH = 2 * _h / (_rows + 1);
	var _hh = _cellH * 0.5;
	
	// body count
	var _nOddRows = _rows div 2;
	var _oddBottom = (_rows mod 2 != 0);
	var _bodyCount = _rows * _cols + _nOddRows + 2 * _cols + 1 + (_oddBottom ? 1 : 0);
	var _bodies = array_create(_bodyCount);
	var _index = 0;
	var _vertexOffset = 0;
	
	#region full and half cells
	
	for (var _row = 0; _row < _rows; _row++) {
		var _rowY = (_row + 1) * _hh;
		var _odd = (_row mod 2 == 1);
		var _nCols = _cols - _odd;
		var _xFrom = _odd ? _cellW : _hw;
		
		if (_odd) {
			// left half-diamond
			var _ax = 0, _ay = _rowY - _hh;
			var _bx = _hw, _by = _rowY;
			var _cx = 0, _cy = _rowY + _hh;
			var _xl = 0;
			var _yt = _ay;
			
			vertex_position(_vb, _ax - _xl, _ay - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
			vertex_position(_vb, _bx - _xl, _by - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
			vertex_position(_vb, _cx - _xl, _cy - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _cx / _w), lerp(_v0, _v1, _cy / _h));
			
			__FRACTURE_BODY
				__primitiveType = pr_trianglelist;
				__nVertices = 3;
				__vertexIndex = _vertexOffset;
				
				__FRACTURE_FIXTURE_START; {
					physics_fixture_add_point(_fx, _ax - _xl, _ay - _yt);
					physics_fixture_add_point(_fx, _bx - _xl, _by - _yt);
					physics_fixture_add_point(_fx, _cx - _xl, _cy - _yt);
					__FRACTURE_FIXTURE_END;
				}
				
				_bodies[_index++] = id;
			}
			
			_vertexOffset += 3;
			
			// right half-diamond
			_ax = _w; _ay = _rowY - _hh;
			_bx = _w; _by = _rowY + _hh;
			_cx = _w - _hw; _cy = _rowY;
			_xl = _cx;
			_yt = _ay;
			
			vertex_position(_vb, _ax - _xl, _ay - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
			vertex_position(_vb, _bx - _xl, _by - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
			vertex_position(_vb, _cx - _xl, _cy - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _cx / _w), lerp(_v0, _v1, _cy / _h));
			
			__FRACTURE_BODY
				__primitiveType = pr_trianglelist;
				__nVertices = 3;
				__vertexIndex = _vertexOffset;
				
				__FRACTURE_FIXTURE_START; {
					physics_fixture_add_point(_fx, _ax - _xl, _ay - _yt);
					physics_fixture_add_point(_fx, _bx - _xl, _by - _yt);
					physics_fixture_add_point(_fx, _cx - _xl, _cy - _yt);
					__FRACTURE_FIXTURE_END;
				}
				
				_bodies[_index++] = id;
			}
			
			_vertexOffset += 3;
		}
		
		// full diamonds
		for (var _col = 0; _col < _nCols; _col++) {
			var _dcx = _xFrom + _col * _cellW;
			var _tx = _dcx, _ty = _rowY - _hh;
			var _rx = _dcx + _hw, _ry = _rowY;
			var _bx = _dcx, _by = _rowY + _hh;
			var _lx = _dcx - _hw, _ly = _rowY;
			var _xl = _lx;
			var _yt = _ty;
			
			// triangle 1: top, right, bottom
			vertex_position(_vb, _tx - _xl, _ty - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _tx / _w), lerp(_v0, _v1, _ty / _h));
			vertex_position(_vb, _rx - _xl, _ry - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _rx / _w), lerp(_v0, _v1, _ry / _h));
			vertex_position(_vb, _bx - _xl, _by - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
			
			// triangle 2: top, bottom, left
			vertex_position(_vb, _tx - _xl, _ty - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _tx / _w), lerp(_v0, _v1, _ty / _h));
			vertex_position(_vb, _bx - _xl, _by - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
			vertex_position(_vb, _lx - _xl, _ly - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _lx / _w), lerp(_v0, _v1, _ly / _h));
			
			__FRACTURE_BODY
				__primitiveType = pr_trianglelist;
				__nVertices = 6;
				__vertexIndex = _vertexOffset;
				
				__FRACTURE_FIXTURE_START; {
					physics_fixture_add_point(_fx, _tx - _xl, _ty - _yt);
					physics_fixture_add_point(_fx, _rx - _xl, _ry - _yt);
					physics_fixture_add_point(_fx, _bx - _xl, _by - _yt);
					physics_fixture_add_point(_fx, _lx - _xl, _ly - _yt);
					__FRACTURE_FIXTURE_END;
				}
				
				_bodies[_index++] = id;
			}
			
			_vertexOffset += 6;
		}
	}
	
	#endregion
	#region top triangles
	
	// top-left corner
	var _ax = 0, _ay = 0;
	var _bx = _hw, _by = 0;
	var _cx = 0, _cy = _hh;
	var _xl = 0;
	var _yt = 0;
	
	vertex_position(_vb, _ax - _xl, _ay - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
	vertex_position(_vb, _bx - _xl, _by - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
	vertex_position(_vb, _cx - _xl, _cy - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _cx / _w), lerp(_v0, _v1, _cy / _h));
	
	__FRACTURE_BODY
		__primitiveType = pr_trianglelist;
		__nVertices = 3;
		__vertexIndex = _vertexOffset;
		
		__FRACTURE_FIXTURE_START; {
			physics_fixture_add_point(_fx, _ax - _xl, _ay - _yt);
			physics_fixture_add_point(_fx, _bx - _xl, _by - _yt);
			physics_fixture_add_point(_fx, _cx - _xl, _cy - _yt);
			__FRACTURE_FIXTURE_END;
		}
		
		_bodies[_index++] = id;
	}
	
	_vertexOffset += 3;
	
	// top middle
	var _topX = _hw;
	repeat (_cols - 1) {
		_ax = _topX; _ay = 0;
		_bx = _topX + _cellW; _by = 0;
		_cx = _topX + _hw; _cy = _hh;
		_xl = _ax;
		_yt = 0;
		
		vertex_position(_vb, _ax - _xl, _ay - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
		vertex_position(_vb, _bx - _xl, _by - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
		vertex_position(_vb, _cx - _xl, _cy - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _cx / _w), lerp(_v0, _v1, _cy / _h));
		
		__FRACTURE_BODY
			__primitiveType = pr_trianglelist;
			__nVertices = 3;
			__vertexIndex = _vertexOffset;
			
			__FRACTURE_FIXTURE_START; {
				physics_fixture_add_point(_fx, _ax - _xl, _ay - _yt);
				physics_fixture_add_point(_fx, _bx - _xl, _by - _yt);
				physics_fixture_add_point(_fx, _cx - _xl, _cy - _yt);
				__FRACTURE_FIXTURE_END;
			}
			
			_bodies[_index++] = id;
		}
		
		_vertexOffset += 3;
		_topX += _cellW;
	}
	
	// top-right corner
	_ax = _w - _hw; _ay = 0;
	_bx = _w; _by = 0;
	_cx = _w; _cy = _hh;
	_xl = _ax;
	_yt = 0;
	
	vertex_position(_vb, _ax - _xl, _ay - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
	vertex_position(_vb, _bx - _xl, _by - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
	vertex_position(_vb, _cx - _xl, _cy - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _cx / _w), lerp(_v0, _v1, _cy / _h));
	
	__FRACTURE_BODY
		__primitiveType = pr_trianglelist;
		__nVertices = 3;
		__vertexIndex = _vertexOffset;
		
		__FRACTURE_FIXTURE_START; {
			physics_fixture_add_point(_fx, _ax - _xl, _ay - _yt);
			physics_fixture_add_point(_fx, _bx - _xl, _by - _yt);
			physics_fixture_add_point(_fx, _cx - _xl, _cy - _yt);
			__FRACTURE_FIXTURE_END;
		}
		
		_bodies[_index++] = id;
	}
	
	_vertexOffset += 3;
	
	#endregion
	#region bottom triangles
	
	if (_oddBottom) {
		// bottom-left corner
		_ax = 0; _ay = _h - _hh;
		_bx = _hw; _by = _h;
		_cx = 0; _cy = _h;
		_xl = 0;
		_yt = _ay;
		
		vertex_position(_vb, _ax - _xl, _ay - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
		vertex_position(_vb, _bx - _xl, _by - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
		vertex_position(_vb, _cx - _xl, _cy - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _cx / _w), lerp(_v0, _v1, _cy / _h));
		
		__FRACTURE_BODY
			__primitiveType = pr_trianglelist;
			__nVertices = 3;
			__vertexIndex = _vertexOffset;
			
			__FRACTURE_FIXTURE_START; {
				physics_fixture_add_point(_fx, _ax - _xl, _ay - _yt);
				physics_fixture_add_point(_fx, _bx - _xl, _by - _yt);
				physics_fixture_add_point(_fx, _cx - _xl, _cy - _yt);
				__FRACTURE_FIXTURE_END;
			}
			
			_bodies[_index++] = id;
		}
		
		_vertexOffset += 3;
		
		// bottom-right corner
		_ax = _w; _ay = _h - _hh;
		_bx = _w; _by = _h;
		_cx = _w - _hw; _cy = _h;
		_xl = _cx;
		_yt = _ay;
		
		vertex_position(_vb, _ax - _xl, _ay - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
		vertex_position(_vb, _bx - _xl, _by - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
		vertex_position(_vb, _cx - _xl, _cy - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _cx / _w), lerp(_v0, _v1, _cy / _h));
		
		__FRACTURE_BODY
			__primitiveType = pr_trianglelist;
			__nVertices = 3;
			__vertexIndex = _vertexOffset;
			
			__FRACTURE_FIXTURE_START; {
				physics_fixture_add_point(_fx, _ax - _xl, _ay - _yt);
				physics_fixture_add_point(_fx, _bx - _xl, _by - _yt);
				physics_fixture_add_point(_fx, _cx - _xl, _cy - _yt);
				__FRACTURE_FIXTURE_END;
			}
			
			_bodies[_index++] = id;
		}
		
		_vertexOffset += 3;
	}
	
	// bottom middle
	var _botX = _oddBottom ? _hw : 0;
	var _nBot = _cols - (_oddBottom ? 1 : 0);
	repeat (_nBot) {
		_ax = _botX; _ay = _h;
		_bx = _botX + _hw; _by = _h - _hh;
		_cx = _botX + _cellW; _cy = _h;
		_xl = _ax;
		_yt = _by;
		
		vertex_position(_vb, _ax - _xl, _ay - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _ax / _w), lerp(_v0, _v1, _ay / _h));
		vertex_position(_vb, _bx - _xl, _by - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _bx / _w), lerp(_v0, _v1, _by / _h));
		vertex_position(_vb, _cx - _xl, _cy - _yt); vertex_color(_vb, c_white, 1); vertex_texcoord(_vb, lerp(_u0, _u1, _cx / _w), lerp(_v0, _v1, _cy / _h));
		
		__FRACTURE_BODY
			__primitiveType = pr_trianglelist;
			__nVertices = 3;
			__vertexIndex = _vertexOffset;
			
			__FRACTURE_FIXTURE_START; {
				physics_fixture_add_point(_fx, _ax - _xl, _ay - _yt);
				physics_fixture_add_point(_fx, _bx - _xl, _by - _yt);
				physics_fixture_add_point(_fx, _cx - _xl, _cy - _yt);
				__FRACTURE_FIXTURE_END;
			}
			
			_bodies[_index++] = id;
		}
		
		_vertexOffset += 3;
		_botX += _cellW;
	}
	
	#endregion
	
	__FRACTURE_END;
}
