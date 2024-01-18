params[
    ["_man",      nil, [objNull]],
    ["_building", nil, [objNull]]
];
private _buildingPos = [_building] call SFSM_fnc_buildingCenterPosASL;
private _aimPos      = aimpos _man;
private _canShoot    = [_aimPos, _buildingPos, _man, _building] call SFSM_fnc_isValidRpgFirePos;

_canShoot;