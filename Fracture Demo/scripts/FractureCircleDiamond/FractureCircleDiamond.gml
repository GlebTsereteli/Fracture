// feather ignore all

/// @func FractureCircleDiamond()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// 
/// @desc Fractures the given circle-shaped instance into a diamond pattern clipped to the circle boundary, defined by the number of columns and rows.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureCircleDiamond(_inst, _cols, _rows) {
    __FRACTURE_START;
    __FRACTURE_CIRCLE_HULL;
    
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
    var _ndx = 0, _ndy = 0;
    var _minX = 0, _maxX = 0, _minY = 0, _maxY = 0;
    
    #region Full and half cells
	
    for (var _row = 0; _row < _rows; _row++) {
        var _rowY = (_row + 1) * _hh;
        var _odd = (_row mod 2 == 1);
        var _nCols = _cols - (_odd ? 1 : 0);
        var _xFrom = _odd ? _cellW : _hw;
        
        if (_odd) {
            // Left half-diamond
            _minX = 0; _maxX = _hw; _minY = _rowY - _hh; _maxY = _rowY + _hh;
            if (__FRACTURE_CIRCLE_HIT_BBOX) {
                _cell = [0, _rowY - _hh, _hw, _rowY, 0, _rowY + _hh];
                __FRACTURE_CLIP_PIECE;
            }
			
            // Right half-diamond
            _minX = _w - _hw; _maxX = _w; _minY = _rowY - _hh; _maxY = _rowY + _hh;
            if (__FRACTURE_CIRCLE_HIT_BBOX) {
                _cell = [_w, _rowY - _hh, _w, _rowY + _hh, _w - _hw, _rowY];
                __FRACTURE_CLIP_PIECE;
            }
        }
        
        // Full diamonds
        for (var _col = 0; _col < _nCols; _col++) {
            var _cx = _xFrom + _col * _cellW;
            
            _minX = _cx - _hw; _maxX = _cx + _hw; _minY = _rowY - _hh; _maxY = _rowY + _hh;
			if (__FRACTURE_CIRCLE_HIT_BBOX) {
			    _x1 = _cx; _y1 = _rowY - _hh;
			    _x2 = _cx + _hw; _y2 = _rowY;
			    _x3 = _cx; _y3 = _rowY + _hh;
			    _x4 = _cx - _hw; _y4 = _rowY;
				
			    if ((_x1 - _centerX) * (_x1 - _centerX) + (_y1 - _centerY) * (_y1 - _centerY) <= _radiusSq
			    and (_x2 - _centerX) * (_x2 - _centerX) + (_y2 - _centerY) * (_y2 - _centerY) <= _radiusSq
			    and (_x3 - _centerX) * (_x3 - _centerX) + (_y3 - _centerY) * (_y3 - _centerY) <= _radiusSq
			    and (_x4 - _centerX) * (_x4 - _centerX) + (_y4 - _centerY) * (_y4 - _centerY) <= _radiusSq) {
			        __FRACTURE_GRID_QUAD;
			    }
			    else {
			        _cell = [_x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4];
			        __FRACTURE_CLIP_PIECE;
			    }
			}
        }
    }
    #endregion
    
    #region Top triangles
	
    // Top-left corner
    _minX = 0; _maxX = _hw; _minY = 0; _maxY = _hh;
    if (__FRACTURE_CIRCLE_HIT_BBOX) {
        _cell = [0, 0, _hw, 0, 0, _hh];
        __FRACTURE_CLIP_PIECE;
    }
	
    // Center
    for (var _i = 0; _i < _cols - 1; _i++) {
        var _topX = _hw + _i * _cellW;
        _minX = _topX; _maxX = _topX + _cellW; _minY = 0; _maxY = _hh;
        if (__FRACTURE_CIRCLE_HIT_BBOX) {
            _cell = [_topX, 0, _topX + _cellW, 0, _topX + _hw, _hh];
            __FRACTURE_CLIP_PIECE;
        }
    }
	
    // Top-right corner
    _minX = _w - _hw; _maxX = _w; _minY = 0; _maxY = _hh;
    if (__FRACTURE_CIRCLE_HIT_BBOX) {
        _cell = [_w - _hw, 0, _w, 0, _w, _hh];
        __FRACTURE_CLIP_PIECE;
    }
    #endregion
    
    #region Bottom triangles
	
    if (_oddBottom) {
        // Bottom-left corner
        _minX = 0; _maxX = _hw; _minY = _h - _hh; _maxY = _h;
        if (__FRACTURE_CIRCLE_HIT_BBOX) {
            _cell = [0, _h - _hh, _hw, _h, 0, _h];
            __FRACTURE_CLIP_PIECE;
        }
		
        // Bottom-right corner
        _minX = _w - _hw; _maxX = _w; _minY = _h - _hh; _maxY = _h;
        if (__FRACTURE_CIRCLE_HIT_BBOX) {
            _cell = [_w, _h - _hh, _w, _h, _w - _hw, _h];
            __FRACTURE_CLIP_PIECE;
        }
    }
	
    // Bottom center
    var _botN = _cols - (_oddBottom ? 1 : 0);
    var _botXBase = _oddBottom ? _hw : 0;
    for (var _i = 0; _i < _botN; _i++) {
        var _botX = _botXBase + _i * _cellW;
        _minX = _botX; _maxX = _botX + _cellW; _minY = _h - _hh; _maxY = _h;
        if (__FRACTURE_CIRCLE_HIT_BBOX) {
            _cell = [_botX, _h, _botX + _hw, _h - _hh, _botX + _cellW, _h];
            __FRACTURE_CLIP_PIECE;
        }
    }
	
    #endregion
    
    _pieceCount = _index;
    array_resize(_pieces, _pieceCount);
    
    __FRACTURE_END;
}
