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
/*
Current Tasks:
private _courage = 0.1;
private _coef    = 0.5/_courage;
private _time    = 10;
_time * _coef;
*/


/*
 * Argument:
 * 0: Action name <STRING>
 * 1: Name of the action shown in the menu <STRING>
 * 2: Icon <STRING>
 * 3: Statement <CODE>
 * 4: Condition <CODE>
 * 5: Insert children code <CODE> (Optional)
 * 6: Action parameters <ANY> (Optional)
 * 7: Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
 * 8: Distance <NUMBER> (Optional)
 * 9: Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
 * 10: Modifier function <CODE> (Optional)
 */
/*
 * Argument:
 * 0: Object the action should be assigned to <OBJECT>
 * 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
 * 2: Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
 * 3: Action <ARRAY>
 */

SFSM_fnc_addAceAction = { 
params[
	["_object",      nil,               objNull], // Object the action should be assigned to <OBJECT>
	["_actionName",  nil,                 ""],    // Action name <STRING>
	["_displayName", nil,                 ""],    // Name of the action shown in the menu <STRING>
	["_statement",   {},                  {}],    // Statement <CODE>
	["_condition",   {true},              {}],    // Condition <CODE>
	["_icon",        "",                  ""],    // Icon <STRING>
	["_actionType",  0,                   0 ],    // Type of action, 0 for actions, 1 for self-actions <NUMBER>
	["_parentPath",  ["ACE_SelfActions"], []]     // Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
];

private _action = [
	_actionName,
	_displayName,
	_icon,
	_statement,
	_condition
] call ace_interact_menu_fnc_createAction;

[
	_object,
	_actionType,
	_parentPath,
	_action

] call ace_interact_menu_fnc_addActionToObject;

_action;
};

// [
// 	player,
// 	"SFSM_testAction",
// 	"Test action",
// 	{hint "Hello Altis!"}

// ] call SFSM_fnc_addAceAction;

private _baseCategory = [
	"baseCategory",
	"Frontlines",
	"",
	{},
	{true}
] call ace_interact_menu_fnc_createAction;
[
	player,
	0,
	["ACE_SelfActions"],
	_baseCategory

] call ace_interact_menu_fnc_addActionToObject;

_condition = {
    true;//(!pabst_radioFinder_on) && {(backpack _player) in pabst_radioFinder_backpacks} && {[_player, _target, []] call ace_common_fnc_canInteractWith}
};
_statement = {
    hint "Control";//[true] call pabst_fnc_radioFinder_action;
};
_action = [
	"Open RDF",
	"Radio Direction Finder",
	"",
	_statement,
	_condition

] call ace_interact_menu_fnc_createAction;

[
	player, 
	1, 
	["ACE_SelfActions", "baseCategory"], 
	_action

] call ace_interact_menu_fnc_addActionToObject;



// private _action =
// [

// ] call ace_interact_menu_fnc_createAction

// hint str ([aa, 10] call SFSM_fnc_getCourageTime);

/************************************************************************************/
systemChat "devFile read";