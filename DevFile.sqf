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

private _data      = az1 getVariable "SFSM_AzData";
private _area      = _data get "area";
private _pos      = _data get "position";
private _corners   = _area call SFSM_fnc_getAreaCorners;
private _screenPos   = worldToScreen _pos;
// hint str ;
// hint str( (_data get "corners")isEqualTo _corners);
// private _area      = _data get "area";
// private _i = 0;
// (_area call SFSM_fnc_getAreaCorners)params["_bottom", "_top"];
// _bottom append _top;
// private _positions = (_bottom apply{_i=_i+1; [_x, str _i]});

// SFSM_Custom3Dpositions = _positions;// [[_positions#0, "FR"], [_positions#1, "FL"], [_positions#2, "BL"], [_positions#3, "BR"]];
// [_startPos, _x, _color]

// SFSM_fnc_AZmanager = {};

/************************************************************************************/
systemChat "devFile read";