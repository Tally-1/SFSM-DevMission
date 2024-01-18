params[
    ["_man",       nil, [objNull]],
    ["_building",  nil, [objNull]]
];

private _targetPosASL = [_building] call SFSM_fnc_buildingCenterPosASL;
private _targetPosATL = ASLToATL _targetPosASL;
private _dir          = _man getDir _building;

_man setDir _dir;

[_man, _targetPosATL] spawn SFSM_fnc_forceLookAtPos;

["CQB_rpgFire", [_man, _building]] call CBA_fnc_localEvent;

_man setVariable ["SFSM_missileTarget", _targetPosASL];

[_man, nil, _dir] call SFSM_fnc_forceFireLauncher;
[_man, true]      call SFSM_fnc_endRpgHouse;

true;