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
// SFSM_fnc_endFipoSideStep = {};
// private _AZ   = (entities "SFSM_AZ")#0;
// private _data = _AZ getVariable "SFSM_AzData";
// _data set ["getUnits", SFSM_fnc_getUnitsInAz];
// hint str (_data call ["getUnits"]);
// player allowDamage false;
// SFSM_evasionAttackSpeed = 1.2;
// [aaa, player] spawn SFSM_fnc_evasiveAttack;

// SFSM_fnc_get360PosASL    = {};
// SFSM_fnc_canSprintFlinch = {};
// SFSM_fnc_evasionDir2     = {};
// SFSM_fnc_sprintFlinch    = {};
// SFSM_fnc_hashAllObjVars  = {};
// SFSM_fnc_initVzFipo      = {};
// SFSM_fnc_spawnVzFipo     = {};
// SFSM_fnc_virtualizeFipo  = {};
// SFSM_fnc_virtualizeZone  = {};
// SFSM_fnc_unVirtualZone   = {};
// [VZ_1] call SFSM_fnc_virtualizeZone;
// sleep 3;
// [VZ_1] call SFSM_fnc_unVirtualizeZone;
// SFSM_fnc_deadCrew = {};

SFSM_fnc_unitsInModuleArea = { 
params[
	["_module",      nil, [objNull]],
	["_returnSides", false, [false]]
];
private _area  = [_module] call SFSM_fnc_getAzArea;
private _units = entities "land" select {
	([_x] call SFSM_fnc_functionalMan ||
	{[_x] call SFSM_fnc_validVehicle})
};

if(_returnSides isEqualTo false)exitWith{_units;};



};


SFSM_fnc_VZconditionsTrue = { 
params["_vzModule"];
private _units = 

};


SFSM_fnc_reInitVz = { 
params[
	["_module", objNull,[objNull]]
];

private _area  = [_module] call SFSM_fnc_getAzArea;
private _fipos = entities "SFSM_FIPO" select {_x inArea _area};

_module setVariable ["SFSM_active",         true];
_module setVariable ["SFSM_physicalFipos", _fipos];
_module setVariable ["SFSM_virtualFipos",      []];
};

copyToClipboard str allVariables VZ_1;

/************************************************************************************/
systemChat "devFile read";