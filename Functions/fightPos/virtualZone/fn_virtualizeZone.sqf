private _fipoDataArr = [];

{
    private _data = [_x] call SFSM_fnc_virtualizeFipo;
    _fipoDataArr pushBackUnique _data;

} forEach (_self get "physicalFipos");

_self set ["physicalFipos",           []];
_self set ["virtualFipos",  _fipoDataArr];
_self set ["active",               false];

true;