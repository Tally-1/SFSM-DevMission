params["_man"];
private _fipo = [_man] call SFSM_fnc_getFipo;
private _allowed = _fipo getVariable "allowsuppression";
if(_allowed isEqualTo false)exitWith{false;};

private _timeSincePrevious = time - ([_man, "lastFipoSuppression"] call SFSM_fnc_unitData);
if(_timeSincePrevious < 30)exitWith{false;};

true;