// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man"];
private _data = _man getVariable "SFSM_UnitData";
if(!isNil "_data")exitWith{};
// if!([_man] call SFSM_fnc_isRealMan)exitWith{};

// if(isPlayer _man)exitwith{};
if([(group _man)] call Tcore_fnc_nilNull)exitWith{};



// Setting all time variables to -300 to allow for 
// proper reactions from the start of the game  
private _dataArr = [
        ["Last_Hit",            0-300],
        ["Last_Close_Bullet",   0-300], 
        ["last_bullet_fired",   0-300],
        ["flinchTimer",         0-300],
        ["lastFlinch",          0-300],
        ["dodgeTimer",          0-300],
        ["reactFireTimer",      0-300],
        ["lastBattle",          0-300],
        ["last_time_in_cover",  0-300],
        ["last_AmmoCheck",      0-300],
        ["lastSprintCheck",     0-300],
        ["lastPinDown",         0-300],
        ["huntStart",           0-300],
        ["huntEnded",           0-300],
        ["lastFipoAttempt",     0-300],
        ["peekCooldown",        0-300],
        ["lastPeek",            0-300],
        ["lastOverRun",         0-300],
        ["prevHealTime",        0-300],
        ["lastCqbRpgCheck",     0    ],
        ["roundsPrSecond",      0    ],
        ["action",              "none"],
        ["flashAction",         ""    ],
        ["currentBattle",       "none"],
        ["currentBuilding",     "none"],
        ["targetBuilding",      "none"],
        ["currentDestination",  [0,0,0]],
        ["hashValue",           hashvalue _man],
        ["current suppression", (getSuppression _man)],
        ['pathEnabeled',        (_man checkAIFeature "PATH")],
        ["hunkObjectHash",         []],
        ["flinchTimes",            []],
        ["abortForcedMove",     false],
        ["abortSprint",         false],
        ["checkSprint",          true],
        ["hasForcedMoveProned",  true],
        ["forcedMovement",      false],
        ["inFipo",              false],
        ["lastFipoPanicCheck",  0-300],
        ["lastFipoSuppression", 0-300],
        ["fipoPanicCount",          0],
        ["moraleEventsActive",     []],
        ["moraleEvents",           []],
        ["lastMoraleEvent",     0-300],
        ["baseMoraleChecked",   0-300],
        ["baseMorale",              1],
        ["baseMoraleFactors",   createHashmap],
        ["morale",                  1],
        ["playingAnimList",     false],
        ["fleeCoef",                0],
        ["animChangeMove",         []],
        ["failedForcedMoves",      []]
];

/*
Examples of how the moves lists should look:

["animChangeMove", [
        time, position,     forcedAnim (If in Fipo or animList is being played)
        [342, [3500,4200,0], false]
]]

["failedForcedMoves", [
        time dist  StartPos       EndPos         TargetPos
        [342, 0,   [3500,4200,0], [3600,4250,0], [3500,4200,0]]
    ]]

*/


private _unitData = createHashMapObject [_dataArr];
_man setVariable["SFSM_UnitData", _unitData, true];

_man setVariable["SFSM_prevTarget",     objNull,   true];
_man setVariable["SFSM_prevShooter",    objNull,   true];


if(_man getVariable ["SFSM_Excluded",false])exitWith{};

[_man] call SFSM_fnc_SuppressedEH;
[_man] call SFSM_fnc_firedEH;
[_man] call SFSM_fnc_hitEH;

_man addEventHandler ["InventoryOpened",  {_this call SFSM_fnc_onInventoryOpened;}];
_man addEventHandler ["AnimStateChanged", {_this call SFSM_fnc_onAnimChange}];

[_man] call SFSM_fnc_autoStanceActions;
[_man] call SFSM_fnc_buddyRearmAction;
[_man] call SFSM_fnc_playerCallMedicAction;

true;