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
// playSound3D ["A3\Sounds_F\sfx\blip1.wss", player];

/************************************************************************************/
// SFSM_fnc_getUnitsInAz = { 
// private _entities = (_self get "position") nearEntities (_self get "radius");
// private _units = _entities select {[_x] call SFSM_fnc_validAzUnit;};

// // hint str _units;

// _units;
// };

private _AZ   = (entities "SFSM_AZ")#0;
private _data = _AZ getVariable "SFSM_AzData";

// // _data set ["getUnits", SFSM_fnc_getUnitsInAz];

hint str (_data call ["getUnits"]);

/************************************************************************************/
systemChat "devFile read";