// if(time < 3)exitWith{"Exited devfile" call dbgmsg;};

systemChat "devFile found";
// SFSM_fnc_
// SFSM_Custom3Dpositions = [[_pos, "string"]];
// SFSM_customExpression = "";
// [165, 42, 42] call SFSM_fnc_rgbColorToA3Color
// [player] call SFSM_fnc_distanceToFooting
// [_man] call SFSM_fnc_availableAiSoldier;
// [_man, _anims, false, _condition, _midFnc, _postFnc] call SFSM_fnc_playAnimList;
// [true] call SFSM_fnc_getActiveScripts;


/************************************************************************************/


{
	private _data = _x getVariable "SFSM_vzData";
	// _data set ["activate", SFSM_fnc_unVirtualizeZone];
	// _data set ["activate", SFSM_fnc_unVirtualizeZone];
	
} forEach entities "SFSM_VZ";


player allowDamage false;
[aaa, player] call SFSM_fnc_evasiveAttack;

// copyToClipboard str allVariables VZ_1;

/************************************************************************************/
systemChat "devFile read";