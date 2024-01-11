params[
    ["_mapName",  nil, [""]],
    ["_animList", nil, [[]]]
];

private _dataArr = [
    ["name",       _mapName],
    ["animations", _animList],
    ["getPath",    SFSM_fnc_attackAnimPath],
    ["clearPath",  SFSM_fnc_attackPathClear]
];

private _attackAnimData = createHashmapObject [_dataArr];

_attackAnimData;