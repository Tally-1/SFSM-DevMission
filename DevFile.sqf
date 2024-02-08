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

/************************************************************************************/
/*
TODO:
Set stance indicators
use surface as endPos-Z
Force doMove at some interval if there has been no movement for 5+ seconds evenif it has not failed.

*/

SFSM_fnc_getInFipo = { 
params["_man", "_fipo"];
_man attachTo [_fipo, [0,0,0]];
_man disableAI "PATH";
_man setDir 0;
// doStop _man;
_man doFollow _man;


private _azFipoData = _fipo getVariable "azFipoData";
if(!isNil "_azFipoData")then{_azFipoData set ["owner", _man];};

[_man, "Idle"] call SFSM_fnc_setAction;
[_man, "inFipo", true] call SFSM_fnc_unitData;

_man setUnitPos "MIDDLE";
_fipo synchronizeObjectsAdd [_man];
[_fipo] call SFSM_fnc_updateFipoMarker;

([_man] call SFSM_fnc_fipoStanceIndexes)#0
params["_index", "_animVar"];

if(isNil "_index")then{_index = 1;};

[_man,  [_index, _animVar]] call SFSM_fnc_animSetStance;

_man spawn {
    sleep 1; 
    detach _this;
};


if(_fipo getVariable "hitandrun")then{
    [_man, _fipo] call SFSM_fnc_initHitAndRunFipo;
};


["fipo_getIn", [_man, _fipo]] call CBA_fnc_localEvent;

true;
};


SFSM_fnc_fipoPeek = { 
params["_man"];

private _peekTime = ([_man] call SFSM_fnc_fipoPeekTime)+0.1;//added 0.1 to account for the wait 
private _coolDown = [_man] call SFSM_fnc_peekCoolDownTime;
private _fipo     = [_man] call SFSM_fnc_getFipo;
if(isNil "_fipo")exitWith{};

([_fipo] call SFSM_fnc_fipoStanceIndexes)
params[
    "_coverStance",
    "_shootUp",
    "_shootRight",
    "_shootLeft"
];

private _fireStances    = [_shootUp, _shootRight, _shootLeft];
private _shootingStance = [_fireStances] call SFSM_fnc_selectShootingStance;
private _stepRight      = _shootingStance isEqualTo [3, "SFSM_rightStances"];
private _stepLeft       = _shootingStance isEqualTo [3, "SFSM_leftStances"];
private _sideStep       = _stepRight || _stepLeft;

if(isNil "_shootingStance")exitWith{"No stance found" call dbgmsg;};

if(_coverStance isEqualTo _shootingStance)exitwith{
    [_man, "No stance-change in fipo"] spawn SFSM_fnc_flashAction;
};

private _timer = time + 1.2;

// Get out of "safe" stances
private _anim = _man getVariable "SFSM_idleAnim";
if!(isNil "_anim")then{
    [_man] call SFSM_fnc_abortIdleFipo;
};

// Sidesteps needs a different method.
if(_sideStep)exitWith{
    [
        _man, 
        _shootingStance,
        _coverStance
    ] 
    call SFSM_fnc_fipoSideStep;
};

//change to peeking(high) stance.
[_man, "Peeking"] call SFSM_fnc_setAction;
[_man, _shootingStance] call SFSM_fnc_animSetStance;


//wait for stance to complete.
waitUntil{
    ((_man getVariable ["SFSM_animStanceDone", false]) 
    || (time > _timer))
};

//Look for and engage enemies.
[_man, _peekTime] call SFSM_fnc_peekActions;

//exit script if man has left  the fighting position
if!([_man, "inFipo"] call SFSM_fnc_unitData)exitWith{};

//change to cover(low) stance.
[_man, _coverStance] call SFSM_fnc_animSetStance;

//wait for stance to complete.
_timer    = time+1.2;
_man attachTo [([_man] call SFSM_fnc_getFipo), [0,0,0]];
waitUntil{((_man getVariable ["SFSM_animStanceDone", false]) || (time > _timer))};
detach _man;

//define action and cooldown
[_man, "In cover"] call SFSM_fnc_setAction;
[_man, "peekCooldown", (time+_coolDown)] call SFSM_fnc_unitData;


// Sometimes ACE-medical messes things up, this fixes it.
private _noFipo = !([_man] call SFSM_fnc_inFipo);

if(_noFipo && {[_man] call SFSM_fnc_isUncon})exitWith{
    [_man, "none"] call SFSM_fnc_setAction;
};

if([_man] call SFSM_fnc_isUncon)then{
    [_man] call SFSM_fnc_getOutFipo
};


true;
};

SFSM_fnc_getSideStepAnim = { 
params[
    ["_unitPos",   nil,    [""]],
    ["_moveRight", true, [true]]
];
private _dirLetter = "r";
private _animBase  = "AmovPercMevaSrasWrflD";

if(_moveRight isEqualTo false)    then{_dirLetter = "l";};
if(_unitPos   isEqualTo "MIDDLE") then{_animBase = "AmovPknlMrunsraswrfld";};
if(_unitPos   isEqualTo "DOWN")   then{_animBase = "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflD";};

private _sideStepAnim = [_animBase, _dirLetter]joinString "";

_sideStepAnim;
};


SFSM_fnc_endFipoSideStep = { 
params[
    ["_man",         nil, [objNull]],
    ["_coverStance", nil,      [[]]]
];



//change to cover(low) stance.
[_man, _coverStance] call SFSM_fnc_animSetStance;

//wait for stance to complete.
private _animTimer     = time+1.2;
private _coolDownTimer = time + (3 + ceil(random 3));

_man attachTo [([_man] call SFSM_fnc_getFipo), [0,0,0]];
waitUntil{((_man getVariable ["SFSM_animStanceDone", false]) || (time > _animTimer))};
detach _man;

// Set action and cooldown.
[_man, "In cover"] call SFSM_fnc_setAction;
[_man, "peekCooldown", _coolDownTimer] call SFSM_fnc_unitData;

true;
};

SFSM_fnc_fipoSideStep = { 
params[
    ["_man",            nil, [objNull]],
    ["_shootingStance", nil,      [[]]],
    ["_coverStance",    nil,      [[]]]
];
private _mapVar        = _coverStance#1;
private _index         = _coverStance#0;
private _data          = (missionNamespace getVariable _mapVar) get _index;
private _coverAnim     = _data#0;
private _unitPos       = _data#1;
private _peekTime      = ([_man] call SFSM_fnc_fipoPeekTime)+0.1;
private _stepRight     = "right" in (_shootingStance#1);

[_man, "peekCooldown",           time+10]   call SFSM_fnc_unitData;
[_man, _unitPos, _stepRight,    _coverAnim] call SFSM_fnc_fipoSideStepStart;  sleep 2;
[_man, _peekTime]                           call SFSM_fnc_peekActions;
[_man, _unitPos, !(_stepRight), _coverAnim] call SFSM_fnc_fipoSideStepReturn; sleep 2;
[_man, _coverStance]                        call SFSM_fnc_endFipoSideStep;



true;
};


SFSM_fnc_execSideStepMid = { 
params[
    ["_man", nil, [objNull]]
];
private _fipoDir = _man getVariable "SFSM_fipoDir";
if(isNil "_fipoDir")exitWith{};
    
_man setDir _fipoDir;
[_man, "peekCooldown", time+5] call SFSM_fnc_unitData;

true;
};

SFSM_fnc_execSideStepEnd = { 
params[
    ["_man", nil, [objNull]]
];
private _fipoDir     = _man getVariable ["SFSM_fipoDir",    (getDirVisual _man)];
private _returnStep  = _man getVariable ["SFSM_returnStep",  false];
private _stepEndAnim = _man getVariable ["SFSM_stepEndAnim", (animationState _man)];

_man setDir _fipoDir;

if(_returnStep)then{[_man]spawn{params["_man"];
    sleep 1;
    [_man, "fipo-sidestep", false] call SFSM_fnc_unitData;
}};

[_man]                          call SFSM_fnc_fixPos;
[_man, "peekCooldown", time+10] call SFSM_fnc_unitData;

_man setVariable ["SFSM_ignoreFipo",  nil];
_man setVariable ["SFSM_returnStep",  nil];
_man setVariable ["SFSM_stepEndAnim", nil];
_man setVariable ["SFSM_fipoDir",     nil];

_man setDir _fipoDir;
_man enableAI "anim";
_man enableAI "move";
_man enableAI "fsm";

true;
};

SFSM_fnc_execSideStep = { 
params[
    ["_man",          nil, [objNull]],
    ["_anim",         nil,      [""]],
    ["_returnStep", false,   [false]]
]; 
private _fipo      = [_man] call SFSM_fnc_getFipo;
private _speedCoef = getAnimSpeedCoef _man;
if(isNil "_fipo")exitWith{};
if(_speedCoef > 1)then{_man setAnimSpeedCoef 1;};

private _fipoDir   = getDirVisual _fipo;
private _anims     = [_anim];//, _anim
private _endAnim   = animationState _man;
private _condition = { true };
private _midFnc    = {[_man] call SFSM_fnc_execSideStepMid;};

_man setVariable ["SFSM_ignoreFipo",   true];
_man setVariable ["SFSM_fipoDir",     _fipoDir];
_man setVariable ["SFSM_returnStep",  _returnStep];
_man setVariable ["SFSM_stepEndAnim", _endAnim];


_man setDir _fipoDir;
_man disableAI "anim";
_man disableAI "move";
_man disableAI "fsm";

private _time = time + 5;
[_man, _anims, true, _condition, _midFnc/*, _endFnc*/] call  SFSM_fnc_playAnimList;
waitUntil {
    sleep 0.5;
    private _velocity = velocityModelSpace _man;
    (_velocity isEqualTo [0,0,0]
  ||{time > _timer});
};

[_man] call SFSM_fnc_execSideStepEnd;

true; 
};



SFSM_fnc_fipoSideStepStart = { 
params[
    ["_man",       nil, [objNull]],
    ["_unitPos",   nil,      [""]],
    ["_stepRight", nil,    [true]]
]; 

private _anim     = [_unitPos, _stepRight] call SFSM_fnc_getSideStepAnim;
private _idleAnim = _man getVariable "SFSM_idleAnim";

if!(isNil "_idleAnim")
then{[_man] call SFSM_fnc_abortIdleFipo;};

[_man, "fipo-sidestep", true] call SFSM_fnc_unitData;
[_man, "Peeking sidestep"]    call SFSM_fnc_setAction;
[_man, _anim]                 call SFSM_fnc_execSideStep;

true;
};


SFSM_fnc_fipoSideStepReturn = { 
params[
    ["_man",       nil, [objNull]],
    ["_unitPos",   nil,      [""]],
    ["_stepRight", nil,    [true]]
];
private _anim = [_unitPos, _stepRight] call SFSM_fnc_getSideStepAnim;

[_man, "Return sidestep"] call SFSM_fnc_setAction;
[_man, _anim, true]       call SFSM_fnc_execSideStep;


true;
};



// copyToClipboard str ([f1] call SFSM_fnc_fipoStanceIndexes);

/************************************************************************************/
systemChat "devFile read";