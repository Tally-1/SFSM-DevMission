private _versionName = "DCO soldier FSM | Capture";

[
	"SFSM_captureTargets",
	"LIST",
	["Capture Targets", "Select what kind of soldiers can be captured."],
	_versionName,
	[
		["Everyone", "AI only", "Players Only", "Nobody"],
		["all", "ai", "players", "nobody"], 
		0
	]
] call cba_settings_fnc_init;

[
	"SFSM_captiveAutoDeath",
	"LIST",
	["Captive Heart attack", "How long until a captive dies automatically."],
	_versionName,
	[
		["never", "1 minute", "2 minutes", "3 minutes", "4 minutes", "5 minutes"],
		[-1,1,2,3,4,5], 
		0
	]
] call cba_settings_fnc_init;

[
	"SFSM_bombOnCapture",
	"SLIDER",
	["Captured Bomb probability", "The probability that a captured soldier blows himself up."],
	_versionName,
	[
		0,     // minimum 
		1, 	  //  max
		0.2, //   default
		2,  //    decimals
		true
	]
] call cba_settings_fnc_init;

[
	"SFSM_captureExplosive",
	"LIST",
	["Captured Bomb-type", "Choose which explosive will be used in the case of capture suicide."],
	_versionName,
	[
		["gbu", "grenade", "largestEx"],
		["GBU", "Grenade", "Largest explosive in Inventory"], 
		1
	]
] call cba_settings_fnc_init;

[
	"SFSM_captureAbuseProb",
	"SLIDER",
	["Abuse probability", "Probability that a captive will be beaten."],
	_versionName,
	[
		0,     // minimum 
		1, 	  //  max
		0.5, //   default
		1,  //    decimals
		true
	]
] call cba_settings_fnc_init;

[
	"SFSM_cptrAbuseProbPlr",
	"SLIDER",
	["Abuse player probability", "Probability that a captured player will be beaten."],
	_versionName,
	[
		0,     // minimum 
		1, 	  //  max
		1,   //   default
		1,  //    decimals
		true
	]
] call cba_settings_fnc_init;

[
	"SFSM_captureExecProb",
	"SLIDER",
	["Execute captive probability", "Probability that a captive Will be executed."],
	_versionName,
	[
		0,     // minimum 
		1, 	  //  max
		1,   //   default
		1,  //    decimals
		true
	]
] call cba_settings_fnc_init;

[
	"SFSM_cptrExecProbPlr",
	"SLIDER",
	["Execute player probability", "Probability that a captured player will be executed."],
	_versionName,
	[
		0,     // minimum 
		1, 	  //  max
		0.9, //   default
		1,  //    decimals
		true
	]
] call cba_settings_fnc_init;

[
	"SFSM_cptrPlrEscProb",
	"SLIDER",
	["Player escape probability", "The probability for success when a player attempts to break free while captured."],
	_versionName,
	[
		0,     // minimum 
		1, 	  //  max
		0.5, //   default
		1,  //    decimals
		true
	]
] call cba_settings_fnc_init;

[
	"SFSM_cptrPlrEscTime",
	"SLIDER",
	["Player escape time", "How long one escape attempt takes in seconds."],
	_versionName,
	[
		3,     // minimum 
		15,   //  max
		7,   //   default
		0,  //    decimals
		false
	]
] call cba_settings_fnc_init;
