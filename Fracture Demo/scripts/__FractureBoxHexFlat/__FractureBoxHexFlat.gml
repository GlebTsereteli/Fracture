// feather ignore all

function __FractureBoxHexFlat(_inst, _cols, _rows) {
    __FRACTURE_START;
	
    _cols = round(_cols);
    _rows = round(_rows);
	
    var _cw = _w / ((0.75 * _cols) + 0.25);
    var _colSpacing = _cw * 0.75;
    var _hw = _cw * 0.5;
    var _qw = _cw * 0.25;
    var _ch = _h / _rows;
    var _hh = _ch * 0.5;
	
    var _nOddCols = _cols div 2;
    var _oddCols = ((_cols mod 2) != 0);
    var _bodyCount = _cols * _rows + _nOddCols + 2 * _rows + 1 + _oddCols;
    var _bodies = array_create(_bodyCount);
    var _index = 0;
    var _vertexOffset = 0;
	var _px, _py, _ax, _ay, _bx, _by, _cx, _cy, _dx, _dy, _ex, _ey, _gx, _gy;
	
    #region Full cells and half cells
	
    for (var _col = 0; _col < _cols; _col++) {
        var _cx2 = _hw + (_col * _colSpacing);
        var _odd = ((_col mod 2) == 1);
        var _nRows = _rows - _odd;
        var _yFrom = _odd ? _ch : _hh;
		
        if (_odd) {
            // Top half-cell
            var _xl = _cx2 - _hw;
            var _yt = 0;
            _ax = 0; _ay = 0;
            _bx = _cw; _by = 0;
            _cx = _hw + _qw; _cy = _hh;
            _dx = _hw - _qw; _dy = _hh;
            __FRACTURE_BOX_QUAD;
			
            // Bottom half-cell
            _yt = _h - _hh;
            _ax = _hw - _qw; _ay = 0;
            _bx = _hw + _qw; _by = 0;
            _cx = _cw; _cy = _hh;
            _dx = 0; _dy = _hh;
            __FRACTURE_BOX_QUAD;
        }
		
        // Full cells
        for (var _row = 0; _row < _nRows; _row++) {
            var _cy2 = _yFrom + (_row * _ch);
            var _xl = _cx2 - _hw;
            var _yt = _cy2 - _hh;
			_ax = _hw - _qw; _ay = 0;
            _bx = _hw + _qw; _by = 0;
            _cx = _cw; _cy = _hh;
            _dx = _hw + _qw; _dy = _ch;
            _ex = _hw - _qw; _ey = _ch;
            _gx = 0; _gy = _hh;
            __FRACTURE_BOX_HEX;
        }
    }
	
    #endregion
    #region Left triangles
	
    var _xl = 0;
	
    // Top-left corner
    var _yt = 0;
    _ax = 0; _ay = 0;
    _bx = _qw; _by = 0;
    _cx = 0; _cy = _hh;
    __FRACTURE_BOX_TRI;
	
    // Center
    var _y = _hh;
    repeat (_rows - 1) {
        _yt = _y;
        _ax = 0; _ay = 0;
        _bx = _qw; _by = _hh;
        _cx = 0; _cy = _ch;
        __FRACTURE_BOX_TRI;
        _y += _ch;
    }
	
    // Bottom-left corner
    _yt = _h - _hh;
    _ax = 0; _ay = 0;
    _bx = _qw; _by = _hh;
    _cx = 0; _cy = _hh;
    __FRACTURE_BOX_TRI;
	
    #endregion
    #region Right triangles
	
    _xl = _w - _qw;
	
    if (_oddCols) {
        // Top-right corner
        _yt = 0;
        _ax = 0; _ay = 0;
        _bx = _qw; _by = 0;
        _cx = _qw; _cy = _hh;
        __FRACTURE_BOX_TRI;
    }
	
    // Center
    _y = _hh * _oddCols;
    repeat (_rows - _oddCols) {
        _yt = _y;
        _ax = _qw; _ay = 0;
        _bx = _qw; _by = _ch;
        _cx = 0; _cy = _hh;
        __FRACTURE_BOX_TRI;
        _y += _ch;
    }
	
    if (_oddCols) {
        // Bottom-right corner
        _yt = _h - _hh;
        _ax = _qw; _ay = 0;
        _bx = _qw; _by = _hh;
        _cx = 0; _cy = _hh;
        __FRACTURE_BOX_TRI;
    }
	
    #endregion
	
    __FRACTURE_END;
}
