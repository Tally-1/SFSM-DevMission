isNil{//forced unscheduled execution
private _sides     = [];
private _units     = _self get "units";
private _status    = _self get "active";
private _newUnits  = _self call ["getUnits"];
private _activeNow = (_newUnits isNotEqualTo []);

if(_units isEqualTo _newUnits)exitWith{ call dbgmsg;};
// systemChat "New units";
{_sides pushBackUnique (side _x);}forEach _newUnits;

_self set ["sides_present", _sides];
_self set ["units",         _newUnits];

if(_activeNow isEqualTo _status)exitWith{};
// systemChat "Status changed";
_self set ["active", _activeNow];

_self call ["onActiveChanged"];

};//Unscheduled execution ended...