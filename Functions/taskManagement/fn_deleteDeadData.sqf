// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

{
    private _data = _x getVariable "SFSM_UnitData";
    private _killTime = _x getVariable "SFSM_killTime";
    private _valid = ((!isNil "_data")
                   &&{(!isNil "_killTime")
                   &&{(time-_killTime)>300}});
    if(_valid)
    then{
          _x setVariable ['SFSM_killTime', nil, true];
          _x setVariable ['SFSM_UnitData', nil, true];
          _x setVariable ['SFSM_Killer',   nil, true];
    };
    
} forEach alldeadMen;