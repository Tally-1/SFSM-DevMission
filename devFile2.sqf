
["BFF_overRun", {
params["_orMen"];

// private _dbgMn = (_orMen#0);
// [_dbgMn] spawn dbg_cam;

}] call CBA_fnc_addEventHandler;

["pre_bomb_on_capture", {
params["_man", "_captor"];

[_man] spawn dbg_cam;

}] call CBA_fnc_addEventHandler;

["new_unitData", {
params["_man", "_dataEntry", "_prevValue", "_newValue"];
if(_dataEntry isNotEqualTo "action")exitWith{};

private _valArr = _man getVariable ["SFSM_allActions",[]];
private _flashAction = [_man, "flashAction"] call SFSM_fnc_unitData;

_valArr pushBack ["Action-change", _prevValue, _newValue, time];
_man setVariable ["SFSM_allActions", _valArr];

if ((_prevValue isEqualTo "!PANIC!" || {_prevValue isEqualTo "Surrendered"})
&& {_newValue isEqualTo "none"}) then {
    [_man] spawn dbg_cam;
};

}] call CBA_fnc_addEventHandler;

// {
//     _x addEventHandler ["Fleeing", {
//         params ["_group", "_fleeingNow"];
//         if(_fleeingNow)then{[_group] call SFSM_fnc_analizeFleeing;};    
//     }]; 

// } forEach allGroups;



["brain_reset", {
params["_man"];
private _action      = [_man] call SFSM_fnc_getAction;
private _flashAction = [_man, "flashAction"] call SFSM_fnc_unitData;
private _valArr      = _man getVariable ["SFSM_allActions",[]];

_valArr pushBack ["Brain-Reset", _action, _flashAction, time];

_man setVariable ["SFSM_allActions", _valArr];

}] call CBA_fnc_addEventHandler;


["flash_action", {
params["_man", "_flashAction"];
private _action      = [_man] call SFSM_fnc_getAction;
private _valArr      = _man getVariable ["SFSM_allActions",[]];

_valArr pushBack ["Flash-action", _flashAction, _action, time];

_man setVariable ["SFSM_allActions", _valArr];

}] call CBA_fnc_addEventHandler;


["sprint_start", {
params["_man", "_destination"];
private _valArr      = _man getVariable ["SFSM_allActions",[]];
private _action      = [_man] call SFSM_fnc_getAction;

_valArr pushBack ["Sprint-Start", _action, _destination, time];

_man setVariable ["SFSM_allActions", _valArr];

}] call CBA_fnc_addEventHandler;


["sprint_end", {
params["_man", "_destination"];
private _valArr      = _man getVariable ["SFSM_allActions",[]];
private _action      = [_man] call SFSM_fnc_getAction;

_valArr pushBack ["Sprint-End", _action, _destination, time];

_man setVariable ["SFSM_allActions", _valArr];

}] call CBA_fnc_addEventHandler;


dbg_cam = { 
params["_man"];
    if(isNull (findDisplay 312))      exitwith{};
    if([_man] call SFSM_fnc_isPlayer) exitwith{};
    private _cam = "camera" camCreate (_man modelToWorld [0, 100, 10]);
    _cam camSetTarget _man;
    _cam camSetRelPos [0, 10, 10];
    _cam cameraEffect ["internal", "back"];
    _cam camCommit 0.1;
    sleep 1;
    _cam cameraEffect ["terminate","back"];
    private _camPos = getPosASLVisual _cam;
    private _vd = vectorDir _cam;
    private _vu = vectorUp _cam;
    camDestroy _cam;
    findDisplay 312 closeDisplay 2;
    curatorCamera setPosASL _camPos;//([getPosASLVisual _man,10] call Tcore_fnc_Addz);
    curatorCamera setVectorDirAndUp [_vd, _vu];
    sleep 0.01;
    openCuratorInterface;
};

SFSM_fnc_getActiveScripts = { 
params[["_copy", false], ["_namesOnly"]];

private _scriptData   = diag_activeSQFScripts apply {[_x#0, _x#3]};
private _scriptCount1 = diag_activeScripts#0;
private _scriptCount2 = count _scriptData;

private _outPut = [[_scriptCount1, _scriptCount2], _scriptData];

if(_copy)then{
	copyToClipboard str _outPut;
	hint str _outPut;
};

_outPut;
};


SFSM_fnc_analizeFleeing = { 
params["_group"];
private _data = [];

{
	private _class  = "soldier";
	if(_x isEqualTo leader _group)then{_class = "Leader"};
	private _morale = [_x, "morale"] call SFSM_fnc_unitData;
	private _fleeCoef = [_x, "fleeCoef"] call SFSM_fnc_unitData;
	_data pushback [_class, _morale, _fleeCoef];
} forEach units _group;

copyToClipboard str _data;
[(units _group)#0] spawn dbg_cam;
hint "Flee-data copied!";
};

SFSM_fnc_getAllVarsArr = { 
params["_man"];
private _title   = ["|***|- ALL VARIABLES FOR ", (toUpper name _man), "AT ",(time)," seconds", " -|***|"]joinString"";
private _allvars = [_title];

{
	private _val = (_man getVariable [_x, ""]);
    if(typeName _val == "object")then{_val = str _val;};
	if("ace_" in _x isEqualTo false
	&&{"cba_" in _x isEqualTo false})
	then{_allvars pushBack [_x, _val];};
	
	
} forEach (allVariables _man);

_allvars;
};


SFSM_customExpression = "";

[] spawn { 
while {sleep 0.1; true;} do {
    if(SFSM_customExpression isNotEqualTo "")then{
        private _value = call compile SFSM_customExpression;
        if(isNil "_value")then{_value = "Value is nil"};
        if(typeName _value isEqualTo "STRING")then{hintSilent _value}
        else{
            if(typeName _value isEqualTo "TEXT")then{hintSilent _value}
            else{hintSilent str _value;};
            
        };
        };
    };
};

SFSM_fnc_debugCuratorKeyHandler = { 
params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
private _pressed = false;

if(_key isEqualTo 79)exitWith {execVM 'devFile.sqf'; true;};

if   (_ctrl 
&&   {_key isEqualTo 34})
exitWith{
        [] call SFSM_fnc_onDbgCurKey;
        true;
};

false;
};

SFSM_fnc_activeFunctions = {
    (diag_activeSQFScripts select {"SFSM_fnc_" in (_x#0)})apply {_x#0};
};

/*
private _valArr = this getVariable ["SFSM_allActions",[]];
hint str _valArr;
copyToClipboard str _valArr;

private _allVars = [this] call SFSM_fnc_getAllVarsArr;
hint str _allVars;
copyToClipboard str _allVars;

private _abilities = [this] call SFSM_fnc_abilitiesInUse;
hint str _abilities;
copyToClipboard str _abilities;

*/
/****************************************************************

private _valArr = this getVariable ["SFSM_allActions",[]];
hint str _valArr;
copyToClipboard str _valArr;

private _allVars = [this] call SFSM_fnc_getAllVarsArr;
hint str _allVars;
copyToClipboard str _allVars;

private _abilities = [this] call SFSM_fnc_abilitiesInUse;
hint str _abilities;
copyToClipboard str _abilities;

*******************************************************************/

// [] spawn {while{sleep 10; true;}do{{if([_x] call SFSM_fnc_isRealMan)then{
//     private _man = _x;
//     private _posTrack = _man getVariable ["SFSM_posTrack"]

// }} forEach allUnits}};
// SFSM_fnc_forcedCqbRpg = { 
// params["_man"];

// private _target = (getAttackTarget _man);
// if(time - ([_man, "lastCqbRpgCheck"] call SFSM_fnc_unitData) < 60) exitWith{};
// if (!alive _target)                                                exitWith{};
// if (_man distance2D _target < 30)                                  exitWith{};
// if (insideBuilding _target < 1)                                    exitWith{};

// [_man, "lastCqbRpgCheck", time] call SFSM_fnc_unitData;

// if!([_man, _target] call SFSM_fnc_validEnemy)                      exitWith{};
// if!([_man] call SFSM_canRpgHouse)                                  exitWith{};
// if!([_man, true, true, true, true] call SFSM_fnc_canRun)           exitWith{};

// private _building = [_target] call SFSM_fnc_currentBuilding;
// if(isNil "_building")exitWith{};


// ["Forcing RPG at building",2] call dbgmsg;

// [_man] spawn dbg_cam;
// [_man, _building] spawn SFSM_fnc_rpgHouse;

// };

SFSM_fnc_guideRPG = { 
params [
	"_man", 
	"_weapon", 
	"_muzzle", 
	"_mode", 
	"_ammo", 
	"_magazine", 
	"_missile", 
	"_vehicle"
];

private _target = (_man getVariable ["SFSM_missileTarget",objNull]);
if(isNull _target)exitWith{"No target for missile" call dbgMsg;};
sleep 0.1;

private _targetASL  = [_target] call SFSM_fnc_buildingCenterPosASL;
private _velocityMS = velocityModelSpace _missile;

//Repeat it twice just to make sure it actually sticks.
for "_i" from 0 to 1 do {
if(isNull _missile)exitWith{};

[_missile, _targetASL] call SFSM_fnc_setDirAndPitchToPos;
_missile setVelocityModelSpace _velocityMS;

sleep 0.1;
};


true;
};

SFSM_fnc_sortAnimsByTargetDist = { 
params ["_animMaps", "_targetDist"];
private _sortingAlgo = {
	private _animDistance = _y get "distance";
	private _diff = [_animDistance, _targetDist] call SFSM_fnc_numberDiff;

	_diff;
};

private _maps = [_animMaps, [], _sortingAlgo, "ASCEND"] call BIS_fnc_sortBy;

_maps;
};

SFSM_fnc_initAnimTracking = { 
params["_man"];
private _pos = getPosATLVisual _man;
_man setVariable ["sprintAnimStart",     _pos];
_man setVariable ["sprintAnimPositions", [_pos]];
_man setVariable ["sprintAnimDistances", []];

true;
};

SFSM_fnc_endAnimTracking = { 
params["_man"];
_man setVariable ["sprintAnimStart",     nil];
_man setVariable ["sprintAnimPositions", nil];
_man setVariable ["sprintAnimDistances", nil];

true;
};

SFSM_fnc_trackAnimDistance = { 
params["_man"];
(_man getVariable "SFSM_animListParams")
params [
	"_animArr", 
	"_waitForCompletion", 
	"_condition", 
	"_midFnc", 
	"_postFnc", 
	"_index", 
	"_startTime", 
	"_timer", 
	"_eh"
];


private _pos       = getPosATLVisual _man;
private _lastPos   = _man getVariable "sprintAnimStart";
SFSM_Custom3Dpositions = missionNamespace getVariable ["SFSM_Custom3Dpositions", []];

if(isNil "_lastPos")exitWith{[_man] call SFSM_fnc_initAnimTracking;};

private _distance = (getPosATLVisual _man) distance _lastPos;

[[_distance], 2] call dbgmsg;

(_man getVariable "sprintAnimDistances") pushBack _distance;
(_man getVariable "sprintAnimPositions") pushBack _pos;

private _allPoss   = _man getVariable "sprintAnimPositions";
private _distances = _man getVariable "sprintAnimDistances";

for "_i" from 0 to (count _allPoss-1) do 
{ 
	private _pos  = _allPoss#_i;
	private _text = "start";
	if(_i > 0)then{_text = str (_distances#(_i-1)) };
	SFSM_Custom3Dpositions pushBack [_pos, _text];
};
private _avg = [_distances, true] call Tcore_fnc_average;


_man setVariable ["sprintAnimStart", (getPosATLVisual _man)];

if(_index isEqualTo ((count _animArr)-3)) exitWith{
	[["Average distance = ", _avg], 2] call dbgmsg;
	[_man] call SFSM_fnc_endAnimTracking;
};
};
// player addEventHandler ["FiredMan", {
//     params ["_man", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
//     if(_weapon isEqualTo secondaryWeapon _man)
//     then{
//         _this spawn SFSM_fnc_guideRPG;
//     };

//     true;
// }];

// addMissionEventHandler ["Draw3D", {
//     if(!isNil "SFSM_my3Dsector")then{
        
//     };
// }];

SFSM_fnc_posDiff = { 
params["_pos1", "_pos2"];
private _diff = [
    (_pos2#0) - (_pos1#0),
    (_pos2#1) - (_pos1#1),
    (_pos2#2) - (_pos1#2)
    ];

_diff;
};

// SFSM_fnc_execSideStance = {  
// params["_man", "_leanSide", "_animIndex", "_fipo"];
// private _animMapName   = ["SFSM_",_leanSide,"Stances"] joinString "";
// private _animData      = (missionNamespace getVariable _animMapName) get _animIndex;
// private _anim          = _animData#0;
// private _animDir       = getDir _man + (_animData#7);
// private _animEyeDist   = _animData#6;
// private _animEyeHeight = _animData#3;
// private _newEyepos     = ([(getPos _man), _animDir, _animEyeDist, _animEyeHeight] call SFSM_fnc_sinCosPos2);
// private _eyePos        = ASLToAGL eyePos _man;

// if(!isNil "_fipo")then{
//     // private _offSet = [_animData#4, 0, 0];
//     // if(_leanSide isEqualTo "left")then{_offSet = [0-(_animData#4), 0,0]};
//     _man attachTo [_fipo, /*_offSet*/[0,0,0]];
//     _man spawn{
//         sleep 0.02; detach _this;
//         _this playMoveNow _anim;
//     };
// }else{
//     _man playMoveNow _anim;
// };

// [_eyePos, _newEyepos];
// };

// SFSM_fnc_storeStanceData = { 
// params ["_anim"];
//         sleep 0.5;
//         private _eyeHeight   = [(ASLToATL eyePos player)#2,2] call Tcore_fnc_decimals;
//         private _chestHeight = [(ASLToATL aimPos player)#2,2] call Tcore_fnc_decimals;
//         private _animData    = str ([animationState player, _chestHeight, _eyeHeight]);
//         hint _animData;
//         copyToClipboard _animData;
// };

// player addEventHandler ["AnimChanged", {_this spawn{
// 	params ["_unit", "_anim"];
//     _unit setVariable ["eyePos", eyePos _unit];
//     _unit setVariable ["aimPos", aimPos _unit];

//     sleep 1.2;

//     private _eyediff = eyePos _unit distance2D (_unit getVariable "eyePos");
//     private _aimdiff = aimPos _unit distance2D (_unit getVariable "aimPos");
//     systemChat str [_eyediff, _aimdiff];
// }}];

// waitUntil{!isNil "SFSM_fnc_storeStanceData"};

// player addEventHandler ["AnimDone", {
//     params ["_unit", "_anim"];
//     [_anim] spawn SFSM_fnc_storeStanceData;
// }];


SFSM_fnc_storeStanceData = { 
params ["_anim"];
        sleep 0.5;
        private _eyeHeight   = [(ASLToATL eyePos player)#2,2] call Tcore_fnc_decimals;
        private _chestHeight = [(ASLToATL aimPos player)#2,2] call Tcore_fnc_decimals;
        private _eyePos      = (ASLToATL eyePos player);
        private _aimPos      = (ASLToATL aimPos player);
        private _pos         = getPosATLVisual player;

        private _relEyePos = [[_pos, _eyePos] call SFSM_fnc_posDiff, 1] call Tcore_fnc_roundPos;
        private _relAimPos = [[_pos, _aimPos] call SFSM_fnc_posDiff, 1] call Tcore_fnc_roundPos;

        private _eyeDiff = _pos distance2D _eyePos;
        private _aimDiff = _pos distance2D _aimPos;

        // hint str _relEyePos;
        private _msg = parseText ([
            _anim, "<br/>",
            animationState player, "<br/>",
            _eyeDiff, "<br/>",
            _aimDiff, "<br/>"

        ]joinString "");
        // hint _msg;

        private _animData    = str ([animationState player, _chestHeight, _eyeHeight]);
        hint _animData;
        copyToClipboard _animData;
        player setVariable ["lastAnim", animationState player];
};

// private _distances = [];
// private _side = "right";
// private _j = 0;
// for "_i" from 0 to 5 do {
//     private _pos = getPosASLVisual player;
    
//     if(_i == 3)then{_side = "left"; _j=0;};
//     sleep 1;
//     SFSM_Custom3Dpositions = [player, _side, _j, f1] call SFSM_fnc_execSideStance;
//     sleep 3;
//     private _distance = [(_pos distance2D (getPosASLVisual player)),2] call Tcore_fnc_decimals;
//     _distances pushBack _distance;
//     hint str _distances;
//     sleep 1;
//     player playMoveNow "amovpercmstpsraswrfldnon";
//     waitUntil {player getVariable ["lastAnim", ""] isEqualTo "amovpercmstpsraswrfldnon";};
//     _j=_j+1;
// };

// copyToClipboard str _distances;
// [
//     0.4,
//     0.13,
//     0.54,
//     0.78,
//     0.17,
//     0.49
// ];
// [
//     0.53,
//     0.12,
//     0.56,
//     0.62,
//     0.16,
//     0.5
// ];
// [
//     0.48,
//     0.14,
//     0.56,
//     0.65,
//     0.15,
//     0.48
// ];
// for "_i" from 0 to 2 do {
//     private _pos = getPosASLVisual player;
//     SFSM_Custom3Dpositions = [player, "right", _i] call SFSM_fnc_execSideStance;
//     sleep 3;
//     private _distance = _pos distance2D (getPosASLVisual player);
//     _distances pushBack _distance;
//     player playMoveNow "amovpercmstpsraswrfldnon";
//     waitUntil {player getVariable ["lastAnim", ""] isEqualTo "amovpercmstpsraswrfldnon";};
// };
// SFSM_Custom3Dpositions = [player, "left", 0] call SFSM_fnc_execSideStance;

// cursorObject animate ["hidedoor1", 0];

// waitUntil{!isNil "SFSM_fnc_aimLine"};

// onEachFrame
// {
//     [player] call SFSM_fnc_aimLine;
// };

// {
//     _x setVariable ["SFSM_Excluded",true];

// }forEach (allUnits select {side _x == west});






// Tcore_fnc_stringToVarName = {};

// SFSM_fnc_posMarker = { };




object3dMarkers = { 
params ["_object"];
private _data                = [_object] call Tcore_fnc_object3DShape;
private _posData        = _data get "objPositions";
private _pos                = (_data get "position");
private _center            = (_data get "objCenter");
private _centerPos        = [    ((_aslPos # 0) + (_center # 0)),
                              ((_aslPos # 1) + (_center # 1)),
                              ((_aslPos # 2) + (_center # 2))];
private _topPos            = _posData get "top";
private _rightPos         = _posData get "right";
private _leftPos         = _posData get "left";
private _frontPos         = _posData get "front";
private _backPos         = _posData get "back";

[[0.8,0.1,0.1,1], _pos,       "pos"]     call drawObjectMarker;
[[0.2,0.7,0.2,1], _centerPos, "center"] call drawObjectMarker;
[[0.1,0.6,0.6,1], _rightPos,  "right"]     call drawObjectMarker;
[[0.6,0.1,0.6,1], _leftPos,   "left"]     call drawObjectMarker;
[[0.6,0.6,0.1,1], _frontPos,  "front"]     call drawObjectMarker;
[[0.1,0.4,0.6,1], _backPos,   "back"]     call drawObjectMarker;

[    [0.2,0.2,0.8,1], 
    _topPos,       
    (["top + ", (_data get "height")] joinString "")
] call drawObjectMarker;
};



drawObjectMarker = { 
params["_color", "_position", "_text"];

drawIcon3D     [
                "\A3\ui_f\data\map\markers\handdrawn\dot_CA.paa",            
                _color,
                _position,    
                1,         
                1,         
                0,              
                _text, 
                2,             
                0.035
            ];
};

/*
_group = createGroup west;

_group createUnit

//[_unit, _targetPos, _targetObj, false] call SFSM_fnc_inCoverPos;
SFSM_fnc_inCoverPos = { 
private _checkAll  = false;
params ["_unit", "_endPos", "_ignoreObj", "_checkAll"];

private _aimPos      = unitAimPositionVisual _unit;
private _torsoPos    = unitAimPositionVisual _unit;
private _headPos     = eyePos _unit;
private _headCovered = false;
private _objectsInLOS = [];

if(!isNull _ignoreObj)then{_endPos = eyePos _ignoreObj};

private _inCover     = terrainIntersectASL [_headPos, _endPos];



if(_inCover)exitWith{true};

// if(isNil "_ignoreObj"
// or isNull _ignoreObj)
// then{_objectsInLOS = lineIntersectsSurfaces [_torsoPos, _endPos, _unit]}
// else{_objectsInLOS = lineIntersectsSurfaces [_torsoPos, _endPos, _unit, _ignoreObj]};

// lineIntersectsSurfaces              [begPosASL, endPosASL, ignoreObj1, ignoreObj2, sortMode, maxResults, LOD1, LOD2, returnUnique]
_objectsInLOS = lineIntersectsSurfaces [_torsoPos, _endPos, _unit, _ignoreObj, false, 2, "GEOM", "GEOM", true];

diag_log str ([_unit, "GEOM", _ignoreObj] checkVisibility [_headPos, _endPos]);

diag_log str _objectsInLOS;
private _torsoCovered = !(_objectsInLOS isEqualTo []);

if!(_checkAll)exitWith{_torsoCovered};

_objectsInLOS = lineIntersectsObjs [_headPos, _endPos, _unit, _ignoreObj, false, 2];
_headCovered  = !(_objectsInLOS isEqualTo []);
_inCover      = (_torsoCovered && {_headCovered});


_inCover};

SFSM_fnc_removeNullLosObj = { 
params["_contactData"];
private _obj1 = _contactData # 2;
private _obj2 = _contactData # 3;

};//[_torsoPos, _endPos, _unit, _ignoreObj, false, 1, "PHYSX", "PHYSX", true];

/*****************************************************************lineIntersectsSurfaces [(eyePos player), (eyePos ddd), player, ddd]************/


/*
private _clusterPositions = [(getPos player)] call Tcore_fnc_allClustersInRadius;

private _PlayerInCover = [(getPos player), _clusterPositions] call Tcore_fnc_posCoverPosArr; //[player, _clusterPositions] call Tcore_fnc_unitCoverPosArr;

hint (["player is in cover: ", _PlayerInCover] joinString "");


p0s = [(getPos player)] call Tcore_fnc_allClustersInRadius;
obj = cursorObject; 
rk = [p0s, obj] call Tcore_fnc_objCoverPosLight;

{[_x] call SFSM_fnc_posMarker}forEach rk;
cursorObject


*/
// systemChat "devFile read";

// private _unitPos = getPosASLVisual             _unit;
// private _headPos = eyePos                     _unit;

// SFSM_fnc_drawCircle = {};

//private _clusterPositions = [(getPos player)] call Tcore_fnc_allClustersInRadius; 
//[(getPos player), _clusterPositions] call Tcore_fnc_posCoverPosArr;
/*
Tally_ObjHashMap   = createHashmap;
private _obj       = cursorObject;
private _hashObj   = hashValue _obj;
private _strObj    = str _obj;
Tally_ObjHashMap set ["hashObject",   _hashObj];
Tally_ObjHashMap set ["stringObject", _strObj];

[["hashValue Obj: ", _hashObj]] call Tcore_fnc_debugMessage;
[["string Obj: ",    _strObj]] call Tcore_fnc_debugMessage;
*/


// [playerPos, 300] call SFSM_fnc_drawCircle;

Tally_fnc_ZoneFillers = {
params ["_center", "_radius", "_subZones", "_cornerRadius"];

private _midDist   = _radius * 0.55;
private _midRad    = _cornerRadius * 0.42;
private _shortDist   = _radius * 0.29;
private _shortRad   = _cornerRadius * 0.43;

private _longDist   = _radius * 0.898;
private _longRad    = _cornerRad * 0.59;


if(_shortRad < 10)exitWith{_subZones};

private _zoneFillers = [];
private _directions  = [45, 
                        135, 
                        225, 
                        315];

{
    private _midPos   = [_center # 0, _center # 1, _x,_midDist] call Tcore_fnc_sinCosPos;
    private _shortPos = [_center # 0, _center # 1, _x,_shortDist] call Tcore_fnc_sinCosPos;
    private _longPos  = [_center # 0, _center # 1, (_x -17.5),_longDist] call Tcore_fnc_sinCosPos;
    private _longPos2  = [_center # 0, _center # 1, (_x +17.5),_longDist] call Tcore_fnc_sinCosPos;
    
    private _midZone   = [_midPos, _midRad];
    private _shortZone = [_shortPos, _shortRad];
    private _longZone  = [_longPos, _longRad];
    private _longZone2  = [_longPos2, _longRad];

    private _newZones = [_midZone, _shortZone, _longZone, _longZone2];

    _zoneFillers = [_newZones, _zoneFillers] call Tcore_fnc_toArrFromArr;

} forEach _directions;

_subZones = [_zoneFillers, _subZones] call Tcore_fnc_toArrFromArr;

_subZones};


Tally_Fnc_splitZone = { 
private _maxRadius     = 200;
private _includeParent = false;
private _drawZone      = false;
params ["_center", "_radius", "_maxRadius", "_includeParent", "_drawZone"];
private _map = createHashmap;
private _parentZone = [_center, _radius];
private _subZones   = [];
private _finalArr   = [];


if(_radius > _maxRadius)then{
private _Rad         = _radius * 0.415;
private _distance     = _radius * 0.585;

private _cornerDist = _distance * 1.415;
private _cornerRad  = _Rad * 0.41;

private _midDist1   = _radius * 0.898;
private _midRad1    = _cornerRad * 0.59;

private _northPos = [_center # 0, _center # 1, 0,   _distance] call Tcore_fnc_sinCosPos;
private _eastPos  = [_center # 0, _center # 1, 90,  _distance] call Tcore_fnc_sinCosPos;
private _southPos = [_center # 0, _center # 1, 180, _distance] call Tcore_fnc_sinCosPos;
private _westPos  = [_center # 0, _center # 1, 270, _distance] call Tcore_fnc_sinCosPos;



private _northEastPos = [_center # 0, _center # 1, 45,  _cornerDist] call Tcore_fnc_sinCosPos;
private _southEastPos = [_center # 0, _center # 1, 135, _cornerDist] call Tcore_fnc_sinCosPos;
private _southWestPos = [_center # 0, _center # 1, 225, _cornerDist] call Tcore_fnc_sinCosPos;
private _northWestPos = [_center # 0, _center # 1, 315, _cornerDist] call Tcore_fnc_sinCosPos;

private _northEastPos1 = [_center # 0, _center # 1, 27.5,  _midDist1] call Tcore_fnc_sinCosPos;

private _bigZones = [
                        [_northPos, _Rad],
                        [_eastPos,  _Rad],
                        [_southPos, _Rad],
                        [_westPos,  _Rad]
                    ];

_subZones   =  [
                    [_northEastPos, _cornerRad],
                    [_southEastPos, _cornerRad],
                    [_southWestPos, _cornerRad],
                    [_northWestPos, _cornerRad],
                    [_center,       _cornerRad]
                ];




 if(_Rad <= _maxRadius)then{{_subZones pushBack _x} forEach _bigZones}
else{_subZones = [_center, _radius, _subZones, _cornerRad] call Tally_fnc_ZoneFillers};

if(_cornerRad > _maxRadius)
then{
        {
            private _zones = _x call Tally_Fnc_splitZone;
            _finalArr      = [_zones, _finalArr] call Tcore_fnc_toArrFromArr;
        } forEach _subZones;
    }
else{
        _finalArr      = [_subZones, _finalArr] call Tcore_fnc_toArrFromArr;
    };


if(_Rad > _maxRadius)
then{
        {
            private _zones = _x call Tally_Fnc_splitZone;
            _finalArr      = [_zones, _finalArr] call Tcore_fnc_toArrFromArr;
        } forEach _bigZones;
    };

};

if(_includeParent)    then{_finalArr pushBackUnique _parentZone};
if(_drawZone)        then{{_x call SFSM_fnc_drawCircle} forEach _finalArr};


_finalArr};

SFSM_fnc_avgPosASL = { 
params["_posArr"];
if(count _posArr == 0)exitWith{[]};
if(count _posArr < 2)exitWith{_posArr#0};

Private _Xarr             = [];
Private _Yarr             = [];
Private _Zarr             = [];

{
    _Xarr pushback _x#0;
    _Yarr pushback _x#1;
	_Zarr pushback _x#2;
} forEach _posArr;

private _XX = [_Xarr] call Tcore_fnc_average;
private _YY = [_Yarr] call Tcore_fnc_average;
private _ZZ = [_Zarr] call Tcore_fnc_average;

[_XX, _YY, _ZZ];
};


// SFSM_fnc_aimLine = { 

// };

// SFSM_fnc_addToPosValues = { 
// 
// };



// private _sideStanceData = 
// [
//     ["aadjpercmstpsraswrfldleft",1.16,1.44],
//     ["aadjpknlmstpsraswrfldleft",0.74,1.02],
//     ["aadjppnemstpsraswrfldleft",0.21,0.4],

//     ["aadjpercmstpsraswrfldright",1.19,1.44],
//     ["aadjpknlmstpsraswrfldright",0.73,0.94],
//     ["aadjppnemstpsraswrfldright",0.2,0.34]
// ];

// private _sStanceData = [];

// player playMoveNow "amovpercmstpsraswrfldnon";
// waitUntil {player getVariable ["lastAnim", ""] isEqualTo "amovpercmstpsraswrfldnon";};

// {
//     private _anim = _x#0;
//     private _eyePos = eyePos player;
//     private _aimPos = aimPos player;

//     // hint _anim;
//     player playMoveNow _anim;
//     waitUntil {player getVariable ["lastAnim", ""] isEqualTo _anim;};
//     sleep 1;
//     private _newEyePos   = eyePos player;
//     private _newAimPos   = aimPos player;
//     private _state       = animationState player;
//     private _eyeDiff     = [_newEyePos distance2D _eyePos,2] call Tcore_fnc_decimals;
//     private _aimDiff     = [_newAimPos distance2D _aimPos,2] call Tcore_fnc_decimals;
//     private _eyeHeight   = [(ASLToAGL _newEyePos)#2,2] call Tcore_fnc_decimals;
//     private _chestHeight = [(ASLToAgL _newAimPos)#2,2] call Tcore_fnc_decimals;
    
//     sleep 1;

//     player playMoveNow "amovpercmstpsraswrfldnon";
//     waitUntil {player getVariable ["lastAnim", ""] isEqualTo "amovpercmstpsraswrfldnon";};
//        sleep 1;
//     private _animRelDir = round (player getRelDir _newAimPos);
//     private _animData   = [_state, _chestHeight, _eyeHeight, _aimDiff, _eyeDiff, _animRelDir];
//     hint str _animData;
//     _sStanceData pushBack _animData;
    
// } forEach _sideStanceData;

// copyToClipboard str _sStanceData;
// hint "Sequences done";
// 
/*
[
    ["aadjpercmstpsraswrfldleft",1.16,1.44,0.57,0.69,269],
    ["aadjpknlmstpsraswrfldleft",0.74,1.02,0.28,0.44,277],
    ["aadjppnemstpsraswrfldleft",0.21,0.4,1.15,1.54,258],
    ["aadjpercmstpsraswrfldright",1.18,1.43,0.61,0.64,66],
    ["aadjpknlmstpsraswrfldright",0.73,0.93,0.25,0.28,81],
    ["aadjppnemstpsraswrfldright",0.2,0.33,0.66,0.85,92]
]
*/
/*
[
    ["aadjpercmstpsraswrfldleft",1.16,1.44,0.58,0.69,269],
    ["aadjpknlmstpsraswrfldleft",0.74,1.02,0.28,0.45,275],
    ["aadjppnemstpsraswrfldleft",0.21,0.4,1.16,1.54,257],
    ["aadjpercmstpsraswrfldright",1.18,1.43,0.62,0.65,66],
    ["aadjpknlmstpsraswrfldright",0.73,0.93,0.25,0.29,81],
    ["aadjppnemstpsraswrfldright",0.2,0.33,0.66,0.85,92]
]
*/

/*
[
    ["aadjpercmstpsraswrfldleft",  1.16, 1.42, 0.57, 0.68, 270],
    ["aadjpknlmstpsraswrfldleft",  0.74, 1.01, 0.28, 0.44, 278],
    ["aadjppnemstpsraswrfldleft",  0.21, 0.4, 1.12,  1.51, 256],
    ["aadjpercmstpsraswrfldright", 1.18, 1.42, 0.61, 0.64, 65],
    ["aadjpknlmstpsraswrfldright", 0.73, 0.91, 0.25, 0.29, 81],
    ["aadjppnemstpsraswrfldright", 0.19, 0.32, 0.65, 0.85, 94]
    ]
*/
/*
SFSM_fnc_animMoveDirName = { 
params["_anim"];
if("sraswrfldr" in toLowerANSI _anim)  exitWith{"right";};
if("sraswrfldfr" in toLowerANSI _anim) exitWith{"front-right";};

if("sraswrfldl" in toLowerANSI _anim)  exitWith{"left";};
if("sraswrfldfl" in toLowerANSI _anim) exitWith{"front-left";};

};

SFSM_fnc_formatAlignDir = { 
params["_man", "_target"];
private _dir      = _man getDir _target;
private _anim     = animationState _man;
private _moveDir  = [_anim] call SFSM_fnc_animMoveDirName;
private _speed    = speed _man;

if(_speed < 4)exitWith{_dir;};

if(_moveDir isEqualTo "right")       exitWith{(_dir - 5);};
if(_moveDir isEqualTo "front-right") exitWith{(_dir - 1);};

if(_moveDir isEqualTo "left")       exitWith{(_dir + 5);};
if(_moveDir isEqualTo "front-left") exitWith{(_dir + 1);};

_dir;
};

SFSM_fnc_evasiveAttackAlign = { 
params["_man"];
private _target = _man getVariable "SFSM_myAttackTarget";
// private _anim   = animationState _man;
for "_i" from 1 to 3 do {
	private _dir = [([_man, _target] call SFSM_fnc_formatAlignDir)] call Tcore_fnc_formatDir;
    _man setDir _dir;
	_man setDir _dir;
    sleep 0.3;
};

true;
};


*/


// private _zones = [playerPos, 400, nil, true, true] call Tally_Fnc_splitZone;

// [(count _zones)] call dbgmsg;

// {[playerPos, 400] call SFSM_fnc_getMapObjects} forEach _zones;