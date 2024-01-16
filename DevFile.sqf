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
    ["moveRegistry", [
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

// SFSM_fnc_forcedMoveProne     = {};
// SFSM_fnc_forcedMoveHasFailed = {};
// SFSM_fnc_onForcedMoveFailed  = {};
// SFSM_fnc_hasMoved            = {};
// SFSM_fnc_storeMoveData       = {};
// SFSM_fnc_storeMoveDataAllMen = {};
// SFSM_posToStanceMap          = nil;
// SFSM_fnc_stancePosMap        = {};
// SFSM_fnc_hasMoved            = {};
// SFSM_fnc_timeSinceLastMove   = {};
// SFSM_fnc_canChangeStance     = {};
// SFSM_fnc_isBrainDead         = {};
// SFSM_fnc_forcedUnitPosNoAnim = {};
// SFSM_fnc_findZombies         = {};


// private _zombies = allUnits select {[_x] call SFSM_fnc_isBrainDead;};
// hint ([count _zombies, " Zombies found."]joinString"");
// hint str ([aaa] call SFSM_fnc_canChangeStance);
// [aaa, "DOWN", true, true] call SFSM_fnc_forcedUnitPosNoAnim;
// hint str ( (SFSM_posToStanceMap get "UP"));

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