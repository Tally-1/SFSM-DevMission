// Move out current fipo-man if azFipo is no longer active.
if(!isNull (_self get "owner"))
exitWith{_self call ["getOut"]};

private _module = _self get "module";
private _units  = _self call ["availUnits"];
if(_units isEqualTo [])exitWith{[_module, "Nobody could be assigned"] spawn SFSM_fnc_flashFipoText;};

private _man = [_module, _units] call SFSM_fnc_getNearest;

[_man, _module] spawn SFSM_fnc_moveInFipo;

[_module, "Man assigned", [0,1,0,1]] spawn SFSM_fnc_flashFipoText;

true;