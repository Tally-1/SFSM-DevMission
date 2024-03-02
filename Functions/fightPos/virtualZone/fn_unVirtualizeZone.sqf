private _fipos       = [];

{
    private _fipo = [_x] call SFSM_fnc_spawnVzFipo;
    _fipos pushBackUnique _fipo;

} forEach (_self get "virtualFipos");

_self set ["physicalFipos", _fipos];
_self set ["virtualFipos",      []];
_self set ["active",         true];

true;