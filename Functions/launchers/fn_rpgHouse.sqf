// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params[
    ["_man",      nil, [objNull]],
    ["_building", nil, [objNull]]
];

private _launchPos   = [_man, _building] call SFSM_fnc_getRpgLaunchPos;


if(isNil "_launchPos")exitWith{[_man, "RPG on house failed"] call SFSM_fnc_flashAction;};


[_man, _building, _launchPos] call SFSM_fnc_initRpgHouse;
[_man, _building, _launchPos] call SFSM_fnc_moveToRpgLaunchPos;

if!([_man, true] call SFSM_fnc_canRun)exitWith{[_man, false] call SFSM_fnc_endRpgHouse;};

private _canShoot = [_man, _building] call SFSM_fnc_atValidRpgFirePos;
if!(_canShoot)exitWith{[_man, false]  call SFSM_fnc_endRpgHouse;};

[_man, _building] call SFSM_fnc_fireLauncherAtHouse;

true;