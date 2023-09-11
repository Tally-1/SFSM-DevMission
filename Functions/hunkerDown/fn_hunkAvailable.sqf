// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_hObject", "_hunkerObjData"];
private _pos       = (ASLToAGL (getPosASLVisual _hObject));
private _objKey    = str _pos;
private _available = ((_hunkerObjData get _objKey) get "owner") == "none";
_available