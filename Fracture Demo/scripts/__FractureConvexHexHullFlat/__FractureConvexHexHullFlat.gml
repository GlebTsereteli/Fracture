// feather ignore all

/// @ignore
function __FractureConvexHexFlat(_inst, _cols, _rows) {
    __FRACTURE_START;
    __FRACTURE_CONVEX_HULL;
    
    _cols = round(_cols);
    _rows = round(_rows);
    
    var _cw = _w / ((0.75 * _cols) + 0.25);
    var _colSpacing = _cw * 0.75;
    var _hw = _cw / 2;
    var _qw = _cw / 4;
    var _ch = _h / _rows;
    var _hh = _ch / 2;
    
    var _nOddCols = _cols div 2;
    var _oddCols = ((_cols mod 2) != 0);
    var _pieceCount = _cols * _rows + _nOddCols + 2 * _rows + 1 + _oddCols;
    var _pieces = array_create(_pieceCount);
    var _index = 0;
    
    var _xl = 0, _yt = 0;
    var _minX = 0, _maxX = 0, _minY = 0, _maxY = 0;
    
    #region Full cells and half cells
    
    for (var _col = 0; _col < _cols; _col++) {
        var _cx2 = _hw + (_col * _colSpacing);
        var _odd = ((_col mod 2) == 1);
        var _nRows = _rows - _odd;
        var _yFrom = _odd ? _ch : _hh;
        
        if (_odd) {
            _xl = _cx2 - _hw;
            
            // Top half-cell
            _minX = _xl; _maxX = _xl + _cw; _minY = 0; _maxY = _hh;
            if (__FRACTURE_CONVEX_HIT_BBOX) {
                _cell = [_xl, 0, _xl + _cw, 0, _xl + _hw + _qw, _hh, _xl + _hw - _qw, _hh];
                __FRACTURE_CLIP_PIECE;
            }
            
            // Bottom half-cell
            _minX = _xl; _maxX = _xl + _cw; _minY = _h - _hh; _maxY = _h;
            if (__FRACTURE_CONVEX_HIT_BBOX) {
                _cell = [_xl + _hw - _qw, _h - _hh, _xl + _hw + _qw, _h - _hh, _xl + _cw, _h, _xl, _h];
                __FRACTURE_CLIP_PIECE;
            }
        }
        
        // Full cells
        for (var _row = 0; _row < _nRows; _row++) {
            var _cy2 = _yFrom + (_row * _ch);
            _xl = _cx2 - _hw;
            _yt = _cy2 - _hh;
            _minX = _xl; _maxX = _xl + _cw; _minY = _yt; _maxY = _yt + _ch;
            
            if (__FRACTURE_CONVEX_HIT_BBOX) {
                _cell = [
                    _xl + _hw - _qw, _yt,
                    _xl + _hw + _qw, _yt,
                    _xl + _cw, _yt + _hh,
                    _xl + _hw + _qw, _yt + _ch,
                    _xl + _hw - _qw, _yt + _ch,
                    _xl, _yt + _hh
                ];
                __FRACTURE_CLIP_PIECE;
            }
        }
    }
    
    #endregion
    #region Left triangles
    
    // Top-left corner
    _minX = 0; _maxX = _qw; _minY = 0; _maxY = _hh;
    if (__FRACTURE_CONVEX_HIT_BBOX) {
        _cell = [0, 0, _qw, 0, 0, _hh];
        __FRACTURE_CLIP_PIECE;
    }
    
    // Center
    var _y = _hh;
    repeat (_rows - 1) {
        _minX = 0; _maxX = _qw; _minY = _y; _maxY = _y + _ch;
        if (__FRACTURE_CONVEX_HIT_BBOX) {
            _cell = [0, _y, _qw, _y + _hh, 0, _y + _ch];
            __FRACTURE_CLIP_PIECE;
        }
        _y += _ch;
    }
    
    // Bottom-left corner
    _minX = 0; _maxX = _qw; _minY = _h - _hh; _maxY = _h;
    if (__FRACTURE_CONVEX_HIT_BBOX) {
        _cell = [0, _h - _hh, _qw, _h, 0, _h];
        __FRACTURE_CLIP_PIECE;
    }
    
    #endregion
    #region Right triangles
    
    if (_oddCols) {
        // Top-right corner
        _minX = _w - _qw; _maxX = _w; _minY = 0; _maxY = _hh;
        if (__FRACTURE_CONVEX_HIT_BBOX) {
            _cell = [_w - _qw, 0, _w, 0, _w, _hh];
            __FRACTURE_CLIP_PIECE;
        }
    }
    
    // Center
    _y = _oddCols ? _hh : 0;
    repeat (_rows - (_oddCols ? 1 : 0)) {
        _minX = _w - _qw; _maxX = _w; _minY = _y; _maxY = _y + _ch;
        if (__FRACTURE_CONVEX_HIT_BBOX) {
            _cell = [_w, _y, _w, _y + _ch, _w - _qw, _y + _hh];
            __FRACTURE_CLIP_PIECE;
        }
        _y += _ch;
    }
    
    if (_oddCols) {
        // Bottom-right corner
        _minX = _w - _qw; _maxX = _w; _minY = _h - _hh; _maxY = _h;
        if (__FRACTURE_CONVEX_HIT_BBOX) {
            _cell = [_w, _h - _hh, _w, _h, _w - _qw, _h];
            __FRACTURE_CLIP_PIECE;
        }
    }
    
    #endregion
    
    _pieceCount = _index;
    array_resize(_pieces, _pieceCount);
    
    __FRACTURE_END;
}
