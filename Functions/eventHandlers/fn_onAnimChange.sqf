params  ["_man", "_anim"];
private _animForced     = false;
private _unitData       = _man getVariable "SFSM_UnitData";
private _animListParams = _man getVariable "SFSM_animListParams";
private _animChanges    = _unitData get "animChangeMove";
private _count          = count _animChanges;

if(!isNil "_animListParams")              then{_animForced = true;};
if([_x, "inFipo"] call SFSM_fnc_unitData) then{_animForced = true;};


private _moveData = [
    round time,
    ([getPosATLVisual _man] call Tcore_fnc_roundPos),
    _animForced
];

_animChanges pushBack _moveData;
if(_count > 30)then{_animChanges deleteAt 0;};

_unitData set ["animChangeMove", _animChanges] ;

true;