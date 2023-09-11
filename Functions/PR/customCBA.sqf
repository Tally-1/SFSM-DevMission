/*
*  customCBA.sqf
*  Author: PapaReap
*/

private _versionName = "DCO soldier FSM | Headless Client";

[
    "PR_Allow_HC",
    "CHECKBOX",
    ["Allow Headless Client", "Allow Headless Client to process SFSM for AI."],
    _versionName,
    false,
    true,
    {},
    true
] call cba_settings_fnc_init;

[
    "PR_Use_HC",
    "CHECKBOX",
    ["Use Headless Client", "Use Headless Client to process SFSM for AI."],
    _versionName,
    false,
    true,
    {},
    true
] call cba_settings_fnc_init;

[
    "PR_HC1",
    "EDITBOX",
    ["Headless Client name", "Headless Client name, default HC"],
    _versionName,
    "HC",
    true,
    {},
    true
] call cba_settings_fnc_init;
