// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_shooter"];

if(time - SFSM_lastSoundCheck < 10)exitWith{false};

private _handGrenade = "Grenade" in (typeOf _projectile);
if(_handGrenade)exitwith{false};

private _weapon      = ([(currentWeapon _shooter)] call BIS_fnc_itemType)#1;
private _hasSilencer = !(((_shooter weaponAccessories currentWeapon _shooter)#0) == "");
private _distance    = 300;
private _pos         = getPosATLVisual _shooter;

switch (_weapon) do 
{
    case "AssaultRifle": { _distance = 400;};
    case "MachineGun":   { _distance = 600;};
    case "SniperRifle":  { _distance = 800;};
};

if(_hasSilencer)then{_distance = 100};

private _nearMen = (_pos nearEntities ["CAManBase", _distance])select
                   {[_x] call SFSM_fnc_availableAiSoldier;};

{
    private _battle = [_X, "currentBattle"] call SFSM_fnc_unitData;

    if(_battle isEqualTo "none")
    then{
            private _coverPos = [_x] call Tcore_fnc_coverPosSimple;
            if(isNil "_coverPos")exitWith{};
            [_x, _coverPos] spawn SFSM_fnc_takeCover;
        }
    else{};

} forEach _nearMen;

SFSM_lastSoundCheck = time; 

true; 