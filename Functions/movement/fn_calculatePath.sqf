// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3
private _timeLimit = 10;
params["_man", "_destination", "_timeLimit"];

private _start = getPos _man;
private _timer = time + _timeLimit;
private _agent = (calculatePath ["man", (behaviour _man), _start, _destination]);

_agent setVariable ["SFSM_pathOwner", _man];

[_agent] call SFSM_fnc_PathCalculated;
private _path = _man getVariable "SFSM_currentPath";

waitUntil {
    sleep 0.1;
    _path = _man getVariable "SFSM_currentPath";
    (!isNil "_path") || (_timer < time);
};

if(isNil "_path"
&&{!isNull _agent})
exitWith{deleteVehicle _agent;};

private _nPath = [];
{
    private _pos = ASLToATL _x;
    if((_pos#2)<0)then{_pos = [_pos#0,_pos#1,0]};
    _nPath pushBackUnique _pos;
} forEach _path;

_man setVariable ["SFSM_currentPath", _nPath]; 

// private _k = 0;
// SFSM_Custom3Dpositions = _nPath apply {_k=_k+1;[_x, str round (_x#2)]};


deleteVehicle _agent;

true;