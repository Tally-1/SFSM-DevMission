// if(time < 3)exitWith{"Exited devfile" call dbgmsg;};

systemChat "devFile found";
// SFSM_fnc_
// SFSM_Custom3Dpositions = [];
// SFSM_customExpression = "";
// [165, 42, 42] call SFSM_fnc_rgbColorToA3Color
// [player] call SFSM_fnc_distanceToFooting
// [_man] call SFSM_fnc_availableAiSoldier;
// [_man, _anims, false, _condition, _midFnc, _postFnc] call SFSM_fnc_playAnimList;
// [true] call SFSM_fnc_getActiveScripts;
// [player] call SFSM_fnc_ACE_disableAutoStance;
// [false, true, true] spawn SFSM_fnc_animListData;
// SFSM_moveAnims call ["animEndPos", ["sprint-front", player, nil, 3]];
// [this, 1] call SFSM_fnc_forcedFire;
// [player, true] call ace_medical_fnc_setUnconscious;
// [aaa, (getPosATLVisual player)] spawn SFSM_fnc_forceMove2;

/************************************************************************************/
/*
Braindeadness:
There are 2 types of braindead.

1) Temporary
   -the unit is pathfinding, and stands still like an idiot.

2) Permanent
   - The unit no longer responds to any input/commands(Except forced animation), and no fixes work.

Fix requested:
    - Go prone / crouch.

How to diagnose?

Temporary:
    -Check if unit has not moved within 2 seconds from forced move order was given.

Permanent:
    - Brain has been reset.
    - doMove does not work.
    - Stance change does not work.

Solution for the permanent braindead:

Add a "AnimStateChanged" eventHandler

On each time the EH fires register time, position, isForcedAnim and speed to an entry in the unitData.
Run another task for all units in the Taskmanager (every 5 minutes)
This task should add the same data as mentioned above.

Add a entry into unitData with failed attempts at moving.

if no position change is registered then run a direct unit-check as soon as the unit is available.

The dataObject should look as follows:
    The moveList:
    ["animChangeMove", [
        time, position,      forcedAnim (If in Fipo or animList is being played)
        [342, [3500,4200,0], false]
    ]]
    (This array should not contain more than 30 entries to save RAM)

    The failed move list:
    ["failedForcedMoves", [
        time dist  StartPos       EndPos
        [342, 0,   [3500,4200,0], [3500,4200,0]]
    ]]

Solution for the Temporary braindead:
Once a forced move has been initiated add a check after 2 seconds:
If the man has not moved after 2 seonds then go prone using animStance.

*/

SFSM_fnc_forcedMoveProne = { 
params[
    ["_man",       nil, [objNull]],
    ["_startPos",  nil,      [[]]],
    ["_startTime", nil,       [0]]
];
private _timeSinceStart = time - _startTime;

if!([_man, true] call SFSM_fnc_canRun) exitWith{false;};
if(_timeSinceStart < 2)                exitWith{false;};
if(_timeSinceStart > 10)               exitWith{false;};

private _hasProned = _man getVariable "SFSM_UnitData" get "hasForcedMoveProned";
private _distance  = _man distance2D _startPos;

if(_hasProned)    exitWith{false;};
if(_distance > 1) exitWith{false;};

[_man, "amovppnemstpsraswrfldnon"] remoteExecCall ["playMoveNow", _man];
[_man, "DOWN"]                     remoteExecCall ["setUnitPos",  _man];

_man getVariable "SFSM_UnitData"set["hasForcedMoveProned", true];

// _man spawn {};

// [_man] spawn dbg_cam;

true;
};


SFSM_fnc_onForcedMoveFailed = { 
params[
    ["_man",       nil, [objNull]],
    ["_startPos",  nil,      [[]]],
    ["_targetPos", nil,      [[]]]
];
if!([_man, true] call SFSM_fnc_canRun)exitWith{false;};

private _failList = _man getVariable "SFSM_UnitData" get "failedForcedMoves";
private _count    = count _failList;
private _endPos   = getPosATLVisual _man;
private _distance = _endPos distance _startPos;

private _moveData = [
    time,
    _distance,
    _startPos,
    _targetPos,
    _endPos
];

_failList pushBack _moveData;
if(_count > 30)then{_failList deleteAt 0;};

[_man, "forced-move failed TOTALLY!", 0.5] spawn SFSM_fnc_flashAction;
// [_man]                                call SFSM_fnc_resetBrain;

// [_man] spawn dbg_cam;
["Complete move fail",2] call dbgmsg;

true;
};

// SFSM_fnc_onAnimChange = {};



// zombie setVariable ["animstates", []];
// zombie addEventHandler ["AnimStateChanged", {
// 	params ["_man", "_anim"];
//     (_man getVariable "animstates") pushBack [_anim, time];
//     [_man, _anim] spawn SFSM_fnc_flashAction;
//     [["Animstate changed. ", (count (_man getVariable "animstates")), " changes registered"],1] call dbgmsg;
// }];

// SFSM_Custom3Dpositions = [
//     [player modelToWorld [-3,0,1], "Left"]
// ];


// player allowDamage false;
// [aaa, player] call SFSM_fnc_evasiveAttack;

// [[22767.4,18969.9,0.0014782],[22767.5,18969.9,0.00145626],[22766.2,18969.5,0.00151539]]
/************************************************************************************/
systemChat "devFile read";