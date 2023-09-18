params["_side"];
private _sides  = (_self get "sides_present");
private _filter = {_x in [east, west, independent] 
               && {([_side, _x] call BIS_fnc_sideIsFriendly) isEqualTo false;}};
private _hostileSides = _sides select _filter;

// systemChat str [_sides, _hostileSides];

if(_hostileSides isEqualTo [])exitWith{false;};

true;