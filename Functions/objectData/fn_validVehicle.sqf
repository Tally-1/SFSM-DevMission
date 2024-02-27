params [
	["_vehicle", nil, [objNull]]
];
if (_vehicle isKindOf "man")                exitWith{false;};
if!(_vehicle isKindOf "land")               exitWith{false;};
if ([_vehicle] call Tcore_fnc_deadCrew)     exitWith{false;};

private _validSide = side _vehicle in [east, west, independent];
if!(_validSide)exitWith{false;};

true;