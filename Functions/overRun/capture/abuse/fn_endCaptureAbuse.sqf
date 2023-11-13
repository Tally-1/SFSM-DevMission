params["_captive", "_captor"];
[_captive, _captor] remoteExecCall ["enableCollisionWith", [_captive, _captor]];
[_captive, true] call SFSM_fnc_toggleCaptureAi;
[_captor,  true] call SFSM_fnc_toggleCaptureAi;

_captor setVariable ["SFSM_myExecVictim", _captive];

true;