params ["_man", "_captor"];
if!([_man] call SFSM_fnc_isUncon)exitWith{};

[_man, false] call ace_medical_fnc_setUnconscious;
[_captor, _man] call ace_medical_treatment_fnc_fullHeal;
[_man] call SFSM_fnc_surrender;

true;