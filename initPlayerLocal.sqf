waituntil {!isNull (findDisplay 46)};

private _eh =
["KeyDown", "
            private _Pressed = false;
            if ((_this # 1) == 79) then {execVM 'devFile.sqf'; _Pressed = true};
            if ((_this # 1) == 80) then {hint 'reCompiling...'; [5] call BIS_fnc_recompile; _Pressed = true};
            if ((_this # 1) == 81) then {
                                            {
                                                [_x] call SFSM_fnc_battlefieldEnd;    
                                            }forEach SFSM_battles;
                                            _Pressed = true;
                                        };
_Pressed"];

(findDisplay 46) displayAddEventHandler _eh;
execVM 'devFile2.sqf';