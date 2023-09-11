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
player allowDamage false;
SFSM_Custom3Dpositions = [];
private _man1    = cc;
private _man2    = bb;

SFSM_bombTypes        = ["GBU", "Grenade", "Largest explosive in Inventory"];
SFSM_captureExplosive = "gbu"

SFSM_fnc_captureBombType = { 

};


SFSM_fnc_bombOnCapture = { 
params["_man", "_captor"];

createVehicle ["Bomb_03_F", (GetPosATL _man)];
private _text = [name _man, " blew himself and ", (name _captor), " into very small pieces"]joinString"";
[_text] call dbgmsg;
};


systemChat "devFile read";