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

*/

/*
TODO RPG HOUSE:
1) Refactor the entire file.
2) Build getLaunchPos function
   - Use a 180 degree solution.
3) Build moveToLaunchPos function.
4) Build isValidRpgFirePos function
5) Replace current view-check with lineObjs functions.
6) Missile guidance when firing out of range

*/

SFSM_fnc_validRpgTargetBuilding = { 
params[
    ["_shooter",        nil, [objNull]],
    ["_targetBuilding", nil, [objNull]]
];
private _myBuilding  = [_man] call SFSM_fnc_currentBuilding;
private _wrongTarget = (!isNil "_myBuilding") &&{_myBuilding isEqualTo _targetBuilding;};
if(_wrongTarget)
exitWith{false;};

private _side       = side _shooter;
private _friendlies = ([_targetBuilding] call SFSM_fnc_unitsInBuilding) select {side _x isEqualTo _side;};
if(_friendlies isNotEqualTo [])
exitWith{false;};

[_man, "lastCqbRpgCheck", time] call SFSM_fnc_unitData;

true;
};


SFSM_fnc_isValidRpgFirePos = { 
params[
    ["_firePosASL",   nil,          [[]]],
    ["_targetPosASL", nil,          [[]]],
    ["_shooter",      nil,     [objNull]],
    ["_targetObj",    objNull, [objNull]]
];


private _valid = ([_shooter, "VIEW", _targetObj] checkVisibility [_firePosASL, _targetPosASL])>0.8;
// private _building = [_man] call SFSM_fnc_currentBuilding;

_valid;
};


SFSM_fnc_getRpgLaunchPos = { 
params[
    ["_man",          nil,     [objNull]],
    ["_building",    objNull, [objNull]]
];

private _buildingPos = [_building] call SFSM_fnc_buildingCenterPosASL;
private _launchPos   = getPos _man;
private _validPos    = [aimpos _man, _buildingPos, _man, _building] call SFSM_fnc_isValidRpgFirePos;

if(_validPos)exitWith{_launchPos;};

_launchPos = [_man, _building] call SFSM_fnc_firePosLite;


if(isNil "_launchPos")exitWith{};

_launchPos;
};


SFSM_fnc_initRpgHouse = { 
params[
    ["_man",       nil, [objNull]],
    ["_building",  nil, [objNull]],
    ["_launchPos", nil,      [[]]]
];

private _buildingVarName = ["Occupied building ", (name _man), (getPos _building)] joinString "_";
missionNamespace setVariable [_buildingVarName, _building];

[_man, "currentDestination", _launchPos]              call SFSM_fnc_unitData;
[_man, "action", "CQB: Engaging house with launcher"] call SFSM_fnc_unitData;
[_man, "targetBuilding", _buildingVarName]            call SFSM_fnc_unitData;

true;
};


SFSM_fnc_endRpgHouse = { 
params[
    ["_man",      nil, [objNull]],
    ["_success",  nil, [false]]
];

private _buildingVarName = [_man, "targetBuilding"] call SFSM_fnc_unitData;
private _building        = missionNamespace getVariable _buildingVarName;
private _buildingPos     = [_building] call SFSM_fnc_buildingCenterPosASL;
private _pos             = getPosATLVisual _man;
private _leader          = leader group _man;

_man doMove _pos;
_man doFollow _leader;

[_man, "targetBuilding", "none"]                    call SFSM_fnc_unitData;
[_man, "currentDestination", [0,0,0]]               call SFSM_fnc_unitData;
[_man, "action", "none"]                            call SFSM_fnc_unitData;

missionNamespace setVariable [_buildingVarName, nil];
_man             setVariable ["SFSM_missileTarget", nil];

if!(alive _man) exitWith{"Man died before launching RPG" call dbgmsg;};
if (_success)   exitWith{[_man, "Building targeted successfully!"] call SFSM_fnc_flashAction;};

private _endMsg = "RPG on house failed";
private _canSee = ([_man, "VIEW", _building] checkVisibility [aimPos _man, _buildingPos])>0.8;

if!(_canSee)then{_endMsg = "failed to get LOS on the building";};

[_man, _endMsg] call SFSM_fnc_flashAction;

true;
};


SFSM_fnc_atValidRpgFirePos = { 
params[
    ["_man",      nil, [objNull]],
    ["_building", nil, [objNull]]
];
private _buildingPos = [_building] call SFSM_fnc_buildingCenterPosASL;
private _aimPos      = aimpos _man;
private _canShoot    = [_aimPos, _buildingPos, _man, _building] call SFSM_fnc_isValidRpgFirePos;

_canShoot;
};

SFSM_fnc_rpgHouse2 = { 
params[
    ["_man",      nil, [objNull]],
    ["_building", nil, [objNull]]
];

private _launchPos   = [_man, _building] call SFSM_fnc_getRpgLaunchPos;


if(isNil "_launchPos")exitWith{[_man, "RPG on house failed"] call SFSM_fnc_flashAction;};

SFSM_Custom3Dpositions = [[_launchPos, str round time]];

[_man, _building, _launchPos] call SFSM_fnc_initRpgHouse;
[_man, _building, _launchPos] call SFSM_fnc_moveToRpgLaunchPos;

if!([_man, true] call SFSM_fnc_canRun)exitWith{[_man, false] call SFSM_fnc_endRpgHouse;};

private _canShoot = [_man, _building] call SFSM_fnc_atValidRpgFirePos;
if!(_canShoot)exitWith{[_man, false]  call SFSM_fnc_endRpgHouse;};

[_man, _building] call SFSM_fnc_fireLauncherAtHouse;

true;
};


SFSM_fnc_whileRpgMove = { 
params[
    ["_moveScript",     nil, [scriptNull]],
    ["_timeLimit",      nil,          [0]],
    ["_man",            nil,    [objNull]],
    ["_targetBuilding", nil,    [objNull]]
];
private _moveAborted = [_man, "abortForcedMove"] call SFSM_fnc_unitData;

if(_moveAborted)        exitWith{true;};
if(isNil "_moveScript") exitWith{true;};
if(scriptDone _move)    exitWith{true;};
if(time > _timeLimit)   exitWith{true;};

private _canShoot = [_man, _targetBuilding] call SFSM_fnc_atValidRpgFirePos;

// abort movement if the soldier has LOS on building
if(_canShoot)then{[_man] call SFSM_fnc_abortForcedMove;};

false;
};


SFSM_fnc_moveToRpgLaunchPos = { 
params[
    ["_man",       nil, [objNull]],
    ["_building",  nil, [objNull]],
    ["_launchPos", nil,      [[]]]
];
private _timeLimit   = time + 30;
private _buildingPos = [_building] call SFSM_fnc_buildingCenterPosASL;
private _moveEnded   = false;
private _move = 
[
    _man,      //unit 
    _launchPos,//position 
    30,        //timeout (optional)
    2          //minimum distance to position in order to complete move. (optional)

] spawn SFSM_fnc_forceMove2;

waitUntil{
    if(_moveEnded)exitWith{true;};
    
    sleep 1;

    _moveEnded = [_move, _timeLimit, _man, _building] call SFSM_fnc_whileRpgMove;
    _moveEnded;
};

true;
};

SFSM_fnc_forceLookAtPos = { 
params[
    ["_man",       nil, [objNull]],
    ["_targetPos", nil,      [[]]], // ATL format.
    ["_timeLimit", 3,         [0]]  // HowLong he should look;
];
private _timer = time + _timeLimit;

while{_timer  > time}do{
    if(_timer < time)exitWith{};
    private _currentDir = round getDirVisual _man;
    private _targetDir  = _man getDir _targetPos;
    private _aimed      = [_currentDir, _targetDir] call SFSM_fnc_inDirRange;

    if!(_aimed)then{
        _man setDir _targetDir;
        _man doWatch _targetPos;
    };

    sleep 0.1;
};

_man doWatch objNull;

true;
};

SFSM_fnc_fireLauncherAtHouse = { 
params[
    ["_man",       nil, [objNull]],
    ["_building",  nil, [objNull]]
];

private _targetPosASL = [_building] call SFSM_fnc_buildingCenterPosASL;
private _targetPosATL = ASLToATL _targetPosASL;
private _dir          = _man getDir _building;

_man setDir _dir;

[_man, _targetPosATL] spawn SFSM_fnc_forceLookAtPos;

["CQB_rpgFire", [_man, _building]] call CBA_fnc_localEvent;

_man setVariable ["SFSM_missileTarget", _targetPosASL];

[_man, nil, _dir] call SFSM_fnc_forceFireLauncher;
[_man, true]      call SFSM_fnc_endRpgHouse;

true;
};


private _man       = aaa;
private _building  = targetBldn;
private _targetPos = getPos targetBldn;

// [_man, _building] call SFSM_fnc_rpgHouse2;

// [_man, _targetPos] spawn SFSM_fnc_forceLookAtPos;

// [_man, false]     call SFSM_fnc_endRpgHouse;
// _launchPos = [_man, _building] call SFSM_fnc_firePosLite;
// SFSM_Custom3Dpositions = [[_launchPos, "Launch pos"]];
// SFSM_Custom3Dpositions =[];
// [[22767.4,18969.9,0.0014782],[22767.5,18969.9,0.00145626],[22766.2,18969.5,0.00151539]]
/************************************************************************************/
systemChat "devFile read";