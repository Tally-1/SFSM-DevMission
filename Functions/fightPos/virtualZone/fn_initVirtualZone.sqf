params[
    ["_module", objNull, [objNull]]
];
private _area            = [_module] call SFSM_fnc_getAzArea;
private _fipos           = entities "SFSM_FIPO" select {_x inArea _area};
private _activationtype  = _module getVariable "activationtype";
private _battleActivated = _activationtype isEqualTo 4;
private _allowedSides    = [];

if(_module getVariable "activatedByEast")        then{_allowedSides pushBack east;};
if(_module getVariable "activatedByWest")        then{_allowedSides pushBack west;};
if(_module getVariable "activatedByIndependent") then{_allowedSides pushBack independent;};

private _dataArr = [
	["module",                           _module],
    ["area",                               _area],
	["activatedByBattle",       _battleActivated],
    ["activationtype",           _activationtype],
	["active",                              true],
	["physicalFipos",                     _fipos],
	["virtualFipos",                          []],
	["allowedSides",               _allowedSides],
    ["canActivate",       SFSM_fnc_canActivateVz],
    ["activate",       SFSM_fnc_unVirtualizeZone],
    ["canDeActivate",   SFSM_fnc_canDeActivateVz],
    ["deActivate",       SFSM_fnc_virtualizeZone],
    ["toggleZone",             SFSM_fnc_toggleVz],
    ["conditionsTrue", SFSM_fnc_VZconditionsTrue],
    ["canBattleInit",   SFSM_fnc_canBattleInitVz]
];

private _data = createHashmapObject [_dataArr];

_module setVariable ["SFSM_vzData", _data];

true;