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
/************************************************************************************/

// configfile >> "CfgMagazines" >> "DemoCharge_Remote_Mag" >> "ammo"
// configfile >> "CfgAmmo" >> "DemoCharge_Remote_Ammo" >> "indirectHitRange"
[
  "30Rnd_65x39_caseless_mag",
  "30Rnd_65x39_caseless_mag",
  "30Rnd_65x39_caseless_mag",
  "30Rnd_65x39_caseless_mag",
  "30Rnd_65x39_caseless_mag",
  "30Rnd_65x39_caseless_mag",
  "30Rnd_65x39_caseless_mag",
  "16Rnd_9x21_Mag",
  "16Rnd_9x21_Mag",
  "HandGrenade",
  "HandGrenade",
  "MiniGrenade",
  "IEDUrbanBig_Remote_Mag",
  "DemoCharge_Remote_Mag",
  "ATMine_Range_Mag",
  "ClaymoreDirectionalMine_Remote_Mag",
  "IEDLandSmall_Remote_Mag",
  "IEDUrbanSmall_Remote_Mag",
];

player allowDamage false;
SFSM_Custom3Dpositions = [];
private _man1    = cc;
private _man2    = bb;

//                       "gbu"   "grenade"  "largestEx"
SFSM_bombTypes        = ["GBU", "Grenade", "Largest explosive in Inventory"];
SFSM_captureExplosive = "gbu";

SFSM_fnc_getMagSplashRange = { 
params["_magType"];
private _magData  = [_magType] call ObjScan_fnc_magazineData;
private _ammo     = _magData get  "AmmoType";
private _ammoData = [_ammo] call ObjScan_fnc_getAmmoData;
private _splash   = _ammoData get "splashRange";

_splash;
};

SFSM_fnc_isExplosiveMag = { 
params["_magType"];
private _splash = [_magType] call SFSM_fnc_getMagSplashRange;

if(_splash < 6)
exitWith{false;};

true;
};

SFSM_fnc_getBiggestInvExplosive = { 
params ["_man"];
private _explosives = magazines _man select {[_x] call SFSM_fnc_isExplosiveMag;};
if(_explosives isEqualTo [])exitWith{};
private _biggest = ([_explosives, [], { [_x] call SFSM_fnc_getMagSplashRange;}, "DESCEND"] call BIS_fnc_sortBy)#0;

_biggest;
};

SFSM_fnc_captureBombType = { 
if(SFSM_captureExplosive isEqualTo "gbu")exitWith{"Bomb_03_F"};
};


SFSM_fnc_bombOnCapture = { 
params["_man", "_captor"];
private _bombType = [_man] call SFSM_fnc_captureBombType;
createVehicle [_bombType, (GetPosATL _man)];
private _text = [name _man, " blew himself and ", (name _captor), " into very small pieces"]joinString"";
[_text] call dbgmsg;
};

private _magData  = ["DemoCharge_Remote_Mag"] call ObjScan_fnc_magazineData;
private _ammo     = _magData get  "AmmoType" ;
private _ammoData = [_ammo] call ObjScan_fnc_getAmmoData;

hint str ([player] call SFSM_fnc_getBiggestInvExplosive);
systemChat "devFile read";