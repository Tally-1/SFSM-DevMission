private _fipo     = _self get "module";
private _entities = (_self get "position") nearEntities SFSM_fipoGetInDistance;
private _units    = _entities select {[_x, _fipo] call SFSM_fnc_canMoveInFipo;};


_units;