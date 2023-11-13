params["_captive", "_captor"];
private _pos          = getPosASLVisual _captive;
private _dir          = getDirVisual _captive;
private _anchor       = createSimpleObject ["UserTexture1m_F", _pos, false];

[_captive, false] call SFSM_fnc_toggleCaptureAi;
[_captor,  false] call SFSM_fnc_toggleCaptureAi;

_anchor setDir    _dir;
_anchor setPosASL _pos;

_captive attachTo [_anchor, [0,0,0]];
_captor  attachTo [_anchor, [0,0,0]];

[_captive, _captor] remoteExecCall ["disableCollisionWith", [_captive, _captor]];
sleep 0.3;

detach _captive;
detach _captor;

deleteVehicle _anchor;

_captor setVariable ["SFSM_myExecVictim", _captive];

true;