// feather ignore all

function FractureBoxHex(_inst, _cols, _rows, _pointy) {
	var _func = _pointy ? __FractureBoxHexPointy : __FractureBoxHexFlat;
	return _func(_inst, _cols, _rows);
}
