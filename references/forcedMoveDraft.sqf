
SFSM_fnc_initForcedMoveToPos = { 
params[
    ["_man", nil, [objNull]]
];
[_man] call SFSM_fnc_fixPos;
_man doTarget objNull;
_man disableAI "FSM";
_man disableAI "AUTOTARGET";
[_man, "forcedMovement", true] call SFSM_fnc_unitData;
[_man, "hasForcedMoveProned", false] call SFSM_fnc_unitData;
_man setAnimSpeedCoef SFSM_sprintSpeed;
if(SFSM_forceDodge)then{[_man, false] call Tcore_fnc_toggleAiMoveInhibitors};

};

SFSM_fnc_endForcedMoveToPos = { 
params[
    ["_man",        nil, [objNull]],
    ["_combatMode", nil,      [""]]
];
[_man] call SFSM_fnc_fixPos;

_man enableAI "FSM";
_man enableAI "AUTOTARGET";

[_man, "forcedMovement",      false] call SFSM_fnc_unitData;
[_man, "hasForcedMoveProned", false] call SFSM_fnc_unitData;

_man setAnimSpeedCoef 1;
if(SFSM_forceDodge)then{[_man, true] call Tcore_fnc_toggleAiMoveInhibitors};

_man setUnitCombatMode  _combatMode;
};

SFSM_fnc_whileForcedMove = { 
params[
    ["_man",        nil, [objNull]],
    ["_combatMode", nil,      [""]]
];
private _startPos    = getPosATLVisual _man;
private _startTime   = time;
private _timer       = _startTime + _maxTime;
private _distance    = round(_man distance2d _pos);
private _keepMoving  = _distance > _maxDistance;

_man doMove _pos;
while {_keepMoving} do { 
    private _hasMoved = _man distance2D  _startPos > 5;
    private _pronePos = unitPos _man isEqualTo "DOWN";

    _keepMoving = [_man, _pos, _maxDistance, _timer] call SFSM_fnc_keepMoving;
    
    if(_hasMoved &&{_pronePos})then{[_man, "AUTO"] remoteExecCall ["setUnitPos",  _man]};
    if!(_keepMoving)           exitWith{};

    [_man, _startPos, _startTime] call SFSM_fnc_forcedMoveProne;
    
    sleep 0.3;
};


};

SFSM_fnc_forceMoveToPos2 = { 
params [
    "_man",                  // the man that will move.
    "_pos",                 //  target position
    ["_maxTime", 30],      //   timeout (max time to attempt to reach said pos)
    ["_maxDistance", 1.3],
    ["_postFnc", [[],{}]] //   [[Params],{Code}] to execute on end.
];
private _canSprint  = [_man, _pos, 50, 5] call SFSM_fnc_canSprint;
private _combatMode = unitCombatMode _man;
_pos = [_pos] call SFSM_fnc_formatMovePos;

if(_canSprint)exitWith{
    [_man, _pos] call SFSM_fnc_sprint;
    
    if([_man, _pos] call SFSM_fnc_canSprint)exitWith{[_man, _pos] call SFSM_fnc_sprint;};
};
 
[_man]              call SFSM_fnc_initForcedMoveToPos;
[_man]              call SFSM_fnc_whileForcedMove;
[_man, _combatMode] call SFSM_fnc_endForcedMoveToPos;

private _distToPos  = _man distance2D _pos;
private _moveFailed = _distToPos > _maxDistance;

if(_moveFailed)exitWith{ 
    private _noFlash = SFSM_debugger && {(_man getVariable "SFSM_UnitData" get "flashAction") isEqualTo ""};
    private _txt     = ["Target-pos missed by ", _distToPos,"m"]joinString"";
    if(_noFlash)then{[_man, _txt, 0.5] spawn SFSM_fnc_flashAction;};
    false;
};

true;

};


SFSM_fnc_forcedMoveSprint = { 
params [
    "_man",                  // the man that will move.
    "_targetPos",           //  target position
    ["_maxTime", 30],      //   timeout (max time to attempt to reach said pos)
    ["_maxDistance", 1.1],//    distance to wanted pos before aborting move.
    ["_spamTimer", 1.5], //     seconds between each repetition of the doMove command.
    "_postFnc"          //      function to be run on completion [[params], _isScheduled, _code]
];

if!([_man, _targetPos] call SFSM_fnc_canSprint)exitWith{false;};
    
[_man, _targetPos] call SFSM_fnc_sprint;
    
if([_man, "abortForcedMove"] call SFSM_fnc_unitData)exitWith{
    [_man, "abortForcedMove", false] call SFSM_fnc_unitData;

    _this call SFSM_fnc_postForceMove2;
    
	if([_man, "abortSprint"] call SFSM_fnc_unitData)exitWith{
       [_man, "abortSprint", false] call SFSM_fnc_unitData;
       _this call SFSM_fnc_postForceMove2;
	   true;
    };
	true;
};
    
_this call SFSM_fnc_forceMoveToPos2;
_this call SFSM_fnc_postForceMove2;

true;
};

SFSM_fnc_forceMoveOnPath = { 
params [
    "_man",                  // the man that will move.
    "_targetPos",           //  target position
    ["_maxTime", 30],      //   timeout (max time to attempt to reach said pos)
    ["_maxDistance", 1.1],//    distance to wanted pos before aborting move.
    ["_spamTimer", 1.5], //     seconds between each repetition of the doMove command.
    "_postFnc"          //      function to be run on completion [[params], _isScheduled, _code]
];

private _startPos     = getPosATLVisual _man;
private _path         = _man getVariable "SFSM_currentPath";
private _startTime    = time;
private _posTimeLimit = _maxTime / (count _path);

[_man, "Path calculated"] spawn SFSM_fnc_flashAction;

{
    if([_man, "abortForcedMove"] call SFSM_fnc_unitData) exitWith{};
    if([_man, "inFipo"] call SFSM_fnc_unitData)          exitWith{};
    [_man, _startPos, _startTime] call SFSM_fnc_forcedMoveProne;

    _man doFollow _man;
    [
        _man,
        _x,
        _posTimeLimit,
        1,
        _spamTimer
    ]
    call SFSM_fnc_forceMoveToPos2;

    [_man, "forcedMovement", true] call SFSM_fnc_unitData;

} forEach _path;

if([_man, "abortForcedMove"] call SFSM_fnc_unitData) exitWith{true;};
if([_man, "inFipo"] call SFSM_fnc_unitData)          exitWith{true;};

private _pathMoveFailed = [
        _man,
        _startTime,
        _maxTime,
        _startPos,
        _targetPos

    ] call SFSM_fnc_forcedMoveHasFailed;

if(_pathMoveFailed isEqualTo true)exitWith{false;};

true;
};

SFSM_fnc_forceMove2 = { 
params [ 
    "_man",                  // the man that will move.
    "_targetPos",           //  target position
    ["_maxTime", 30],      //   timeout (max time to attempt to reach said pos)
    ["_maxDistance", 1.1],//    distance to wanted pos before aborting move.
    ["_spamTimer", 1.5], //     seconds between each repetition of the doMove command.
    "_postFnc"          //      function to be run on completion [[params], _isScheduled, _code]
];

[_man] call SFSM_fnc_fixPos;

if(_this call SFSM_fnc_forcedMoveSprint)exitWith{true;};

private _timer     = time + 3;
private _calculate = [_man, _targetPos, 3] spawn SFSM_fnc_calculatePath;
[_man, "Calculating path"]                 spawn SFSM_fnc_flashAction;

waitUntil {(scriptDone _calculate) || (_timer < time); };

private _path = _man getVariable "SFSM_currentPath";
if(isNil "_path")exitWith{
    [
		_man, 
		_targetPos
	] call SFSM_fnc_forceMoveToPos2;

    _this call SFSM_fnc_postForceMove2;

};

private _moveComplete = _this call SFSM_fnc_forceMoveOnPath;

if   (_moveComplete isEqualTo false)
then {[_man, _startPos, _targetPos] call SFSM_fnc_onForcedMoveFailed;};

isNil {_this call SFSM_fnc_postForceMove2;};

true;
};
