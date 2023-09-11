// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_leader", "_group"];
if!((side _group) in [east, west, independent])exitWith{objNull};


private _battle       = [_group, "currentBattle"] call SFSM_fnc_groupData;
private _lastSpotting = [_group, "lastSpotting"]  call SFSM_fnc_groupData;

if(isNil "_battle")             exitWith{objNull};
if!(_battle == "none")         exitWith{objNull};
if(time - _lastSpotting < 30)exitWith{objNull};
if(!alive _leader)             exitWith{objNull};

private _currentEnemy   = _leader findNearestEnemy _leader;
private _knowledge      = _leader knowsAbout _currentEnemy;
private _lastKnownEnemy = _group getVariable "SFSM_lastKnownEnemy";


_group setVariable["lastKnownEnemy", _currentEnemy];

if(isNull _currentEnemy)                  exitWith{objNull};
if!(_group knowsAbout _currentEnemy > 0)  exitWith{objNull}; 
if!(_currentEnemy isKindOf "land")          exitWith{objNull};
if((count crew _currentEnemy)<1)          exitWith{objNull};
if(_currentEnemy == _lastKnownEnemy)      exitWith{objNull};
if(_currentEnemy distance2D _leader > 600)exitWith{objNull};
if(_knowledge < SFSM_KnowledgeToFight)    exitWith{objNull};

 [_group, "lastSpotting", time] call SFSM_fnc_groupData;

"Enemy spotted" call dbgmsg; 

_currentEnemy;