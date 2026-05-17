// feather ignore all

function __FractureBoxHexPointy(_inst, _cols, _rows) {
    __FRACTURE_START;
	
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
    var _px, _py, _ax, _ay, _bx, _by, _cx, _cy, _dx, _dy, _ex, _ey, _gx, _gy;
	
    #region Full cells and half cells
	
    for (var _row = 0; _row < _rows; _row++) {
        var _ry = _hh + (_row * _rowSpacing);
        var _odd = ((_row mod 2) == 1);
        var _nCols = _cols - _odd;
        var _xFrom = _odd ? _cw : _hw;
		
        if (_odd) {
            // Left half-cell
            var _xl = 0;
            var _yt = _ry - _hh;
            _ax = 0; _ay = 0;
            _bx = _hw; _by = _qh;
            _cx = _hw; _cy = _ch - _qh;
            _dx = 0; _dy = _ch;
            __FRACTURE_BOX_QUAD;
			
            // Right half-cell
            _xl = _w - _hw;
            _ax = 0; _ay = _qh;
            _bx = _hw; _by = 0;
            _cx = _hw; _cy = _ch;
            _dx = 0; _dy = _ch - _qh;
            __FRACTURE_BOX_QUAD;
        }
		
        // Full cells
        for (var _col = 0; _col < _nCols; _col++) {
            var _rx = _xFrom + (_col * _cw);
            var _xl = _rx - _hw;
            var _yt = _ry - _hh;
            _ax = _hw; _ay = 0;
            _bx = _cw; _by = _qh;
            _cx = _cw; _cy = _ch - _qh;
            _dx = _hw; _dy = _ch;
            _ex = 0; _ey = _ch - _qh;
            _gx = 0; _gy = _qh;
            __FRACTURE_BOX_HEX;
        }
    }
	
    #endregion
    #region Top triangles
	
    var _yt = 0;
	
    // Top-left corner
    var _xl = 0;
    _ax = 0; _ay = 0;
    _bx = _hw; _by = 0;
    _cx = 0; _cy = _qh;
    __FRACTURE_BOX_TRI;
	
    // Center
    var _x = _hw;
    repeat (_cols - 1) {
        _xl = _x;
        _ax = 0; _ay = 0;
        _bx = _cw; _by = 0;
        _cx = _hw; _cy = _qh;
        __FRACTURE_BOX_TRI;
        _x += _cw;
    }
	
    // Top-right corner
    _xl = _w - _hw;
    _ax = 0; _ay = 0;
    _bx = _hw; _by = 0;
    _cx = _hw; _cy = _qh;
    __FRACTURE_BOX_TRI;
	
    #endregion
    #region Bottom triangles
	
    _yt = _h - _qh;
	
    if (_oddRows) {
        // Bottom-left corner
        _xl = 0;
        _ax = 0; _ay = 0;
        _bx = _hw; _by = _qh;
        _cx = 0; _cy = _qh;
        __FRACTURE_BOX_TRI;
    }
	
    // Center
    _x = _hw * _oddRows;
    repeat (_cols - _oddRows) {
        _xl = _x;
        _ax = 0; _ay = _qh;
        _bx = _hw; _by = 0;
        _cx = _cw; _cy = _qh;
        __FRACTURE_BOX_TRI;
        _x += _cw;
    }
	
    if (_oddRows) {
        // Bottom-right corner
        _xl = _w - _hw;
        _ax = 0; _ay = _qh;
        _bx = _hw; _by = 0;
        _cx = _hw; _cy = _qh;
        __FRACTURE_BOX_TRI;
    }
	
    #endregion
	
    __FRACTURE_END;
}
