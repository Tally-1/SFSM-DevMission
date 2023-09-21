if(!isNil "SFSM_fipoOn")exitWith{};
SFSM_fipoOn = true;

sleep 3;

if(SFSM_fipositions isEqualTo [])exitWith{SFSM_fipoOn = nil;};

[] spawn SFSM_fnc_fipoFSM;
// forever loop, priority is put on the activation Zone FIPOS (Newest feature)
while {sleep 1; true} do {
   [true] call SFSM_fnc_handleActivationZones;
   [] call SFSM_fnc_fipoAssigner;
   [SFSM_activeAzFipos] call SFSM_fnc_fipoAssigner;
};