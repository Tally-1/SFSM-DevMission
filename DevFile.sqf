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


player allowDamage false;
SFSM_Custom3Dpositions = [];
private _man1    = cc;
private _man2    = bb;

// SFSM_fnc_getMagSplashRange = { 

// };

// SFSM_fnc_isExplosiveMag = { 

// };

// SFSM_fnc_getBiggestInvExplosive = { 

// };

// SFSM_fnc_captureBombType = { 

// };

// SFSM_fnc_canBombOnCapVars = { 

// };

// [[name _man, " was stopped from blowing himself up."]] call dbgmsg;

// SFSM_fnc_bombOnCapture = { 

// };


[player, objNull] spawn SFSM_fnc_bombOnCapture;
// private _magData  = ["DemoCharge_Remote_Mag"] call ObjScan_fnc_magazineData;
// private _ammo     = _magData get  "AmmoType" ;
// private _ammoData = [_ammo] call ObjScan_fnc_getAmmoData; selectionPos

// hint str ([player] call SFSM_fnc_getBiggestInvExplosive);
// private _magData  = ["MiniGrenade"] call ObjScan_fnc_magazineData;
// private _ammo     = _magData get  "AmmoType";
// private _ammoData = [_ammo] call ObjScan_fnc_getAmmoData;
// private _splash   = _ammoData get "splashRange";
// hint str _ammoData;
// private _ex       = _ammo createVehicle position player;
// sleep 2;
// _ex setDamage 1;

// private _explosives = 
// [
//   "HandGrenade",
//   "HandGrenade",
//   "MiniGrenade",
//   "IEDUrbanBig_Remote_Mag",
//   "DemoCharge_Remote_Mag",
//   "ATMine_Range_Mag",
//   "ClaymoreDirectionalMine_Remote_Mag",
//   "IEDLandSmall_Remote_Mag",
//   "IEDUrbanSmall_Remote_Mag"
// ];

// {
//   private _magData  = [_x] call ObjScan_fnc_magazineData;
//   private _ammo     = _magData get  "AmmoType";
//   private _ex       = _ammo createVehicle position player;
//   sleep 2;
//   _ex setDamage 1;
//   sleep 3;
  
// } forEach _explosives;

systemChat "devFile read";