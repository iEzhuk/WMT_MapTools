
  /*
    Name:

    Author(s):
        Zealot

    Description:


    Parameters:
        Nothing
    Returns:
        Nothing
*/
#define PR(x) private ['x']; x

if (not isServer) exitWith {};
wmt_global_srvBrfData = [];


private _tempData = [];
private _vehinfo = [];
private _grpinfo = [];
private _side = civilian;
private _units = [];
private _group = [];
private _playersGr = 0;




private _vehicles = []; // vehicles to show in briefing as belong to either sides
private _boxes = []; // ammoboxes to show in "Vehicle inventory" tab only


{
    if ((_x isKindof "Ship" || _x isKindof "Air" || _x isKindof "LandVehicle") && {!(_x isKindOf "Strategic") && !(_x isKindOf "Thing") && (_x getVariable ["wmt_show", true])}) then {
        _vehicles pushBack _x;
    } else {
        if (!(isNil {(weaponCargo _x + magazinecargo _x + itemCargo _x + backpackCargo _x)}) &&
            {count (weaponCargo _x + magazinecargo _x + itemCargo _x + backpackCargo _x) != 0}) then {
            _boxes pushBack _x;
        };
    };
} foreach vehicles;


// данные техники ["V", [координаты], "класс", сторона]
{
    _vehinfo = ["V"];
    _vehinfo pushback getPos _x;
    _vehinfo pushback typeOf _x;
    _side = _x getVariable ["WMT_Side", [getNumber (configfile >> "CfgVehicles" >> typeof _x >> "side")] call BIS_fnc_sideType];
    _vehinfo pushback _side;
    _vehinfo pushBack (if (isNil {(weaponCargo _x + magazinecargo _x + itemCargo _x + backpackCargo _x)}) then {[]} else {(weaponCargo _x + magazinecargo _x + itemCargo _x + backpackCargo _x) call BIS_fnc_consolidateArray});
    _vehinfo pushBack true; // это обычная техника
    _tempData pushback _vehinfo;
} foreach _vehicles;

{
    _vehinfo = ["V"];

    _vehinfo pushback getPos _x;
    _vehinfo pushback typeOf _x;
    // сторона определяется по ближайшему юниту
    private _allUnits = [];
	{ _allUnits pushBack (leader _x)} foreach allGroups;
    private _veh = _x;
    _allUnits = [_allUnits,[],{_veh distance _x},"ASCEND"] call BIS_fnc_sortBy;
    _side = _x getVariable ["WMT_Side",side (_allUnits select 0)];   

    _vehinfo pushback _side;
    _vehinfo pushBack (if (isNil {(weaponCargo _x + magazinecargo _x + itemCargo _x + backpackCargo _x)}) then {[]} else {(weaponCargo _x + magazinecargo _x + itemCargo _x + backpackCargo _x) call BIS_fnc_consolidateArray});
    _vehinfo pushBack false; // это ящики
    _tempData pushback _vehinfo;
} foreach _boxes;

// данные отряда ["S", [координаты], "GroupID", сторона, число игроков, "имя лидера",[юниты] ]

{
    if ((leader _x) in playableUnits and (_x getVariable ["wmt_show", true]) ) then {
        _grpinfo = ["S"];

        _grpinfo pushback getPos leader _x;
        _grpinfo pushback groupID _x;
        _grpinfo pushback side leader _x;

        _units = [];
        {
            _units pushback [typeOf _x, if(isPlayer _x) then {name _x} else {""}];

        } foreach units _x;

        _playersGr = 0;
        {
            if (isPlayer _x) then {_playersGr=_playersGr+1;};
        } foreach units _x;


        _x setVariable ["WMT_BriefingUnitsInfo", _units, true];

        _grpinfo pushback _playersGr;
        _grpinfo pushback (if (isPlayer leader _x) then {name leader _x} else {""});
        _grpinfo pushback _units;

        _tempData pushback _grpinfo;
    };
} foreach allGroups;

wmt_global_srvBrfData = _tempData;
publicVariable "wmt_global_srvBrfData";
