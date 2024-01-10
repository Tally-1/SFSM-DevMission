if(time < 3)exitWith{"Exited devfile" call dbgmsg;};

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

// SFSM_fnc_capture = { 

// };


// SFSM_fnc_playerCaptureKeyHandlers = { 


// };

// SFSM_fnc_playerCaptureOnKeyDown = { 

// };

// SFSM_fnc_playerCaptureOnKeyUp = { 

// };

// SFSM_fnc_breakOutHint = { 

// };



// SFSM_fnc_capturePlayer = { 

// };

// player setVariable ["SFSM_captureKeyDown", _downEh];
// player setVariable ["SFSM_captureKeyUp",   _upEh];

// SFSM_fnc_endPlayerCapture = { 

// };



// SFSM_fnc_onBreakOutKey = { 

// };

// SFSM_fnc_canCapture = { 

// };

// SFSM_fnc_allAiRescueCapture = { 

// };

// SFSM_fnc_helpOrCapture = { 

// };

// private _excluded  = [];
// private _units     = entities "CaManBase";
// [ccc, _units, _excluded] call SFSM_fnc_helpOrCapture;

// hint str ([ccc] call SFSM_fnc_canBeCaptured);

// SFSM_fnc_ACE_onCaptiveChange = { 

// };

// [ccc, bbb] call SFSM_fnc_initCapture;
// [ccc, true] call ACE_captives_fnc_setSurrendered;
// [ddd, true] call ACE_captives_fnc_setSurrendered; 

[player, true] call ACE_captives_fnc_setSurrendered;

sleep 3;
[] call SFSM_fnc_allAiRescueCapture;
// player switchMove "acts_executionvictim_kill";

// [player, true] call ace_medical_fnc_setUnconscious;
// [player, bbb] call SFSM_fnc_initCapture;
// [player] call SFSM_fnc_setCaptured;
// [player] call SFSM_fnc_playerCaptureKeyHandlers;
// ["ace_captiveStatusChanged", [_unit, _state, "SetSurrendered"]] call CBA_fnc_globalEvent;
// [this, 1] call SFSM_fnc_forcedFire;
/************************************************************************************/
systemChat "devFile read";