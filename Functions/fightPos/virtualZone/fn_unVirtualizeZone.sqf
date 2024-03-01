params[
	["_module", nil, [objNull]]
];

private _fipoDataArr = _module getVariable "SFSM_virtualFipos";
private _fipos       = [];

{
	private _fipo = [_x] call SFSM_fnc_spawnVzFipo;
	_fipos pushBackUnique _fipo;

} forEach _fipoDataArr;

_module setVariable ["SFSM_virtualFipos",        []];
_module setVariable ["SFSM_physicalFipos",   _fipos];
_module setVariable ["SFSM_active",            true];

true;