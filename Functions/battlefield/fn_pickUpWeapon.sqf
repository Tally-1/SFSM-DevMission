//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description:  Sends a man to pick up a weapon from the battlefield
// Params:       [_man: object, _weaponObject: object]
// Return value: scriptHandle (number)
// Example: [_man, _weaponObject] spawn SFSM_fnc_pickUpWeapon;

params["_man", "_weaponObject"];


//Double check that the weapon is not being picked up by someone else.
//Due to the speed of the function sometimes the same weapon gets 2 soldiers trying to pick it up,
//inspite of the fact that the variable is declared on the weapon-object.
private _weaponOwner     = _weaponObject getVariable "SFSM_newOwner";
private _weaponAvailable = (isNil "_weaponOwner");
if!(_weaponAvailable)then{_weaponAvailable = (!alive _weaponOwner)};
if!(_weaponAvailable)
then{
        private _battleKey   = [_man, "currentBattle"] call SFSM_fnc_unitData;
        if(isNil "_battleKey")exitwith{_weaponObject = nil};

        private _battleField =  SFSM_Battles get _battleKey;
        if(isNil "_battleField")exitWith{_weaponObject = nil};

        _weaponObject = [_man, _battleField] call SFSM_fnc_getBattlefieldWeapon;
    };

if(isNil "_weaponObject")exitWith{[_man, false, nil, true] spawn SFSM_fnc_endWeaponPickup};


//set a variable to ensure no other units try to pick up the same weapon
_weaponObject setVariable ["SFSM_newOwner", _man];


//check if weapon can be picked up
private _canPickUp = [_man, _weaponObject] call SFSM_fnc_canPickUpWeapon;
if!(_canPickUp)exitWith{[_man, false] spawn SFSM_fnc_endWeaponPickup};



//make sure unit is available before executing move
private _timer  = time + 20;
private _available = [_man, _timer] call SFSM_fnc_manAvailable;
if!(_available)
then{
    waitUntil {
        if(isNil "_man")exitWith{true};
        sleep 0.1; 
        [_man, _timer] call SFSM_fnc_manAvailable;
        };
    };

if(isNil "_man")exitWith{};

_available = [_man, (time + 5)] call SFSM_fnc_manAvailable;
_canPickUp = [_man, _weaponObject] call SFSM_fnc_canPickUpWeapon;

//check conditions again
if!(_available)exitWith{[_man, false] spawn SFSM_fnc_endWeaponPickup};
if!(_canPickUp)exitWith{[_man, false] spawn SFSM_fnc_endWeaponPickup};

private _weaponName = ([(getWeaponCargo _weaponObject#0#0)] call ObjScan_fnc_weaponData) get "name";
private _actionText = ["Picking up ", _weaponName]joinString"";

[_man, "action",  _actionText] call SFSM_fnc_unitData;


//move to weapon
private _weaponPos = getPos _weaponObject;
private _canSprint = [_man, _weaponPos, 40] call SFSM_fnc_canSprint;

if(_canSprint)then{

    // private _sprint = 
    [_man, _weaponPos] call SFSM_fnc_sprint;
    // waitUntil{sleep 0.5; scriptDone _sprint;};

}else{

    _man setAnimSpeedCoef SFSM_sprintSpeed;
    [_man, "currentDestination", _weaponPos] call SFSM_fnc_unitData;
    [_man, _weaponPos, 40, 1.5] call SFSM_fnc_forcedMove;

};


if(isNil "_man")exitWith{};

_canPickUp      = [_man, _weaponObject] call SFSM_fnc_canPickUpWeapon;
private _tooFar = (_weaponPos distance2D _man) > 3;
if(_canSprint)then{_tooFar = (_weaponPos distance2D _man) > 5;};


//check conditions again
if((! _canPickUp)
or (_tooFar))
exitWith{[_man, false] spawn SFSM_fnc_endWeaponPickup};


//pick up weapon
private _weaponOwner = _weaponObject getVariable "SFSM_weaponOwner";
private _weaponType  = getWeaponCargo _weaponObject#0#0;



if(isNil "_weaponType")
exitWith{[_man, false] spawn SFSM_fnc_endWeaponPickup};

_man action ["TakeWeapon", _weaponObject, _weaponType];

if(isNil "_weaponOwner")exitWith{[_man, true] spawn SFSM_fnc_endWeaponPickup};

//if the weapon was dropped by a killed soldier
sleep 1.5;
_man action ["rearm", _weaponOwner];

//make sure man has no backpack
private _hasBackPack = !isNull (unitBackpack _man);
if(_hasBackPack)exitWith{[_man, true] spawn SFSM_fnc_endWeaponPickup};

//make sure dead body has a backpack
_hasBackPack = !isNull (unitBackpack _weaponOwner);
if!(_hasBackPack)exitWith{[_man, true] spawn SFSM_fnc_endWeaponPickup};

//take backpack from dead Body.
sleep 1.5;
_man action ["AddBag", _weaponOwner, (Backpack _weaponOwner)];

sleep 1.5;
[_man, true] spawn SFSM_fnc_endWeaponPickup;

true;