// feather ignore all

/// @func FractureConvexDiamond()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// 
/// @desc Fractures the given convex-shaped instance into a diamond pattern clipped to the convex hull, defined by the number of columns and rows.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureConvexDiamond(_inst, _cols, _rows) {
    __FRACTURE_START;
    __FRACTURE_CONVEX_HULL;
    
    _cols = round(_cols);
    _rows = round(_rows);
    
    var _cellW = _w / _cols;
    var _hw = _cellW / 2;
    var _cellH = 2 * _h / (_rows + 1);
    var _hh = _cellH / 2;
    var _nOddRows = _rows div 2;
    var _oddBottom = (_rows mod 2 != 0);
    
    var _pieceCount = _rows * _cols + _nOddRows + 2 * _cols + 1 + (_oddBottom ? 1 : 0);
    var _pieces = array_create(_pieceCount);
    var _index = 0;
    
    var _cell = [];
    var _px = 0, _py = 0;
    var _ox = 0, _oy = 0;
    var _x1 = 0, _y1 = 0;
    var _x2 = 0, _y2 = 0;
    var _x3 = 0, _y3 = 0;
    var _x4 = 0, _y4 = 0;
    var _fullyInside = true;
    
    #region Full and half cells
	
    for (var _row = 0; _row < _rows; _row++) {
        var _rowY = (_row + 1) * _hh;
        var _odd = (_row mod 2 == 1);
        var _nCols = _cols - (_odd ? 1 : 0);
        var _xFrom = _odd ? _cellW : _hw;
        
        if (_odd) {
            // Left half-diamond
            if (not (_hw < _hullX1 or 0 > _hullX2 or _rowY + _hh < _hullY1 or _rowY - _hh > _hullY2)) {
                _cell = [0, _rowY - _hh, _hw, _rowY, 0, _rowY + _hh];
                __FRACTURE_CLIP_PIECE;
            }
			
            // Right half-diamond
            if (not (_w < _hullX1 or _w - _hw > _hullX2 or _rowY + _hh < _hullY1 or _rowY - _hh > _hullY2)) {
                _cell = [_w, _rowY - _hh, _w, _rowY + _hh, _w - _hw, _rowY];
                __FRACTURE_CLIP_PIECE;
            }
        }
        
        // Full diamonds
        for (var _col = 0; _col < _nCols; _col++) {
            var _cx = _xFrom + _col * _cellW;
            
            if (_cx + _hw < _hullX1 or _cx - _hw > _hullX2 or _rowY + _hh < _hullY1 or _rowY - _hh > _hullY2) continue;
            
            _x1 = _cx;       _y1 = _rowY - _hh;
            _x2 = _cx + _hw; _y2 = _rowY;
            _x3 = _cx;       _y3 = _rowY + _hh;
            _x4 = _cx - _hw; _y4 = _rowY;
            
            _fullyInside = true;
            for (var _e = 0; _e < _nHull; _e++) {
                var _edgeX1 = _edgesX1[_e], _edgeY1 = _edgesY1[_e];
                var _edgeDx = _edgesDx[_e], _edgeDy = _edgesDy[_e];
                if ((_edgeDx * (_y1 - _edgeY1) - _edgeDy * (_x1 - _edgeX1)) < 0 or
                    (_edgeDx * (_y2 - _edgeY1) - _edgeDy * (_x2 - _edgeX1)) < 0 or
                    (_edgeDx * (_y3 - _edgeY1) - _edgeDy * (_x3 - _edgeX1)) < 0 or
                    (_edgeDx * (_y4 - _edgeY1) - _edgeDy * (_x4 - _edgeX1)) < 0) {
                    _fullyInside = false;
                    break;
                }
            }
            
            if (_fullyInside) {
                __FRACTURE_GRID_QUAD;
            }
            else {
                _cell = [_x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4];
                __FRACTURE_CLIP_PIECE;
            }
        }
    }
    #endregion
    
    #region Top triangles
	
    // Top-left corner
    if (not (_hw < _hullX1 or 0 > _hullX2 or _hh < _hullY1 or 0 > _hullY2)) {
        _cell = [0, 0, _hw, 0, 0, _hh];
        __FRACTURE_CLIP_PIECE;
    }
	
    // Center
    for (var _i = 0; _i < _cols - 1; _i++) {
        var _topX = _hw + _i * _cellW;
        if (_topX + _cellW < _hullX1 or _topX > _hullX2 or _hh < _hullY1 or 0 > _hullY2) continue;
		
        _cell = [_topX, 0, _topX + _cellW, 0, _topX + _hw, _hh];
        __FRACTURE_CLIP_PIECE;
    }
	
    // Top-right corner
    if (not (_w < _hullX1 or _w - _hw > _hullX2 or _hh < _hullY1 or 0 > _hullY2)) {
        _cell = [_w - _hw, 0, _w, 0, _w, _hh];
        __FRACTURE_CLIP_PIECE;
    }
    #endregion
    
    #region Bottom triangles
	
    if (_oddBottom) {
        // Bottom-left corner
        if (not (_hw < _hullX1 or 0 > _hullX2 or _h < _hullY1 or _h - _hh > _hullY2)) {
            _cell = [0, _h - _hh, _hw, _h, 0, _h];
            __FRACTURE_CLIP_PIECE;
        }
		
        // Bottom-right corner
        if (not (_w < _hullX1 or _w - _hw > _hullX2 or _h < _hullY1 or _h - _hh > _hullY2)) {
            _cell = [_w, _h - _hh, _w, _h, _w - _hw, _h];
            __FRACTURE_CLIP_PIECE;
        }
    }
	
    // Bottom center
    var _botN = _cols - (_oddBottom ? 1 : 0);
    var _botXBase = _oddBottom ? _hw : 0;
    for (var _i = 0; _i < _botN; _i++) {
        var _botX = _botXBase + _i * _cellW;
        if (_botX + _cellW < _hullX1 or _botX > _hullX2 or _h < _hullY1 or _h - _hh > _hullY2) continue;
		
        _cell = [_botX, _h, _botX + _hw, _h - _hh, _botX + _cellW, _h];
        __FRACTURE_CLIP_PIECE;
    }
	
    #endregion
    
    _pieceCount = _index;
    array_resize(_pieces, _pieceCount);
    
    __FRACTURE_END;
}
