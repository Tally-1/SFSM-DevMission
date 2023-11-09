// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man", "_turret", "_forceLeave"];
private _leader      = leader (group _man);
private _turret      = vehicle _man;
// private _battleKey   = [_man, "currentBattle"] call SFSM_fnc_unitData;
// private _battlefield = SFSM_battles get _battleKey;

if(_forceLeave)                                        exitwith{false;};
if(_man isEqualTo _leader)                             exitwith{false;};
if(_turret isEqualTo _man)                             exitwith{false;};
if(!canFire _turret)                                   exitwith{false;};
if(damage _turret > 0.9)                               exitWith{false;};
// if(isNil "_battlefield")                               exitWith{false;};
if(_turret distance2D _leader > SFSM_turretLeaderDist) exitwith{false;};

private _enemy = _man findNearestEnemy _man;
if(isNil "_enemy")exitWith{true;};

if(SFSM_overRun isEqualTo true
&&{[_man, _enemy] call SFSM_fnc_validEnemy isEqualTo true 
&&{_enemy distance2D _man < SFSM_overRunDistance}})     exitwith{false;};

true;