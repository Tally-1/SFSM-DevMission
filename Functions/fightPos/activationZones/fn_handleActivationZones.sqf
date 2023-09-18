isNil{//Forced unscheduled execution.

{_x call ["update"];} forEach SFSM_activationZones;
private _filter     = {time - (_x get "last_fipo_handling")>10};
private _needsCheck = SFSM_activationZones select _filter;

{_x call ["onSidesChanged"];} forEach _needsCheck;

};