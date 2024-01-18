params[
    ["_man",          nil,     [objNull]],
    ["_building",    objNull, [objNull]]
];

// Return current position if the RPG guy can shoot from there.
if([_man, _building] call SFSM_fnc_atValidRpgFirePos)exitWith{getPosATLVisual _man;};

_launchPos = [_man, _building] call SFSM_fnc_firePosLite;

_launchPos;