/*******************************VERTICAL-STANCES********************************/
// SFSM_animStances is a hashmap that is indexed by a number representing lowest to highest stance.
// the value of each entry is an array with 4 elements:
// [animationName(string), unitPos(string), chestOverground(number), eyesOverGround(number)]
SFSM_animStances = createHashMap;//
SFSM_animStances set [0,  ["aadjppnemstpsraswrflddown", "DOWN",     0.18, 0.2 ]];
SFSM_animStances set [1,  ["amovppnemstpsraswrfldnon",  "DOWN",     0.18, 0.38]];
SFSM_animStances set [2,  ["aadjppnemstpsraswrfldup",   "DOWN",     0.39, 0.56]];
SFSM_animStances set [3,  ["aadjpknlmstpsraswrflddown", "MIDDLE",   0.62, 0.76]];
SFSM_animStances set [3.1,["amovpsitmstpslowwrfldnon",  "MIDDLE",   0.42, 0.79]];
SFSM_animStances set [4,  ["amovpknlmstpsraswrfldnon",  "MIDDLE",   0.79, 1.05]];
SFSM_animStances set [4.1,["amovpknlmstpslowwrfldnon",  "MIDDLE",   0.76, 1.05]];

SFSM_animStances set [5,  ["aadjpknlmstpsraswrfldup",   "MIDDLE",   0.96, 1.26]];
SFSM_animStances set [6,  ["aadjpercmstpsraswrflddown", "UP",       1.05, 1.35]];
SFSM_animStances set [7,  ["amovpercmstpsraswrfldnon",  "UP",       1.23, 1.53]];
SFSM_animStances set [7.1,["amovpercmstpslowwrfldnon",  "UP",       1.32, 1.68]];
SFSM_animStances set [8,  ["aadjpercmstpsraswrfldup",   "UP",       1.31, 1.64]];

// SFSM_rightStances / SFSM_leftStances are hashmaps indexed by a number representing lowest to highest stance.
// each animation is leaning to the right/left
// the value of each entry is an array with 8 elements:
/*[
	#0 	animation name(string), 
	#1  unitPos (string: "DOWN", "MIDDLE", "UP")
	#2 	chest over ground(number in meters), 
	#3 	eyes over ground(number in meters), 
	#4  positional displacement
	#5 	chest displacement(number in meters), 
	#6 	eye displacement(number in meters)
	#7 	relative direction to animation position (number 0-360)
]*/
//displacement refers to the distance between the starting-position and the 
//animated position


/*******************************SIDE-STANCES********************************/
SFSM_rightStances = createHashMap;
SFSM_rightStances set [0, ["aadjppnemstpsraswrfldright", "DOWN", 0.2, 0.35,  0.45, 0.66, 1.3,  65]];
SFSM_rightStances set [1, ["aadjpknlmstpsraswrfldright", "MIDDLE", 0.73, 1.02, 0.13, 0.25, 0.44, 79]];
SFSM_rightStances set [2, ["aadjpercmstpsraswrfldright", "UP", 1.25, 1.43, 0.54, 0.61, 0.9,  60]];

SFSM_leftStances = createHashMap;
SFSM_leftStances set [0, ["aadjppnemstpsraswrfldleft", "DOWN",   0.21, 0.4,  0.78, 1.15, 1.4,  270]];
SFSM_leftStances set [1, ["aadjpknlmstpsraswrfldleft", "MIDDLE", 0.85, 1.02, 0.17, 0.28, 0.3,  285]];
SFSM_leftStances set [2, ["aadjpercmstpsraswrfldleft", "UP",     1.2, 1.44,  0.49,  0.57, 0.5, 275]];


/*******************************PANIC-ANIMATIONS********************************/
SFSM_panicAnimations = ([
        "ApanPpneMstpSnonWnonDnon_G01",
        "ApanPpneMstpSnonWnonDnon_G02",
        "ApanPpneMstpSnonWnonDnon_G03",
        "ApanPknlMstpSnonWnonDnon_G01",
        "ApanPknlMstpSnonWnonDnon_G02",
        "ApanPknlMstpSnonWnonDnon_G03"
] apply {toLowerANSI _x});


/*******************************PANIC-MOVES********************************/
SFSM_panicMoveAnims = ([
    "ApanPercMsprSnonWnonDfl",
    "ApanPercMsprSnonWnonDf", 
    "ApanPercMsprSnonWnonDfr",
    "ApanPknlMwlkSnonWnonDb",
    "ApanPknlMwlkSnonWnonDbl",
    "ApanPknlMwlkSnonWnonDbr",
    "ApanPknlMwlkSnonWnonDf",
    "ApanPknlMwlkSnonWnonDfr",
    "ApanPknlMwlkSnonWnonDfl"
] apply {toLowerANSI _x});



/*******************************MOVEMENT-ANIMS******************************/
[] call SFSM_fnc_OOP_moveAnimsMap;










/*******************************NAMESPACE DECLARATION********************************/
missionNamespace setVariable ["SFSM_animStances",  SFSM_animStances,  true];
missionNamespace setVariable ["SFSM_rightStances", SFSM_rightStances, true];
missionNamespace setVariable ["SFSM_leftStances",  SFSM_leftStances,  true];
missionNamespace setVariable ["SFSM_moveAnims",    SFSM_moveAnims,    true];

true;

