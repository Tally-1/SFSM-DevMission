params[
    ["_firePosASL",   nil,          [[]]],
    ["_targetPosASL", nil,          [[]]],
    ["_shooter",      nil,     [objNull]],
    ["_targetObj",    objNull, [objNull]]
];


private _valid = ([_shooter, "VIEW", _targetObj] checkVisibility [_firePosASL, _targetPosASL])>0.8;
// private _building = [_man] call SFSM_fnc_currentBuilding;

_valid;