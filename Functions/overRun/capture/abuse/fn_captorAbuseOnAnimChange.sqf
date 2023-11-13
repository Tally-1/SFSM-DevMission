params["_man"];
(_man getVariable "SFSM_animListParams")
params [
	"_animArr", 
	"_waitForCompletion", 
	"_condition", 
	"_midFnc", 
	"_postFnc", 
	"_index", 
	"_startTime", 
	"_timer", 
	"_eh"
];
private _victim     = _man getVariable "SFSM_myExecVictim";
private _nextAnim   = _animArr#(_index+1);
private _victimAnim = [_nextAnim] call SFSM_fnc_captorAbuseMirrorAnim;

if(!isNil "_victimAnim")
then{
	[_victim, _victimAnim]remoteExecCall["playMoveNow", _victim];

	if(_victimAnim isEqualTo "acts_executionvictim_kill")
	then{[_victim, "Acts_executionvictim_Loop"]remoteExecCall["playMove", _victim]};
};


if(_nextAnim isEqualTo "acts_executioner_kill")then{
	[_man, _victim] spawn SFSM_fnc_executionerKillshot;
};

true;