// feather ignore all

/// @ignore
function __FractureConvexHexHull(_inst, _cols, _rows, _flat = true) {
    var _func = _flat ? __FractureConvexHexHullFlat : __FractureConvexHexHullPointy;
    return _func(_inst, _cols, _rows);
}
