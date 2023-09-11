private _color   = [1,0,0,1];
private _text    = "";
private _timeOut = 3;
params["_sector", "_color", "_text", "_timeOut"];
_sector params ["_pos", "_dir", "_width", "_distance"];
private _edgePositions  = [_sector] call SFSM_fnc_sectorEdgePositions;
private _lines          = [_edgePositions, _color] call SFSM_fnc_sector3DLines;

private _dist           = round(_distance*1.1);
private _txtPos         = [([_pos, _dir, _dist, 1.5] call SFSM_fnc_sinCosPos2)] call Tcore_fnc_roundPos;
private _timer          = time + _timeOut;
private _sectorId       = [_pos, _width, _dir] joinstring "";
_edgePositions = [];

[_edgePositions, _lines, _txtPos, _text, _color, _timer, _sectorId];