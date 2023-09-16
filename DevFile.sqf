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


SFSM_fnc_getAzFipos = { 
params["_activationZone"];
private _azFipos = [];
{
    if(typeOf _x isEqualTo "SFSM_FIPO")then{
        _azFipos pushBack _x;
        _x setVariable ["AZ_FIPO", true, true];
    };
    
} forEach (synchronizedObjects _activationZone);

_azFipos;
};



SFSM_fnc_initFIPOsAndAZs = { 
private _fipos           = [];
private _activationZones = [];
private _azFipos         = [];

{
    if(typeOf _x isEqualTo "SFSM_FIPO")
    then{_fipos pushBack _x};

    if(typeOf _x isEqualTo "SFSM_AZ")then{
    private _connectedFipos = [_x] call SFSM_fnc_getAzFipos;
    _azFipos append _connectedFipos;
    _activationZones pushBack _x;
    };

} forEach (entities "logic");
 
{[_x] call SFSM_fnc_initFipo} forEach _fipos;

SFSM_fipositions = _fipos select {(_x in _azFipos) isEqualTo false;};
SFSM_azFIPOs     = _azFipos         apply {[_x] call SFSM_fnc_initAzFipo;};;



true;
};


SFSM_fnc_initActivationZones = { 
params["_zones"];
private _initializedZones = _zones apply {[_x] call SFSM_fnc_initAz;};
private _sorted = [_initializedZones, [], {_x get "mode_code"}, "ASCEND"] call BIS_fnc_sortBy;
SFSM_activationZones = _sorted;

true;
};


SFSM_fnc_initAzFipo = { 
params["_fipo"];
private _activationZones = (synchronizedObjects _fipo) select {typeOf _x isEqualTo "SFSM_AZ"};
private _sides           = [_fipo] call SFSM_fnc_fipoDefineSides;
private _pos             = getPosATLVisual _fipo;

private _objData = [ 
/*---------------Settings--------------*/
    ["#type",       "fipo-activation-zone"],
    ["#flags", [/*"unscheduled",*/"sealed"]],
    ["#noCopy",     true],

/*----------------Values---------------*/
    ["module",           _fipo],
    ["activation_zones", _activationZones],
    ["sides",            _sides],
    ["position",         _pos],
    ["owner",            objNull],
/*----------------Methods--------------*/
    ["availUnits",  SFSM_fnc_availAzFipoUnits],
    ["moveInMan",   SFSM_fnc_moveInAzFIPO],
    ["isAvailable", SFSM_fnc_moveInAzFIPO]
];

private _azFipo = createHashMapObject [_objData];

_fipo setVariable ["azFipoData", _azFipo];

_azFipo;
};

SFSM_fnc_moveInAzFIPO =

SFSM_fnc_availAzFipoUnits = { 
private _fipo     = _self get "module";
private _entities = (_self get "position") nearEntities SFSM_fipoGetInDistance;
private _units    = _entities select {[_x] call SFSM_fnc_canMoveInFipo;};


_units;
};


SFSM_fnc_getAzSides = { 
params["_activationZone"];
private _sides = [];

if(_activationZone getVariable "activatedByEast")        then{_sides pushBack east;};
if(_activationZone getVariable "activatedByIndependent") then{_sides pushBack independent;};
if(_activationZone getVariable "activatedByWest")        then{_sides pushBack west;};

if(_sides isEqualTo [])then{[["Error: ActivationZone with no sides allowed detected"],2] call dbgmsg;};

_sides;
};


// [20, 40, 345.195, true, 20]
// positions inAreaArray [center, a, b, angle, isRectangle, c]

SFSM_fnc_getAzArea = { 
params["_activationZone"]; (_activationZone getVariable "objectarea")
params["_a", "_b", "_angle", "_isRectangle", "_c"]; 
private _center = getPos _activationZone;
private _area   = [_center, _a, _b, _angle, _isRectangle, _c];

_area;
};

SFSM_fnc_validAzUnit = { 
params["_entity"];

if!(_entity inArea (_self get "area"))     exitWith{false;};
if!((side _entity) in (_self get "sides")) exitWith{false;};
if!([_entity] call SFSM_fnc_functionalMan) exitWith{false;};


true;
};

SFSM_fnc_getUnitsInAz = { 
private _entities = (_self get "position") nearEntities (_self get "radius");
private _units = _entities select {[_x] call SFSM_fnc_validAzUnit;};


_units;
};



SFSM_fnc_updateAz = { isNil{

private _units     = _self get "units";
private _status    = _self get "active";
private _newUnits  = _self call ["getUnits"];
private _activeNow = (_newUnits isNotEqualTo []);

if(_units isEqualTo _newUnits)exitWith{};

_self set ["units", _newUnits];

if(_activeNow isEqualTo _status)exitWith{};

_self set ["active", _activeNow];

_self call ["onActiveChanged"];


}};



SFSM_fnc_onAzActiveChanged = { 




["activation_zone_status_changed", _self] call CBA_fnc_localEvent;
true;
};



SFSM_fnc_initAz = { 
params["_activationZone"];

private _activationSides = [_activationZone] call SFSM_fnc_getAzSides;
private _fipos           = [_activationZone] call SFSM_fnc_getAzFipos;
private _knowledge       = 4 * (_activationZone getVariable "activationknowledge");
private _pos             = getPosATLVisual _activationZone;
private _area            = [_activationZone] call SFSM_fnc_getAzArea;
private _radius          = (selectMax [(_area#0), (_area#1)])*2;
private _modeInt         = _activationZone getVariable "type";
private _mode            = "activate";


if(_modeInt isEqualTo 1)then{_mode = "deactivate";};


private _objData = [ 
/*---------------Settings--------------*/
    ["#type",       "fipo-activation-zone"],
    ["#flags", [/*"unscheduled",*/"sealed"]],
    ["#noCopy",     true],

/*----------------Values---------------*/
    ["module",    _activationZone],
    ["sides",     _activationSides],
    ["knowledge", _knowledge],
    ["fipos",     _fipos],
    ["position",  _pos],
    ["area",      _area],
    ["radius",    _radius],
    ["units",     []],
    ["active",    false],
    ["mode",      _mode],
    ["mode_code", _modeInt],

/*----------------Methods--------------*/
    ["getUnits",        SFSM_fnc_getUnitsInAz],
    ["update",          SFSM_fnc_updateAz],
    ["onActiveChanged", SFSM_fnc_onAzActiveChanged]
];

private _az = createHashMapObject [_objData];

_az;
};

az1_obj = [az1] call SFSM_fnc_initAz;
systemChat str (az1_obj call ["update"]);
// hint az1_obj;
// copyToClipboard str az1_obj;

// [m1, f2] call SFSM_fnc_canMoveInFipo;

systemChat "devFile read";