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
// [this, 1] call SFSM_fnc_forcedFire;
// [player, true] call ace_medical_fnc_setUnconscious;
// [aaa, (getPosATLVisual player)] spawn SFSM_fnc_forceMove2;

/************************************************************************************/
/*
TODO evasion attack:
    // 1) CBA param do deactivate (default ON)
    // 2) Do line-checks on path.
    // 3) Remove zig-zag(Ended up reducing it).
    4) Add New types of evasion attack
       + Sidestep -> crouch -> fire 
       + Sidestep -> big flinch -> fire 
       + Prone front -> roll -> fire 

TODO other:
    1) fix no weaponline error
    2) Look for HE ammo when firing launcher at house.
    3) Replace projectile with high-cal when unconscious shot at close range (Allow execution).
*/

// player allowDamage false;
// [aaa, player] call SFSM_fnc_evasiveAttack;

// [[22767.4,18969.9,0.0014782],[22767.5,18969.9,0.00145626],[22766.2,18969.5,0.00151539]]
/************************************************************************************/
systemChat "devFile read";