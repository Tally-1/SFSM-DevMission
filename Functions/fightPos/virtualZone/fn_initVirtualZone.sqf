params[
	["_mode",  "", [""]],
	["_input", [], [[]]]
];
_input
params[
	["_module",          objNull,[objNull]], // Module logic
	["_isActivated",     true,      [true]], // True when the module was activated, false when it is deactivated
	["_isCuratorPlaced", false,     [true]]  // True if the module was placed by Zeus
];
private _area            = [_module] call SFSM_fnc_getAzArea;
private _fipos           = entities "SFSM_FIPO" select {_x inArea _area};
private _activationtype  = _module getVariable "activationtype";
private _battleActivated = _activationtype isEqualTo 4;
private _allowedSides    = [];

if(_module getVariable "activatedByEast")        then{_allowedSides pushBack east;};
if(_module getVariable "activatedByWest")        then{_allowedSides pushBack west;};
if(_module getVariable "activatedByIndependent") then{_allowedSides pushBack independent;};

_module setVariable ["SFSM_battleActivated", _battleActivated];
_module setVariable ["SFSM_active",                      true];
_module setVariable ["SFSM_physicalFipos",             _fipos];
_module setVariable ["SFSM_virtualFipos",                  []];
_module setVariable ["SFSM_allowedSides",       _allowedSides];

// [_module] call SFSM_fnc_virtualize;