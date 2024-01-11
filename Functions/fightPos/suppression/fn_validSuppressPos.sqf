params[
	["_man",         nil, [objNull]],
	["_suppressPos", nil,      [[]]]
];
private _barrelPos  = ([_man, 5] call SFSM_fnc_weaponAimPos)#0;
private _startPos   = _barrelPos; // aimPos _man;
private _midPos     = [_startPos, _suppressPos, 5] call SFSM_fnc_posOnVector;
private _linebreaks = lineIntersectsSurfaces [_startPos, _midPos, _man, objNull, true, 3];

_linebreaks = _linebreaks select {(_x#3) isKindOf "man" isEqualTo false;};

private _validSuppressPos = _linebreaks isEqualTo [];

_validSuppressPos;