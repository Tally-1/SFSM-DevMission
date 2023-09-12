params["_magType"];
private _splash = [_magType] call SFSM_fnc_getMagSplashRange;

if(_splash < 4)
exitWith{false;};

true;