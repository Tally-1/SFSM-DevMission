// private _script = ExecVM 'DevFile.sqf';
// waitUntil{scriptDone _script};
// [] call SFSM_fnc_init;

Tally_Dev    = true;
dbgCamActive = false;

["suppressing_now", {
params["_shooter","_target"];
// [_shooter] call dbg_cam;

}] call CBA_fnc_addEventHandler;


dbg_cam = { 
params["_man"];
    if(isNull (findDisplay 312))      exitwith{};
    if([_man] call SFSM_fnc_isPlayer) exitwith{};
	if(dbgCamActive)                  exitwith{};
	dbgCamActive = true;

    private _cam = "camera" camCreate (_man modelToWorld [0, 100, 10]);
    _cam camSetTarget _man;
    _cam camSetRelPos [0, 10, 10];
    _cam cameraEffect ["internal", "back"];
    _cam camCommit 0.1;
    sleep 1;
    _cam cameraEffect ["terminate","back"];
    private _camPos = getPosASLVisual _cam;
    private _vd = vectorDir _cam;
    private _vu = vectorUp _cam;
    camDestroy _cam;
    findDisplay 312 closeDisplay 2;
    curatorCamera setPosASL _camPos;//([getPosASLVisual _man,10] call Tcore_fnc_Addz);
    curatorCamera setVectorDirAndUp [_vd, _vu];
    sleep 0.01;
    openCuratorInterface;
	sleep 3;
	dbgCamActive = false;
};