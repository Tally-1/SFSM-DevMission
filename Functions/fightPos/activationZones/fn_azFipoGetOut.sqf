private _man    = _self get "owner";
private _side   = side _man;
private _active = _self call ["isActive", [_side]];

if(_active isEqualTo true)exitWith{"Fipo still active" call dbgMsg;};

[_man] call SFSM_fnc_getOutFipo;

true;