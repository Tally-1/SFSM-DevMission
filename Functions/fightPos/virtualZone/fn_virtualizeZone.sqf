params[
	["_module", nil, [objNull]]
];

private _fipoDataArr = [];
private _fipos       = _module getVariable "SFSM_physicalFipos";

{
	private _data = [_x] call SFSM_fnc_virtualizeFipo;
	_fipoDataArr pushBackUnique _data;

} forEach _fipos;

_module setVariable ["SFSM_virtualFipos",  _fipoDataArr];
_module setVariable ["SFSM_physicalFipos",           []];
_module setVariable ["SFSM_active",               false];

true;