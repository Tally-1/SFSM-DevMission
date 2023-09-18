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

SFSM_fnc_availAzFipoUnits={
private _fipo     = _self get "module";
private _entities = (_self get "position") nearEntities SFSM_fipoGetInDistance;
private _units    = _entities select {[_x, _fipo] call SFSM_fnc_canMoveInFipo;};


_units;
};

SFSM_fnc_azFipoActions = { 
params["_excludedMen"];
// Move out current fipo-man if azFipo is no longer active.
if(!isNull (_self get "owner"))
exitWith{
    _self call ["getOut"]; 
    objNull;
};

if(isNil "_excludedMen")then{_excludedMen = [];};

private _module = _self get "module";
private _units  = allunits select {[_x] call SFSM_fnc_availableAiSoldier && {!(_x in _excludedMen)}};//(_self call ["availUnits"]) select {!(_x in _excludedMen)};
if(_units isEqualTo [])exitWith{
    [_module, "Nobody could be assigned"] spawn SFSM_fnc_flashFipoText;
    objNull;
};

private _man = [_module, _units] call SFSM_fnc_getNearest;

[_man, _module] spawn SFSM_fnc_moveInFipo;

[_module, "Man assigned", [0,1,0,1]] spawn SFSM_fnc_flashFipoText;

_man;
};

SFSM_fnc_handleAzFipos = { 
_self set ["last_fipo_handling", time];

[_self]spawn{
params["_self"];

private _azFipos     = ((_self get "fipos") apply {_x getVariable "azFipoData"}) select {(_x get "active_actions") isEqualTo false};
private _assignedMen = [];

{
    private _man = _x call ["fipoActions", [_assignedMen]];
    _x set ["active_actions", true];
    if((!isNil "_man")
    &&{!isNull _man})then{
    _assignedMen pushBackUnique _man;
    _x set ["active_actions", false];
}} forEach _azFipos;

true;
}};


/************************************************************************************/

systemChat "devFile read";