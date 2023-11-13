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
/************************************************************************************/

SFSM_fnc_capturePlayer = { 
params["_player", "_captor"];
if(_player isNotEqualTo player)exitWith{false;};

if(animationState _player isNotEqualTo "acts_executionvictim_loop")
then{_player playMoveNow "Acts_executionvictim_Loop";};


};

// SFSM_fnc_allowCaptureAbuse = { 

// };



// SFSM_fnc_capture = { 
// params[
// 	"_captive", 
// 	"_captor",
// 	["_forceAbuse", false],
// 	["_forceExecution", false]
// ];

// [_captive, _captor] call SFSM_fnc_initUnconCapture;
// [_captive] remoteExecCall ["SFSM_fnc_removeCaptureAction", 0];
// [_captive] remoteExecCall ["SFSM_fnc_executeAction", 0];
// [_captive] call SFSM_fnc_captureKillEh;
// [_captive] call SFSM_fnc_captureHitEh;
// [_captive] call SFSM_fnc_setCaptured;

// private _bombed =
// [_captive, _captor] call SFSM_fnc_bombOnCapture;

// if(_bombed)exitWith{false;};

// ["capture",  [_captive, _captor]] call CBA_fnc_localEvent;
// [_captive] remoteExec ["SFSM_fnc_capturePlayer", _captive];
// [_captive] spawn SFSM_fnc_postCapture;

// if([_captive, _captor, _forceAbuse]     call SFSM_fnc_allowCaptureAbuse)then{
//    [_captive, _captor, _forceExecution] spawn SFSM_fnc_captureAbuse;
// };

// [[name _captive, " was captured by ", (name _captor)],1] call dbgmsg;

// true;
// };
bbb allowDamage true;
// [ddd, aaa] call SFSM_fnc_initCapture;
bbb switchMove "Acts_executionvictim_Loop";
// bbb playMoveNow "Acts_executionvictim_Loop";
[bbb] call SFSM_fnc_setCaptured;
sleep 2;
// [bbb] call SFSM_fnc_activateMan;
// [aaa] call SFSM_fnc_activateMan;
[bbb, aaa] call SFSM_fnc_captureAbuse;
// detach bbb;
// detach aaa;
// hint str ([ddd] call SFSM_fnc_canBeCaptured);

// [this, 1] call SFSM_fnc_forcedFire;
/************************************************************************************/
systemChat "devFile read";