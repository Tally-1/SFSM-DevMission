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
    2) Do line-checks on path.
    3) Remove zig-zag.
    4) Add New types of evasion attack
       + Sidestep -> crouch -> fire 
       + Sidestep -> big flinch -> fire 
       + Prone front -> roll -> fire 

TODO other:
    1) fix no weaponline error
    2) Look for HE ammo when firing launcher at house.
    3) Replace projectile with high-cal when unconscious shot at close range (Allow execution).
*/

SFSM_fnc_attackAnimPath = { 
params[
    ["_man",    nil, [objNull]],
    ["_target", nil, [objNull]]
];
private _dir      = (_man getDir _target)-45;
private _animList = _self get "animations";
private _pos      = getPosATLVisual _man;
private _path     = [_pos];

{
    // private _dir      = (_pos getDir (getPosATLVisual _target))-90;
    private _animData = SFSM_moveAnims call ["getMapByCfgName", [_x]];
    private _newPos   = _animData call ["getEndPos", [_pos, _dir]];

    _path pushBack _newPos;
    _pos = _newPos;
    
} forEach _animList;

_path;
};

SFSM_fnc_attackAnimMap = { 
params[
	["_mapName",  nil, [""]],
	["_animList", nil, [[]]]
];

private _dataArr = [
	["name",       _mapName],
	["animations", _animList],
	["getPath",    SFSM_fnc_attackAnimPath]
];

private _attackAnimData = createHashmapObject [_dataArr];

_attackAnimData;
};

private _name  = "zig-zag";
private _anims = [
    "AmovPercMtacSrasWrflDr",
    "AmovPercMtacSrasWrflDl",
    "AmovPercMtacSrasWrflDr"
];

private _map  = [_name, _anims] call SFSM_fnc_attackAnimMap;
private _path = _map call ["getPath", [aaa, player]];
private _i    = 0;
// SFSM_Custom3Dpositions = _path apply {_i=_i+1; [_x, str _i];};
// hint str (SFSM_moveAnims call ["getMapByCfgName", ["AmovPercMtacSrasWrflDr"]]);


// SFSM_fnc_initAttackAnims = { 

// };


SFSM_fnc_evasiveAttackAnims = { 
params["_moveType"];

if(_moveType isEqualTo "zig-zag")exitWith{
    [
        "AmovPercMtacSrasWrflDr",
        "AmovPercMtacSrasWrflDl",
		"AmovPercMtacSrasWrflDr"
    ];
};

if(_moveType isEqualTo "flank right")exitWith{
    [
        "AmovPercMtacSrasWrflDfr",
        "AmovPercMtacSrasWrflDfr",
		"AmovPercMtacSrasWrflDfr",
        "AmovPercMtacSrasWrflDr",
		"AmovPercMtacSrasWrflDr",
        "AmovPercMevaSrasWrflDfr_AmovPknlMstpSrasWrflDnon"
    ];
};

if(_moveType isEqualTo "flank left")exitWith{
    [
        "AmovPercMtacSrasWrflDfl",
        "AmovPercMtacSrasWrflDfl",
		"AmovPercMtacSrasWrflDfl",
        "AmovPercMtacSrasWrflDl",
		"AmovPercMtacSrasWrflDl",
        "AmovPercMevaSrasWrflDfl_AmovPknlMstpSrasWrflDnon"
    ];
};
};

// ["_moveType", selectRandom ["zig-zag", "flank right", "flank left"]]
// SFSM_fnc_trackAnimListPath = { 
// params[
//     "_man", 
//     "_animList"
// ];


// };

SFSM_fnc_createRelativePath = { 
params["_posArr"];
private _startPos = _posArr#0;
_posArr deleteAt 0;
private _relPath = _posArr apply {
    [
        (_x#0)-(_startPos#0),
        (_x#1)-(_startPos#1),
        1
    ];
};

_relPath;
};


SFSM_fnc_evasiveAttackCondition = { 
params["_man"];
private _index       = (_man getVariable "SFSM_animListParams")#5;
private _target      = _man getVariable "SFSM_myAttackTarget";
private _validTarget = [_target] call SFSM_fnc_functionalMan;
private _nextAnim    = _animArr#(_index+1);
private _pathClear   = 
if(!isNil "_nextAnim")then{
    private _animData    = SFSM_moveAnims call ["getMapByCfgName", [_nextAnim]];
    private _newPos      = _animData call ["getEndPos", [_man]];

    SFSM_Custom3Dpositions = [[_newPos, _nextAnim]];
};



_validTarget;
};


SFSM_fnc_evasiveAttack = { 
params[
    "_man", 
    "_target"
];

private _able     = [_man, _target] call SFSM_fnc_canDoEvasiveAttack;
private _startPos = getPosATLVisual _man;
if(_able isEqualTo false)exitWith{};

// SFSM_pathPositions     = [_startPos];
// SFSM_Custom3Dpositions = [[_startPos, str round time]];



private _moveType = "zig-zag";//, "flank right", "flank left"

private _condition = { [_man] call SFSM_fnc_evasiveAttackCondition};
private _midFnc    = { 
    [_man] spawn SFSM_fnc_evasiveAttackAlign; 

    // private _pos = getPosATLVisual _man;
    // SFSM_pathPositions pushBack (getPosATLVisual _man);
    // SFSM_Custom3Dpositions pushBack [_pos, str round time];
};

private _endFnc    = { 
    [_man] spawn SFSM_fnc_endevasiveAttack;   
    
    // private _pos = getPosATLVisual _man;
    // SFSM_pathPositions pushBack _pos;
    // SFSM_Custom3Dpositions pushBack [_pos, str round time];
};

private _anims     = [_moveType] call SFSM_fnc_evasiveAttackAnims;

[_man, _moveType]                                  spawn SFSM_fnc_flashAction;
[_man, _target]                                    call  SFSM_fnc_initevasiveAttack;
[_man, _anims, true, _condition,_midFnc, _endFnc]  call  SFSM_fnc_playAnimList;
[_man, _target]                                    call  SFSM_fnc_evasiveAttackLoop;

// copyToClipboard str SFSM_pathPositions;
// hint str count SFSM_pathPositions;
// SFSM_Custom3Dpositions = SFSM_pathPositions apply {_i=_i+1; [_x, str _i];};
// copyToClipboard str ([SFSM_pathPositions] call SFSM_fnc_createRelativePath);

true;
};


// private _animData = SFSM_moveAnims call ["getMapByCfgName", ["AmovPercMtacSrasWrflDr"]];
// private _newPos   = _animData call ["getEndPos", [aaa]];

// SFSM_Custom3Dpositions = [[_newPos, "end pos"]];

player allowDamage false;
[aaa, player] call SFSM_fnc_evasiveAttack;

// [[22767.4,18969.9,0.0014782],[22767.5,18969.9,0.00145626],[22766.2,18969.5,0.00151539]]
/************************************************************************************/
systemChat "devFile read";