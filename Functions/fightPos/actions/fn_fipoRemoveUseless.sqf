params["_man"];
if([_man, true, true, true] call SFSM_fnc_canRun)exitWith{false;};

[["Useless man released from fipo"], 2] call dbgmsg;
[_man] call SFSM_fnc_getOutFipo;

true;