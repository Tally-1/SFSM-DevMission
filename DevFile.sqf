systemChat "devFile found";
// SFSM_fnc_
// SFSM_Custom3Dpositions = [];
// SFSM_customExpression = "";
// [165, 42, 42] call SFSM_fnc_rgbColorToA3Color
// [player] call SFSM_fnc_distanceToFooting
// [_man] call SFSM_fnc_availableAiSoldier;
// [_man, _anims, false, _condition, _midFnc, _postFnc] call SFSM_fnc_playAnimList;
// [true] call SFSM_fnc_getActiveScripts;
// [false, true, true] spawn SFSM_fnc_animListData;
// SFSM_moveAnims call ["animEndPos", ["sprint-front", player, nil, 3]];
/************************************************************************************/

// SFSM_fnc_keepMoving = { 

// };


SFSM_fnc_splitArr = { 
params["_array", "_splitCount"];
private _arrCount   = count _array;
private _elPrArr    = floor (_arrCount / _splitCount);
private _wholeCount = _elPrArr*_splitCount;
private _remaining  = _arrCount % _wholeCount;

private _splitArr = [];
private _index    = 0;
for "_i" from 0 to (_splitCount-1) do {
	private _newArr = _array select [_index, _elPrArr];
	_splitArr pushBack _newArr;
	_index = _index + _elPrArr;
};

if(_remaining > 0)then{
	private _newArr = _array select [_index, _remaining];
	_splitArr pushBack _newArr;
};

_splitArr;
};



SFSM_fnc_AssigAllFipos = { 
private _allfipos  = [SFSM_allfipos, 4] call SFSM_fnc_splitArr;
private _threads   = [];
private _startTime = time;

{
	private _script = [_x, true] spawn SFSM_fnc_fipoAssigner;
	_threads pushBack _script;
} forEach _allfipos;

waitUntil { sleep 1; [_threads] call SFSM_fnc_threadsFinished;};

private _timeSpent = round (time - _startTime);
private _msg = ["Processed All FIPOS in ", _timeSpent, "s"];
[_msg, 1] call dbgmsg;

true;
};






// [] spawn SFSM_fnc_unitToFipoAssigner;

// SFSM_fnc_forceMoveToPos2 = { 

// };
// [true] call SFSM_fnc_getActiveScripts;
// private _pos = getPosATLVisual player;
// [cc, _pos] spawn SFSM_fnc_forceMoveToPos2;

/************************************************************************************/
systemChat "devFile read";