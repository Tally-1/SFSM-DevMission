// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_group", "_forceLeave"];

{
    if([_x] call SFSM_fnc_isRealMan
    &&{[_x, "action"] call SFSM_fnc_unitData isEqualTo "Manning turret!"})then{

       [_x, _forceLeave] call SFSM_fnc_turretGetOut;
    };
    
} forEach (units _group);

true;