params ["_man"];
sleep 1;
if(animationState _man isNotEqualTo "acts_executionvictim_loop")then{
	_man playMoveNow "Acts_executionvictim_Loop";
	[_man, "Captured"] call SFSM_fnc_setAction;
};
for "_i" from 1 to 30 do {
	sleep 10;
};

_man setDamage 1;

true;