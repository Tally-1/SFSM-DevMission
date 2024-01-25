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

// SFSM_fnc_nearestKnownEnemy    = {};
// SFSM_fnc_distanceToKnownEnemy = {};
// SFSM_fnc_returnToFormation    = {};
// SFSM_fnc_canReturnToFormation = {}; 
// ObjScan_fnc_scopeRange        = {};
// SFSM_fnc_isMarksman       = {};
// private _weaponData       = ([this] call objScan_fnc_infGearData)get"weaponData";
// SFSM_fnc_hasAmmoForWeapon = {};
// SFSM_fnc_getScopeRange    = {};

SFSM_Custom3Dpositions=[];

private _men     = units grp1;
private _snipers = _men select {[_x] call SFSM_fnc_isMarksman};
private _errors  = _men select {_x in _snipers isEqualTo false;};
private _ePos    = getPosATLVisual leader grp1;

hint str [count _men, count _snipers, count _errors];

// SFSM_Custom3Dpositions=[[_ePos, "No mark"]];
// grp2 = createGroup west;
_snipers join group player;


// SFSM_fnc_squareGrid   = {};
// SFSM_fnc_getLowestPos = {};
// private _position     = getPosATL player;
// private _rad          = SFSM_DodgeDistance;
// private _lowPos = 
// [_position, _rad] call SFSM_fnc_getLowestPos;
// SFSM_Custom3Dpositions=[[_lowPos, "Lowest"]];
// [aaa, player] call SFSM_fnc_evasion;

/************************************************************************************/
systemChat "devFile read";