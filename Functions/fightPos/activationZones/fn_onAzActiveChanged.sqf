_this call SFSM_fnc_handleAZfipos;
["activation_zone_status_changed", _self] call CBA_fnc_localEvent;
true;