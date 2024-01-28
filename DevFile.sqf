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
// [aaa, (getPosATLVisual player)] spawn SFSM_fnc_forcedMove;

/************************************************************************************/
/*
TODO Capture:
params:
// 1) Allow capture:
// 	["Everyone", "AI only", "Players Only", "nobody"]
// 	["all", "ai", "players", "disabeled"]
// 2) Captive Heart attack: 
// 	["never", "1 minute", "2 minutes", "3 minutes", "4 minutes", "5 minutes"]
// 	[-1,1,2,3,4,5]
3) Redo capture function so that the man avoids capping if unit is discovered.
(Maybe use EH?)
4) Capture when very close and doing CQB

// Surrender:
// 1) Have panicked units switch to surrender when surrounded
// 2) Have fleeing units surrender on a 50% random chance.

*/


// SFSM_fnc_canMoveToRevive = {};

SFSM_Custom3Dpositions=[];


// SFSM_Custom3Dpositions=[[_lowPos, "Lowest"]];


/************************************************************************************/
systemChat "devFile read";