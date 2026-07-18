// feather ignore all

/// @ignore
function __FractureConvexHexCirclePointy(_inst, _cols, _rows) {
    __FRACTURE_START;
    __FRACTURE_CIRCLE_HULL;
    
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
    
    var _px = 0, _py = 0;
    var _ax = 0, _ay = 0, _bx = 0, _by = 0;
    var _cx = 0, _cy = 0, _dx = 0, _dy = 0;
    var _ex = 0, _ey = 0, _gx = 0, _gy = 0;
    var _xl = 0, _yt = 0;
    var _ndx = 0, _ndy = 0;
    var _minX = 0, _maxX = 0, _minY = 0, _maxY = 0;
    var _cell = [];
    
    #region Full cells and half cells
    
    for (var _row = 0; _row < _rows; _row++) {
        var _ry = _hh + (_row * _rowSpacing);
        var _odd = ((_row mod 2) == 1);
        var _nCols = _cols - _odd;
        var _xFrom = _odd ? _cw : _hw;
        
        if (_odd) {
            _yt = _ry - _hh;
            
            // Left half-cell
            _xl = 0;
            _minX = 0; _maxX = _hw; _minY = _yt; _maxY = _yt + _ch;
            if (__FRACTURE_CIRCLE_HIT_BBOX) {
                _ax = 0; _ay = 0;
                _bx = _hw; _by = _qh;
                _cx = _hw; _cy = _ch - _qh;
                _dx = 0; _dy = _ch;
                var _w1x = 0, _w1y = _yt;
                var _w2x = _hw, _w2y = _yt + _qh;
                var _w3x = _hw, _w3y = _yt + _ch - _qh;
                var _w4x = 0, _w4y = _yt + _ch;
                if ((_w1x - _centerX) * (_w1x - _centerX) + (_w1y - _centerY) * (_w1y - _centerY) <= _radiusSq
                and (_w2x - _centerX) * (_w2x - _centerX) + (_w2y - _centerY) * (_w2y - _centerY) <= _radiusSq
                and (_w3x - _centerX) * (_w3x - _centerX) + (_w3y - _centerY) * (_w3y - _centerY) <= _radiusSq
                and (_w4x - _centerX) * (_w4x - _centerX) + (_w4y - _centerY) * (_w4y - _centerY) <= _radiusSq) {
                    __FRACTURE_BOX_QUAD;
                }
                else {
                    _cell = [_w1x, _w1y, _w2x, _w2y, _w3x, _w3y, _w4x, _w4y];
                    __FRACTURE_CLIP_PIECE;
                }
            }
            
            // Right half-cell
            _xl = _w - _hw;
            _minX = _w - _hw; _maxX = _w; _minY = _yt; _maxY = _yt + _ch;
            if (__FRACTURE_CIRCLE_HIT_BBOX) {
                _ax = 0; _ay = _qh;
                _bx = _hw; _by = 0;
                _cx = _hw; _cy = _ch;
                _dx = 0; _dy = _ch - _qh;
                _w1x = _w - _hw; _w1y = _yt + _qh;
                _w2x = _w; _w2y = _yt;
                _w3x = _w; _w3y = _yt + _ch;
                _w4x = _w - _hw; _w4y = _yt + _ch - _qh;
                if ((_w1x - _centerX) * (_w1x - _centerX) + (_w1y - _centerY) * (_w1y - _centerY) <= _radiusSq
                and (_w2x - _centerX) * (_w2x - _centerX) + (_w2y - _centerY) * (_w2y - _centerY) <= _radiusSq
                and (_w3x - _centerX) * (_w3x - _centerX) + (_w3y - _centerY) * (_w3y - _centerY) <= _radiusSq
                and (_w4x - _centerX) * (_w4x - _centerX) + (_w4y - _centerY) * (_w4y - _centerY) <= _radiusSq) {
                    __FRACTURE_BOX_QUAD;
                }
                else {
                    _cell = [_w1x, _w1y, _w2x, _w2y, _w3x, _w3y, _w4x, _w4y];
                    __FRACTURE_CLIP_PIECE;
                }
            }
        }
        
        // Full cells
        for (var _col = 0; _col < _nCols; _col++) {
            var _rx = _xFrom + (_col * _cw);
            _xl = _rx - _hw;
            _yt = _ry - _hh;
            _minX = _xl; _maxX = _xl + _cw; _minY = _yt; _maxY = _yt + _ch;
            
            if (__FRACTURE_CIRCLE_HIT_BBOX) {
                _ax = _hw; _ay = 0;
                _bx = _cw; _by = _qh;
                _cx = _cw; _cy = _ch - _qh;
                _dx = _hw; _dy = _ch;
                _ex = 0; _ey = _ch - _qh;
                _gx = 0; _gy = _qh;
                var _w1x = _xl + _hw, _w1y = _yt;
                var _w2x = _xl + _cw, _w2y = _yt + _qh;
                var _w3x = _xl + _cw, _w3y = _yt + _ch - _qh;
                var _w4x = _xl + _hw, _w4y = _yt + _ch;
                var _w5x = _xl, _w5y = _yt + _ch - _qh;
                var _w6x = _xl, _w6y = _yt + _qh;
                if ((_w1x - _centerX) * (_w1x - _centerX) + (_w1y - _centerY) * (_w1y - _centerY) <= _radiusSq
                and (_w2x - _centerX) * (_w2x - _centerX) + (_w2y - _centerY) * (_w2y - _centerY) <= _radiusSq
                and (_w3x - _centerX) * (_w3x - _centerX) + (_w3y - _centerY) * (_w3y - _centerY) <= _radiusSq
                and (_w4x - _centerX) * (_w4x - _centerX) + (_w4y - _centerY) * (_w4y - _centerY) <= _radiusSq
                and (_w5x - _centerX) * (_w5x - _centerX) + (_w5y - _centerY) * (_w5y - _centerY) <= _radiusSq
                and (_w6x - _centerX) * (_w6x - _centerX) + (_w6y - _centerY) * (_w6y - _centerY) <= _radiusSq) {
                    __FRACTURE_BOX_HEX;
                }
                else {
                    _cell = [_w1x, _w1y, _w2x, _w2y, _w3x, _w3y, _w4x, _w4y, _w5x, _w5y, _w6x, _w6y];
                    __FRACTURE_CLIP_PIECE;
                }
            }
        }
    }
    
    #endregion
    #region Top triangles
    
    _yt = 0;
    
    // Top-left corner
    _xl = 0;
    _minX = 0; _maxX = _hw; _minY = 0; _maxY = _qh;
    if (__FRACTURE_CIRCLE_HIT_BBOX) {
        _cell = [0, 0, _hw, 0, 0, _qh];
        __FRACTURE_CLIP_PIECE;
    }
    
    // Center
    var _x = _hw;
    repeat (_cols - 1) {
        _xl = _x;
        _minX = _x; _maxX = _x + _cw; _minY = 0; _maxY = _qh;
        if (__FRACTURE_CIRCLE_HIT_BBOX) {
            _cell = [_x, 0, _x + _cw, 0, _x + _hw, _qh];
            __FRACTURE_CLIP_PIECE;
        }
        _x += _cw;
    }
    
    // Top-right corner
    _xl = _w - _hw;
    _minX = _w - _hw; _maxX = _w; _minY = 0; _maxY = _qh;
    if (__FRACTURE_CIRCLE_HIT_BBOX) {
        _cell = [_w - _hw, 0, _w, 0, _w, _qh];
        __FRACTURE_CLIP_PIECE;
    }
    
    #endregion
    #region Bottom triangles
    
    _yt = _h - _qh;
    
    if (_oddRows) {
        // Bottom-left corner
        _xl = 0;
        _minX = 0; _maxX = _hw; _minY = _h - _qh; _maxY = _h;
        if (__FRACTURE_CIRCLE_HIT_BBOX) {
            _cell = [0, _h - _qh, _hw, _h, 0, _h];
            __FRACTURE_CLIP_PIECE;
        }
    }
    
    // Center
    _x = _hw * _oddRows;
    repeat (_cols - _oddRows) {
        _xl = _x;
        _minX = _x; _maxX = _x + _cw; _minY = _h - _qh; _maxY = _h;
        if (__FRACTURE_CIRCLE_HIT_BBOX) {
            _cell = [_x, _h, _x + _hw, _h - _qh, _x + _cw, _h];
            __FRACTURE_CLIP_PIECE;
        }
        _x += _cw;
    }
    
    if (_oddRows) {
        // Bottom-right corner
        _xl = _w - _hw;
        _minX = _w - _hw; _maxX = _w; _minY = _h - _qh; _maxY = _h;
        if (__FRACTURE_CIRCLE_HIT_BBOX) {
            _cell = [_w - _hw, _h, _w, _h - _qh, _w, _h];
            __FRACTURE_CLIP_PIECE;
        }
    }
    
    #endregion
    
    _pieceCount = _index;
    array_resize(_pieces, _pieceCount);
    
    __FRACTURE_END;
}
