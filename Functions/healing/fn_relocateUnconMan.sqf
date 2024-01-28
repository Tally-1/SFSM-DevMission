params[
	["_healer",      nil, [objNull]],
	["_unconscious", nil, [objNull]],
	["_timer",       nil,       [0]]
]; 

private _relocatePos = [_healer, _unconscious] call SFSM_fnc_dragPos;
if (isNil "_relocatePos")exitWith{false;};

private _throwDir = [(windDir -180)]     call Tcore_fnc_formatDir;
private _smokeOut = [_healer, _throwDir] call SFSM_fnc_deploySmoke;
[_healer, _unconscious, _relocatePos]    call SFSM_fnc_dragMan;

true;