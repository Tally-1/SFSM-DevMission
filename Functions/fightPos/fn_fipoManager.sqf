if(!isNil "SFSM_fipoOn")exitWith{};
SFSM_fipoOn = true;

sleep 3;

if(SFSM_fipositions isEqualTo [])exitWith{SFSM_fipoOn = nil;};

[] spawn SFSM_fnc_fipoFSM;
// forever loop, priority is put on the activation Zone FIPOS (Newest feature)
while {sleep 1; true} do {
   for "_i" from 1 to 3 do
   {[] call SFSM_fnc_handleActivationZones; sleep 1;};
   [] call SFSM_fnc_fipoAssigner;
};