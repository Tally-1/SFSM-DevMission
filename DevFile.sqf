scr = execVM "devFile2.sqf";
waitUntil {scriptDone scr};
// if(time < 3)exitWith{"Exited devfile" call dbgmsg;};

systemChat "devFile found";
/*
    Medevac Suppression:
    1) Find victims shooter.
    2) Find hostiles near victim & shooter.
    3) Find Available near friendlies (100m around victim + 50 m around Healer).
    4) Friendlies suppress hostiles
    5) If no friendlies then Healer suppresses before moving.
    6) Move to heal.        
*/


/************************************************************************************/
// SFSM_fnc_attackNearEnemy        = {};
// SFSM_fnc_PathCalculated         = {};
// SFSM_fnc_manIsAvailFriendly     = {};
// SFSM_fnc_nearAvailFriendlyMen   = {};
// SFSM_fnc_medevacSuppressionData = {};
// SFSM_fnc_medevacSuppression     = {};
// SFSM_fnc_execMedevacSuppression = {};
// SFSM_fnc_suppressTarget         = {};
// SFSM_fnc_targetZoneCone         = {};
// SFSM_fnc_validBuildingFirePos    = {};
// SFSM_fnc_getSuppressFirePosTarget = {};
// SFSM_fnc_engageAndSuppress       = {};
// SFSM_fnc_canContinueRevive      = {};

/*
    CURRENT:
    - finish "SFSM_fnc_getSuppressFirePos"
    - move to firepos
    - handle action-status

*/
private _healer     = man_1;
private _mainEnemy  = enemy;
private _friendlies = [man_1,man_2];
private _hostiles   = [enemy_1,enemy];
// [
//     _healer,
//     _mainEnemy,
//     _friendlies,
//     _hostiles
    
// ] spawn SFSM_fnc_exevMedevacSuppression;
// private _lowPos  = ATLToASL [_pos#0,_pos#1,0.1];
// private _highPos = _lowPos vectorAdd [0, 0, 5];

// SFSM_fnc_getSuppressionTarget
// SFSM_Custom3Dpositions = [];


// [man_1, enemy] spawn SFSM_fnc_engageAndSuppress;
// [man_2, enemy_1] spawn SFSM_fnc_engageAndSuppress;
// if(trgt isNotEqualTo [])then{
//     SFSM_Custom3Dpositions append [
//         [trgt#0, "move here"],
//         [ASLToATL(trgt#1), "shoot here"]
//     ];
// };


// systemChat str trgt;

/*
private _target = [player, man_2] call SFSM_fnc_getSuppressionTargetPosition;
if(!isNil "_target")then{
if(typeName _target isEqualTo "ARRAY")
then{SFSM_Custom3Dpositions = [[ASLToATL _target, "shoot here"]]}
else{if(typeName _target isEqualTo "OBJECT")
then{SFSM_Custom3Dpositions = [[ASLToATL aimPos _target, name _target]]}};
}else{SFSM_Custom3Dpositions = []; systemChat "target not found"};
*/

// private _suppressData = [player, man_1] call SFSM_fnc_medevacSuppressionData;
// private _friendlies = [player,100] call SFSM_fnc_nearAvailFriendlyMen;
// systemChat str (player distance man_1);
// systemChat str _suppressData;

/************************************************************************************/


/*
private _fipo = f_1;
private _poss = ASLToATL ([getPosASL _fipo, _fipo] call SFSM_fnc_getFipoFirePos);

SFSM_Custom3Dpositions = [[_poss, "firePos"]];
*/
/*
    "shootingstance"
    "shootingstanceleft"
    "shootingstanceright"
*/

// SFSM_fnc_SQFSM_getSuppressionTargetFipo = {};

// params[ 
//     ["_entity",    nil, [objNull]], // Man or vehicle whos known targets will be used.
//     ["_target",    nil, [objNull]], // the target being queried
//     ["_knownOnly", nil,    [true]], // if knowledge is required to return the object.
//     ["_fipo",      nil, [objNull]]  // When called to calculate
// ];


if(time<5)exitWith{"devfile early read"};
/*
private _man         = man_1;
private _destination = getPosATLVisual player;
private _path        = [_man, _destination] call SFSM_fnc_calculatePath;
private _distance   = _man distance _destination;

hint str [round _distance];

SFSM_Custom3Dpositions = [];
SFSM_trajectories      = [];

for "_i"from 0 to (count _path-2)do
{
    private _pos     = _path#_i;
    private _nextPos = _path#(_i+1);
    private _trajectory = [[_pos, _nextPos]];
    SFSM_Custom3Dpositions pushBack [_pos, str _i];
    SFSM_trajectories pushBack _trajectory;
    
};
*/
// player allowDamage false;
// [aaa, player] call SFSM_fnc_evasiveAttack;

// copyToClipboard str allVariables VZ_1;

/************************************************************************************/
systemChat "devFile read";