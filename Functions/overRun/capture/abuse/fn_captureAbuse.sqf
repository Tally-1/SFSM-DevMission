params[
	"_captive", 
	"_captor",
	["_forceExecution", false]
];
[_captive, _captor] call SFSM_fnc_initCaptureAbuse;

private _captorParams = [_captive, _captor, _forceExecution] call SFSM_fnc_captorAbuseAnimParams;
_captorParams call SFSM_fnc_playAnimList;

[_captive, _captor] call SFSM_fnc_endCaptureAbuse;

true;