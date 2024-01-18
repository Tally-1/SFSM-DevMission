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
// [aimpos _man, _buildingPos, _man, _building] call SFSM_fnc_isValidRpgFirePos;
// SFSM_fnc_validRpgTargetBuilding = {};
// SFSM_fnc_isValidRpgFirePos      = {};
// SFSM_fnc_getRpgLaunchPos        = {};
// SFSM_fnc_initRpgHouse           = {};
// SFSM_fnc_endRpgHouse            = {};
// SFSM_fnc_atValidRpgFirePos      = {};
// SFSM_fnc_rpgHouse               = {};
// SFSM_fnc_whileRpgMove           = {};
// SFSM_fnc_moveToRpgLaunchPos     = {};
// SFSM_fnc_forceLookAtPos         = {};
// SFSM_fnc_fireLauncherAtHouse = {};

// SFSM_fnc_firePosLite = {};


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

SFSM_fnc_isValidRpgFirePos = { 
params[
    ["_firePosASL",   nil,      [[]]],
    ["_targetPosASL", nil,      [[]]],
    ["_shooter",      nil, [objNull]],
    ["_targetObj",    nil, [objNull]]
];

private _topPos     = _firePosASL vectorAdd [0, 0, 5];
private _linebreaks = lineIntersectsSurfaces [_firePosASL, _topPos, _shooter, objNull, true, 3];
private _buildings  = _linebreaks select {(_x#3) isKindOf "house"};

if(_buildings isNotEqualTo [])exitWith{false;};

private _noLOS = [_firePosASL, _targetPosASL, _shooter, _targetObj] call SFSM_fnc_lineBroken;

if(_noLOS)exitWith{false;};

true;
};

SFSM_fnc_getNearHousePositions = { 
params[
    ["_man",      nil,    [objNull]],
    ["_building", objNull, [objNull]]
];

};

SFSM_fnc_getRpgLaunchPos = { 
params[
    ["_man",          nil,    [objNull]],
    ["_building",    objNull, [objNull]]
];
// Return current position if the RPG guy can shoot from there.
if([_man, _building] call SFSM_fnc_atValidRpgFirePos)exitWith{getPosATLVisual _man;};

private ["_launchPos"];
private _areaCenter   = getPosATL _man;
private _distance     = _man distance _building;

if(_distance < 50)  then {_distance = 50;};
if(_distance > 300) then {_distance = 300;};

private _positions    = [_areaCenter, _distance, 100] call Tcore_fnc_squareGrid;
private _targetPosASL = [_building] call SFSM_fnc_buildingCenterPosASL;

_positions = [_positions, [], {_man distance2D _x}, "ASCEND"] call BIS_fnc_sortBy;

{
    if(!isNil "_launchPos")exitWith{};
    private _firePosASL = ATLToASL ([_x, 1] call Tcore_fnc_addZ);
    private _valid      = [_firePosASL, _targetPosASL, _man, _building] call SFSM_fnc_isValidRpgFirePos;
    
    if(_valid)exitWith{_launchPos = _x;};
    
} forEach _positions;

if(isNil "_launchPos")exitWith{};

kk=0;
SFSM_Custom3Dpositions = _positions apply {kk=kk+1;[_x, str kk]};

_launchPos;
};


private _man       = aaa;
private _building  = targetBldn;
private _targetPos = getPos targetBldn;



// [_man, _building] call SFSM_fnc_getRpgLaunchPos;

[_man, _building] call SFSM_fnc_rpgHouse;

// [_man, _targetPos] spawn SFSM_fnc_forceLookAtPos;

// [_man, false]     call SFSM_fnc_endRpgHouse;
// _launchPos = [_man, _building] call SFSM_fnc_firePosLite;
// SFSM_Custom3Dpositions = [[_launchPos, "Launch pos"]];
// SFSM_Custom3Dpositions = [[_launchPos, str round time]];
// SFSM_Custom3Dpositions =[];
// [[22767.4,18969.9,0.0014782],[22767.5,18969.9,0.00145626],[22766.2,18969.5,0.00151539]]
/************************************************************************************/
systemChat "devFile read";