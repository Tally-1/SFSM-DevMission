// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _color = [0.6,0.6,0.1,1];
private _text = "";
private _icon  = "\A3\ui_f\data\map\markers\handdrawn\dot_CA.paa";
private _size  = 1;
private _maxDistance = 200;
params ["_posArr", "_color", "_text", "_icon", "_size", "_maxDistance"];
{
    [_x, _color, _text, _icon] call SFSM_fnc_drawObjectMarker;
    
} forEach _posArr;