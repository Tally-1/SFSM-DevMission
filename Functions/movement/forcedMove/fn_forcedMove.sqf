private _distance    = (_this#0)distance(_this#1);
private _defaultTime = _distance;              //Setting 1 second pr meter as default timer
params [ 
    ["_man",         nil,    [objNull]],      // The man that will move.
    ["_targetPos",   nil,         [[]]],     //  Target position
    ["_maxTime",     _defaultTime, [0]],    //   Timeout (max time to attempt to reach said pos)
    ["_maxDistance", 2,            [0]],   //    Distance to wanted pos before aborting move.
    ["_condition",   [[],{true}], [[]]],  //     Boolean function to be called on each step of path (If calculated)
    ["_postFnc",     nil,         [[]]]  //      Function to be run on completion [[params], _isScheduled, _code]
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
	] call SFSM_fnc_forcedMoveToPos;

    _this call SFSM_fnc_postForceMove2;

};

private _moveComplete = [
    _man,
    _targetPos,
    _maxTime,
    _maxDistance,
    _condition
] call SFSM_fnc_forcedMoveOnPath;

if   (_moveComplete isEqualTo false)
then {[_man, _startPos, _targetPos] call SFSM_fnc_onForcedMoveFailed;};

isNil {_this call SFSM_fnc_postForceMove2;};

true;