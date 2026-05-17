// feather ignore all

/// @func FractureDiamondBox()
/// 
/// @param {Id.Instance} inst The instance to fracture.
/// @param {Real} cols The number of columns.
/// @param {Real} rows The number of rows.
/// 
/// @desc Fractures the given rectangle-shaped instance into a diamond pattern filling the full sprite area, defined by the number of columns and rows.
/// The instance is destroyed automatically after fracturing.
/// Returns an array of the created Piece instances.
/// 
/// @return {Array<Id.Instance of __objFracturePiece>}
function FractureDiamondBox(_inst, _cols, _rows) {
    __FRACTURE_START;
	
    _cols = round(_cols);
    _rows = round(_rows);
	
    var _cellW = _w / _cols;
    var _hw = _cellW / 2;
    var _cellH = 2 * _h / (_rows + 1);
    var _hh = _cellH * 0.5;
	
    var _nOddRows = _rows div 2;
    var _oddBottom = (_rows mod 2 != 0);
    var _pieceCount = _rows * _cols + _nOddRows + 2 * _cols + 1 + (_oddBottom ? 1 : 0);
    var _pieces = array_create(_pieceCount);
	
    var _index = 0;
    var _ax = 0, _ay = 0;
    var _bx = 0, _by = 0;
    var _cx = 0, _cy = 0;
    var _dx = 0, _dy = 0;
	
    #region Full and half cells
	
    for (var _row = 0; _row < _rows; _row++) {
        var _rowY = (_row + 1) * _hh;
        var _odd = (_row mod 2 == 1);
        var _nCols = _cols - _odd;
        var _xFrom = _odd ? _cellW : _hw;
		
        if (_odd) {
            // Left half-diamond
            var _xl = 0;
            var _yt = _rowY - _hh;
            _ax = 0; _ay = 0;
            _bx = _hw; _by = _hh;
            _cx = 0; _cy = _cellH;
            __FRACTURE_BOX_TRI;
			
            // Right half-diamond
            _xl = _w - _hw;
            _ax = _hw; _ay = 0;
            _bx = _hw; _by = _cellH;
            _cx = 0; _cy = _hh;
            __FRACTURE_BOX_TRI;
        }
		
        // Full diamonds
        for (var _col = 0; _col < _nCols; _col++) {
            var _dcx = _xFrom + _col * _cellW;
            var _xl = _dcx - _hw;
            var _yt = _rowY - _hh;
            _ax = _hw; _ay = 0;
            _bx = _cellW; _by = _hh;
            _cx = _hw; _cy = _cellH;
            _dx = 0; _dy = _hh;
            __FRACTURE_BOX_QUAD;
        }
    }
	
    #endregion
    #region Top triangles
	
    var _xl = 0;
    var _yt = 0;
	
    // Top-left corner
    _ax = 0; _ay = 0;
    _bx = _hw; _by = 0;
    _cx = 0; _cy = _hh;
    __FRACTURE_BOX_TRI;
	
    // Center
    var _topX = _hw;
    repeat (_cols - 1) {
        _xl = _topX;
        _ax = 0; _ay = 0;
        _bx = _cellW; _by = 0;
        _cx = _hw; _cy = _hh;
        __FRACTURE_BOX_TRI;
        _topX += _cellW;
    }
	
    // Top-right corner
    _xl = _w - _hw;
    _ax = 0; _ay = 0;
    _bx = _hw; _by = 0;
    _cx = _hw; _cy = _hh;
    __FRACTURE_BOX_TRI;
	
    #endregion
    #region Bottom triangles
	
    if (_oddBottom) {
        // Bottom-left corner
        _xl = 0;
        _yt = _h - _hh;
        _ax = 0; _ay = 0;
        _bx = _hw; _by = _hh;
        _cx = 0; _cy = _hh;
        __FRACTURE_BOX_TRI;
		
        // Bottom-right corner
        _xl = _w - _hw;
        _ax = _hw; _ay = 0;
        _bx = _hw; _by = _hh;
        _cx = 0; _cy = _hh;
        __FRACTURE_BOX_TRI;
    }
	
    // Bottom center
    var _botX = _oddBottom ? _hw : 0;
    var _nBot = _cols - (_oddBottom ? 1 : 0);
    repeat (_nBot) {
        _xl = _botX;
        _yt = _h - _hh;
        _ax = 0; _ay = _hh;
        _bx = _hw; _by = 0;
        _cx = _cellW; _cy = _hh;
        __FRACTURE_BOX_TRI;
        _botX += _cellW;
    }
	
    #endregion
	
    __FRACTURE_END;
}
