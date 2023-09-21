params["_man"];
private _canSuppress = [_man] call SFSM_fnc_canFipoSuppress;
if(_canSuppress isEqualTo false)exitWith{false;};

private _suppressPos = [_man] call SFSM_fnc_getFipoSuppressPos;
if(isNil "_suppressPos")exitWith{false;};

[_man, "Suppressing enemy"] call SFSM_fnc_setAction;

_man doSuppressiveFire _suppressPos;
waitUntil {sleep 1;	currentCommand _man != "Suppress";};

_man suppressFor 5;
waitUntil {sleep 1;	currentCommand _man != "Suppress";};

[_man, "lastFipoSuppression", time] call SFSM_fnc_unitData;

true;