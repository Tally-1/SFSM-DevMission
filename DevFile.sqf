systemChat "devFile found";
// SFSM_fnc_
// SFSM_Custom3Dpositions = [];
// SFSM_customExpression = "";
// [165, 42, 42] call SFSM_fnc_rgbColorToA3Color
// [player] call SFSM_fnc_distanceToFooting
// [_man] call SFSM_fnc_availableAiSoldier;
// [_man, _anims, false, _condition, _midFnc, _postFnc] call SFSM_fnc_playAnimList;
// [true] call SFSM_fnc_getActiveScripts;
// [false, true, true] spawn SFSM_fnc_animListData;
// SFSM_moveAnims call ["animEndPos", ["sprint-front", player, nil, 3]];
/*
[1, 2, [3, 4]] call {
    params ["_one", "_two", "_this"];
    params ["_three", "_four"];
};
", {
*/
/************************************************************************************/

player allowDamage false;
SFSM_Custom3Dpositions = [];
private _man1    = cc;
private _man2    = bb;
// d1 = (f1 getVariable "azFipoData");
// hint str (d1 call ["availUnits"]);


// _fipo setVariable ["posname", "Activation Zone FIPO", true];

// SFSM_fnc_getFipoZonesUnits = { 
// params[["_man",  nil, objNull]];
// private _fireZoneUnits  = [];
// private _flankZoneUnits = [];
// {_fireZoneUnits append (_x get "units")}  forEach (_self get "fire_zones");
// {_flankZoneUnits append (_x get "units")} forEach (_self get "flank_zones");

// if(isNil "_man")exitWith{[_fireZoneUnits, _flankZoneUnits]};

// _fireZoneUnits  = _fireZoneUnits  select {[_man, _x] call SFSM_fnc_validEnemy;};
// _flankZoneUnits = _flankZoneUnits select {[_man, _x] call SFSM_fnc_validEnemy;};


// [_fireZoneUnits, _flankZoneUnits];
// };

// SFSM_fnc_initFIPOsAndAZs      = {};
// SFSM_fnc_getAzArea            = {};
// SFSM_fnc_validAzUnit          = {};
// SFSM_fnc_getUnitsInAz         = {};
// SFSM_fnc_updateAz             = {};
// SFSM_fnc_initAz               = {};
// SFSM_fnc_initActivationZones  = {};
// SFSM_fnc_getAzFipos           = {};
// SFSM_fnc_getAzFipoZones       = {};
// SFSM_fnc_azFipoFireZoneActive = {};
// SFSM_fnc_azFipoOutFlanked     = {};
// SFSM_fnc_initAzFipo           = {};
// SFSM_fnc_flashFipoText        = {};
// SFSM_fnc_hostilePresentInAz   = {};
// SFSM_fnc_getAzSides           = {};
// SFSM_fnc_canMoveInFipo        = {};
// SFSM_fnc_getInFipo            = {};
// SFSM_fnc_getOutFipo           = {};
// SFSM_fnc_fipoAllowedMan       = {};
// SFSM_fnc_azFipoActive         = {};
// SFSM_fnc_availAzFipoUnits     = {};
// SFSM_fnc_handleAZfipos        = {};
// SFSM_fnc_updateAz             = {};
// SFSM_fnc_onAzActiveChanged    = {};
// SFSM_fnc_azFipoGetOut         = {};
// SFSM_fnc_azFipoActions        = {};

// SFSM_fnc_handleActivationZones = { 

// };

[] call SFSM_fnc_handleActivationZones;
// [] call SFSM_fnc_initFIPOsAndAZs;
// az_3 = az3 getVariable "SFSM_AzData";

// hint str (az_3 in SFSM_activationZones);

// az_3 call ["update"];
// hint str (az call ["hostilePresent", [west]]);
// (f1 getVariable "azFipoData") call ["fipoActions"];

// [f1, "Hello!"] spawn SFSM_fnc_flashFipoText;

// az1_obj = [az3] call SFSM_fnc_initAz;
// az1_obj call ["update"];
// (f1 getVariable "azFipoData") call ["fipoActions"];
// hint az1_obj;
// copyToClipboard str az1_obj;

// [m1, f2] call SFSM_fnc_canMoveInFipo;

// {
//     if(typeOf _x isEqualTo "SFSM_FIPO")
//     then{SFSM_fipositions pushBack _x};

//     if(typeOf _x isEqualTo "SFSM_AZ")
//     then{SFSM_activationZones pushBack _x};
    
// } forEach (entities "logic");
systemChat "devFile read";