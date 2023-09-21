params[
    ["_fipoList", SFSM_fipositions]
];
if(_fipoList isEqualTo [])     exitWith{};
if(!isNil "SFSM_fipoAssigner") exitWith{};

SFSM_fipoAssigner = true;

private _startTime    = time;
private _squadLeaders = (allGroups apply {leader _x})select{[_x] call SFSM_fnc_isRealMan};
private _excludedMen  = [];
{
    if([_x] call SFSM_fnc_fipoAvailable)
    then{
            private _assignedMan = [_x, _squadLeaders, _excludedMen] call SFSM_fnc_assignFipo;
			if(alive _assignedMan)then{_excludedMen pushBackUnique _assignedMan;};
    };
    
} forEach _fipoList;

if(SFSM_debugger
&&{(count _excludedMen) > 0})then{
    private _timeSpent = round (time - _startTime);
    private _msg       = ["Assigned ", (count _excludedMen), " men to Fighting-Positions in ", _timeSpent, "s"];
    [_msg, 1] call dbgmsg;
};


if(_fipoList isEqualTo SFSM_activeAzFipos)
then{
    private _timeSpent = round (time - _startTime);
    private _msg = ["Processed ", (count _fipoList), " AZ-Fighting-Positions in ", _timeSpent, "s"];
    [_msg, 1] call dbgmsg;
    SFSM_activeAzFipos = [];
};

SFSM_fipoAssigner = nil;

true;