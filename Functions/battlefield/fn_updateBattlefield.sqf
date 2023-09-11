//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ['_battleField'];
if(isNil "_battleField")exitWith{"Battlefield nil, cannot update" call SFSM_fnc_debugMessage; true};

private _action   = _battlefield get "currentAction";

if(_action isNotEqualTo "none") exitWith{
                                    "Could not update battlefield " call dbgmsg; 
                                    false;
                                };

_battlefield set ["currentAction",    "updating"];

private _markers   = _battlefield get "markers"; 
private _centerPos = _battlefield get "center";
private _radius    = _battlefield get "radius";
private _sides     = [east, west, independent];
private _battleKey = (str _centerPos);
private _areaName  = (_battlefield get "name");


//update all data related to unitClusters.
private _clustersData = [
                            _centerPos,    // center of area
                            _sides,     // sides
                            true,        // return all data
                            _radius,    // AreaRadius
                            50,            // ClusterRadius
                            2,            // height of returned positions (AGL)
                            false        // include terrainObjects
                        ] call Tcore_fnc_allClustersInRadius;

private _unitFilter = { 

    private _action = [_x, "action"] call SFSM_fnc_unitData;

    (!(_x getVariable ["SFSM_Excluded",false]))
    &&{(typeOf _x) == (typeOf (vehicle _x))
    &&{!isNil "_action"}}

    };


private _mapObjsData = missionNamespace getVariable (_battleField get "mapObjects");
private _groups      = [_clustersData]       call Tcore_fnc_clusterGroups;
private _units       = [_clustersData]       call Tcore_fnc_clusterUnits select _unitFilter;
private _vehicles    = [_clustersData]       call Tcore_fnc_clusterVehicles;
private _deadMen     = allDeadMen select {_centerPos distance2D _x < _radius;}; //missionNamespace getVariable (_battleField get "deadMen");


if(SFSM_simpleBff isEqualTo true
&&{isNil "_mapObjsData"})then{
    _mapObjsData = createHashmap
};

{
    if(((getPosATL _x)#2)<-1)then{
    private _pos = getPosASL _x;
    _x setPos [_pos#0,_pos#1, 0.2];
}} forEach _deadMen;

// (str (count _deadMen))call dbgmsg;
private _weapons  = nearestObjects [_centerPos, ["WeaponHolder", "WeaponHolderSimulated"], _radius];
private _supplies = _centerPos nearSupplies _radius;
//see comments at Fn_initBattlefield.sqf
[
    _centerPos, 
    _radius, 
    _battlefield, 
    _clustersData, 
    _mapObjsData, 
    false, 
    true
] call SFSM_fnc_areaData;


//store the variables that are not included in the "battlefield"-hashmap itself.
[
    _battlefield, 
    _clustersData, 
    _weapons,
    _units,
    _deadMen,
    _vehicles, 
    _groups, 
    _areaName, 
    _mapObjsData,
    _supplies
] call SFSM_fnc_battlefieldVariables;



//zones refer to the average position of each side involved in the fight, 
//the radius of the zone is defined by the distance of the 2 units the furthes away from eachother.
//the zones are used to retrieve cover-positions
_battlefield set ["zones", ([_battlefield] call SFSM_fnc_getZones)];

if(SFSM_simpleBff isEqualTo false)then{[_battlefield] call SFSM_fnc_getCoverPositionsLight;};
// [_battlefield] call SFSM_fnc_updateHunkerObjects;

{
    [_x, "currentBattle", _battleKey] call SFSM_fnc_unitData;
    [_x, _battleField] call SFSM_fnc_reactToVehicles;
} forEach _units;

{[_x, "currentBattle", _battleKey] call SFSM_fnc_vehicleData;} forEach _vehicles;


{[_x, "currentBattle", _battleKey] call SFSM_fnc_groupData} forEach _groups;
{deleteMarker _x} forEach _markers;
[_battlefield] call SFSM_fnc_bfDebugMarkers;


_battlefield set ["lastDataUpdate", time];
_battlefield set ["currentAction",    "none"];

private _battleOver = [_battlefield] call SFSM_fnc_battleEnded;

if(_battleOver)exitWith{
    ["battle_ended", _battlefield] call CBA_fnc_localEvent;
    [_battleKey] call SFSM_fnc_battlefieldEnd; 
    true;
};

["battle_updated", _battlefield] call CBA_fnc_localEvent;
_battleOver;