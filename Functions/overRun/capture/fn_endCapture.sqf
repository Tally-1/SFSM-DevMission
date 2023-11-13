params["_man"];
private _killEh = _man getVariable "SFSM_captureKillEh";
private _hitEh  = _man getVariable "SFSM_captureHitEh";

[_man] call SFSM_fnc_removeExecuteAction;

if(!isNil "_killEh") then {_man removeEventHandler ["Killed", _killEh];};
if(!isNil "_hitEh")  then {_man removeEventHandler ["Hit",    _hitEh];};

true;