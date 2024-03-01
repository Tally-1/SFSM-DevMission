params[
	["_fipo", nil, [objNull]]
];

_fipo setvariable ["BIS_fnc_initModules_disableAutoActivation",false,true];

[_fipo] call BIS_fnc_initModules;
[_fipo] call SFSM_fnc_initFipo;

SFSM_fipositions pushBackUnique _fipo;
SFSM_allFipos    pushBackUnique _fipo;

true;