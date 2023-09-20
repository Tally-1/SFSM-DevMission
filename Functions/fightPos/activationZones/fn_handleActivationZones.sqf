private _azFipos = [];

isNil{//Forced unscheduled execution.

//Men leaves outflanked, and inactive azFipos
{_x call [["getOut"]]} forEach SFSM_azFIPOs;

// The update will return fipos if the zone is populated.
{_azFipos append (_x call ["update"])} forEach SFSM_activationZones;

// Just in case some of these has not been updated for 2 minutes a check is done anyway.
private _filter     = {time - (_x get "last_fipo_handling") > 120};
private _checkZones = SFSM_activationZones select _filter;
private _checkFipos = _checkZones apply {_x get "fipos";};

{_azFipos insert [0, _x, true];} forEach _checkFipos;

{_x set ["last_fipo_handling", time];} forEach _checkZones;

};

if(_azFipos isNotEqualTo [])
then{[_azFipos] call SFSM_fnc_fipoAssigner;};

true;