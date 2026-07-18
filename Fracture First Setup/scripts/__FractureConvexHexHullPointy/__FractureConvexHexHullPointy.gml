// feather ignore all

/// @ignore
function __FractureConvexHexHullPointy(_inst, _cols, _rows) {
    __FRACTURE_START;
    __FRACTURE_CONVEX_HULL;
    
    _cols = round(_cols);
    _rows = round(_rows);
    
    var _ch = _h / ((0.75 * _rows) + 0.25);
    var _rowSpacing = _ch * 0.75;
    var _hh = _ch / 2;
    var _qh = _ch / 4;
    var _cw = _w / _cols;
    var _hw = _cw / 2;
    
    var _nOddRows = _rows div 2;
    var _oddRows = ((_rows mod 2) != 0);
    var _pieceCount = _rows * _cols + _nOddRows + 2 * _cols + 1 + _oddRows;
    var _pieces = array_create(_pieceCount);
    var _index = 0;
    
    var _xl = 0, _yt = 0;
    var _minX = 0, _maxX = 0, _minY = 0, _maxY = 0;
    
    #region Full cells and half cells
    
    for (var _row = 0; _row < _rows; _row++) {
        var _ry = _hh + (_row * _rowSpacing);
        var _odd = ((_row mod 2) == 1);
        var _nCols = _cols - _odd;
        var _xFrom = _odd ? _cw : _hw;
        
        if (_odd) {
            _yt = _ry - _hh;
            
            // Left half-cell
            _minX = 0; _maxX = _hw; _minY = _yt; _maxY = _yt + _ch;
            if (__FRACTURE_CONVEX_HIT_BBOX) {
                _cell = [0, _yt, _hw, _yt + _qh, _hw, _yt + _ch - _qh, 0, _yt + _ch];
                __FRACTURE_CLIP_PIECE;
            }
            
            // Right half-cell
            _minX = _w - _hw; _maxX = _w; _minY = _yt; _maxY = _yt + _ch;
            if (__FRACTURE_CONVEX_HIT_BBOX) {
                _cell = [_w - _hw, _yt + _qh, _w, _yt, _w, _yt + _ch, _w - _hw, _yt + _ch - _qh];
                __FRACTURE_CLIP_PIECE;
            }
        }
        
        // Full cells
        for (var _col = 0; _col < _nCols; _col++) {
            var _rx = _xFrom + (_col * _cw);
            _xl = _rx - _hw;
            _yt = _ry - _hh;
            _minX = _xl; _maxX = _xl + _cw; _minY = _yt; _maxY = _yt + _ch;
            
            if (__FRACTURE_CONVEX_HIT_BBOX) {
                _cell = [
                    _xl + _hw, _yt,
                    _xl + _cw, _yt + _qh,
                    _xl + _cw, _yt + _ch - _qh,
                    _xl + _hw, _yt + _ch,
                    _xl, _yt + _ch - _qh,
                    _xl, _yt + _qh
                ];
                __FRACTURE_CLIP_PIECE;
            }
        }
    }
    
    #endregion
    #region Top triangles
    
    // Top-left corner
    _minX = 0; _maxX = _hw; _minY = 0; _maxY = _qh;
    if (__FRACTURE_CONVEX_HIT_BBOX) {
        _cell = [0, 0, _hw, 0, 0, _qh];
        __FRACTURE_CLIP_PIECE;
    }
    
    // Center
    var _x = _hw;
    repeat (_cols - 1) {
        _minX = _x; _maxX = _x + _cw; _minY = 0; _maxY = _qh;
        if (__FRACTURE_CONVEX_HIT_BBOX) {
            _cell = [_x, 0, _x + _cw, 0, _x + _hw, _qh];
            __FRACTURE_CLIP_PIECE;
        }
        _x += _cw;
    }
    
    // Top-right corner
    _minX = _w - _hw; _maxX = _w; _minY = 0; _maxY = _qh;
    if (__FRACTURE_CONVEX_HIT_BBOX) {
        _cell = [_w - _hw, 0, _w, 0, _w, _qh];
        __FRACTURE_CLIP_PIECE;
    }
    
    #endregion
    #region Bottom triangles
    
    if (_oddRows) {
        // Bottom-left corner
        _minX = 0; _maxX = _hw; _minY = _h - _qh; _maxY = _h;
        if (__FRACTURE_CONVEX_HIT_BBOX) {
            _cell = [0, _h - _qh, _hw, _h, 0, _h];
            __FRACTURE_CLIP_PIECE;
        }
    }
    
    // Center
    _x = _hw * _oddRows;
    repeat (_cols - _oddRows) {
        _minX = _x; _maxX = _x + _cw; _minY = _h - _qh; _maxY = _h;
        if (__FRACTURE_CONVEX_HIT_BBOX) {
            _cell = [_x, _h, _x + _hw, _h - _qh, _x + _cw, _h];
            __FRACTURE_CLIP_PIECE;
        }
        _x += _cw;
    }
    
    if (_oddRows) {
        // Bottom-right corner
        _minX = _w - _hw; _maxX = _w; _minY = _h - _qh; _maxY = _h;
        if (__FRACTURE_CONVEX_HIT_BBOX) {
            _cell = [_w - _hw, _h, _w, _h - _qh, _w, _h];
            __FRACTURE_CLIP_PIECE;
        }
    }
    
    #endregion
    
    _pieceCount = _index;
    array_resize(_pieces, _pieceCount);
    
    __FRACTURE_END;
}
