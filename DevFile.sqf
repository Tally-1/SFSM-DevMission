// if(time < 3)exitWith{"Exited devfile" call dbgmsg;};

systemChat "devFile found";
// SFSM_fnc_
// SFSM_Custom3Dpositions = [[_pos, "string"]];
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
// SFSM_fnc_endFipoSideStep = {};
// private _AZ   = (entities "SFSM_AZ")#0;
// private _data = _AZ getVariable "SFSM_AzData";
// _data set ["getUnits", SFSM_fnc_getUnitsInAz];
// hint str (_data call ["getUnits"]);
// player allowDamage false;
// SFSM_evasionAttackSpeed = 1.2;
// [aaa, player] spawn SFSM_fnc_evasiveAttack;

/*
TODO:
// 1) Undefined values (FIPO already deleted?)
// 2) resync VZ spawned FIPOs.

*/

// SFSM_fnc_get360PosASL      = {};
// SFSM_fnc_canSprintFlinch   = {};
// SFSM_fnc_evasionDir2       = {};
// SFSM_fnc_sprintFlinch      = {};
// SFSM_fnc_hashAllObjVars    = {};
// SFSM_fnc_initVzFipo        = {};
// SFSM_fnc_spawnVzFipo       = {};
// SFSM_fnc_virtualizeFipo    = {};
// SFSM_fnc_virtualizeZone    = {};
// SFSM_fnc_unVirtualZone     = {};
// SFSM_fnc_deadCrew          = {};
// SFSM_fnc_sidesFromObjArr   = {};
// SFSM_fnc_unitsInModuleArea = {};
// SFSM_fnc_canBattleInitVz   = {};
// SFSM_fnc_VZconditionsTrue  = {};
// SFSM_fnc_virtualizeZone    = {};
// SFSM_fnc_unVirtualizeZone  = {};
// SFSM_fnc_canActivateVz     = {};
// SFSM_fnc_canDeActivateVz   = {};
// SFSM_fnc_toggleVz          = {};
// SFSM_fnc_initVirtualZone   = {};
// SFSM_fnc_activateBattleVzs = {};
// SFSM_fnc_initVirtualZone   = {};
// SFSM_fnc_drawVrtZones      = {};
// SFSM_fnc_VZ3D              = {};

{
	private _data = _x getVariable "SFSM_vzData";
	// _data set ["activate", SFSM_fnc_unVirtualizeZone];
	// _data set ["activate", SFSM_fnc_unVirtualizeZone];
	
} forEach entities "SFSM_VZ";




// copyToClipboard str allVariables VZ_1;

/************************************************************************************/
systemChat "devFile read";