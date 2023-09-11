//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_battlefield"];
private _minRadius        = (_battlefield get "radius")/4;
private _zones            = createHashmap;
private _clusterPositions = _battlefield get "clusterPositions";
private _center           = _battlefield get "center";

private _westPositions = _clusterPositions get "west";
private _eastPositions = _clusterPositions get "east";
private _guerPositions = _clusterPositions get "independent";


private _westZone    = [_westPositions, _minRadius] call SFSM_fnc_getZone;
private _eastZone    = [_eastPositions, _minRadius] call SFSM_fnc_getZone;
private _guerZone    = [_guerPositions, _minRadius] call SFSM_fnc_getZone;

_zones set ["west",        _westZone];
_zones set ["east",        _eastZone];
_zones set ["independent", _guerZone];

_zones;