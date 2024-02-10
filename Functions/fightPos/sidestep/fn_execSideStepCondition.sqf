params[
    ["_man", nil, [objNull]]
];
if!(_man getVariable ["SFSM_returnStep",  false])exitWith{true;};

private _fipo = [_man] call SFSM_fnc_getFipo;
private _distance = _fipo distance _man;

if(isNil "_fipo")   exitWith {false;};
if(_distance < 0.9) exitWith {
    private _anim = SFSM_stanceToAnimMap get (stance _man);
    [_man, _anim] remoteExecCall ["switchMove", _man];
    [_man, "Aborting sideStep", 1] spawn SFSM_fnc_flashAction;
    false;
};

true;