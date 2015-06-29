/*
    Name:  
        WMT_fnc_SquadInfoExt
    Author(s):
        Ezhuk

    Description:

    Parameters:
        Nothing
    Returns:
        Nothing 
*/

#include "defines_WMT.sqf"

PR(_fnc_getMagazinsForWeapon) = {
    PR(_weapon) = _this select 0;
    PR(_mag) = _this select 1;
    PR(_wmag) = getArray (configfile >> "CfgWeapons" >> _weapon >> "magazines");
    PR(_res) = [];
    {
        if (_x in _wmag) then {
            _res pushBack _x;
        };
    } foreach _mag;
    _res
};

PR(_fnc_textForWeapon) = {
    _w = _this select 0;
    _a = _this select 1;

    if(_w != "") then {
        _name = getText(configFile >> "CfgWeapons" >> _w >> "displayName");
        _pic = getText(configFile >> "CfgWeapons" >> _w >> "picture");
        _txt = _txt + format ["<img image='%1' height=30 />", _pic];
        _wm = [_w, _magazines] call _fnc_getMagazinsForWeapon;
        _magazines = _magazines - _wm;

        {
            _pic = getText(configFile >> "CfgMagazines" >> (_x select 0) >> "picture");
            _txt = _txt + format [" <img image='%1' height=24/>x%2", _pic, _x select 1]; 
        } foreach (_wm call BIS_fnc_consolidateArray);

        {
            _pic = getText(configFile >> "CfgWeapons" >> _x >> "picture");
            _txt = _txt + format [" <img image='%1' height=24/>", _pic]; 
        } foreach _a;

        _txt = _txt + "<br/>";
    };
};

PR(_txt) = "";
PR(_units) = units group player;

for "_i" from 0 to (count _units - 1) do {
    _unit = _units select _i;
    _unitname = if (isPlayer _unit) then {name _unit} else {"[AI]"};
    _unitclass = getText (configFile >> "CfgVehicles" >> typeOf _unit >> "Displayname");
    _txt = _txt + format ["%1: <font color='#c7861b'>%2</font> (%3)<br/>", _i+1, _unitname, _unitclass];

    _magazines = magazines _unit + secondaryWeaponMagazine _unit + primaryWeaponMagazine _unit + handgunMagazine _unit;

    //==============================
    // Weapons
    //==============================
    [primaryWeapon _unit, primaryWeaponItems _unit - [""]] call _fnc_textForWeapon;
    [secondaryWeapon _unit, []] call _fnc_textForWeapon;
    [handgunWeapon _unit, []] call _fnc_textForWeapon;

    //==============================
    // Assigned Items
    //==============================
    {
        _pic = getText(configFile >> "CfgWeapons" >> (_x select 0) >> "picture");
        _txt = _txt + format ["<img image='%1' height=24/>x%2  ", _pic, _x select 1];
    } foreach ((assignedItems _unit) call BIS_fnc_consolidateArray);
    _txt = _txt + "<br/>";    

    //==============================
    // Other magazines and items
    //==============================
    {
        _pic = getText(configFile >> "CfgMagazines" >> (_x select 0) >> "picture");
        _txt = _txt + format ["<img image='%1' height=24/>x%2 ", _pic, _x select 1]; 
    } foreach (_magazines call BIS_fnc_consolidateArray);

    {
        _pic = getText(configFile >> "CfgWeapons" >> (_x select 0) >> "picture");
        _txt = _txt + format ["<img image='%1' height=24/>x%2 ", _pic, _x select 1]; 
    } foreach ((items _unit) call BIS_fnc_consolidateArray);

    _txt = _txt + "<br/><br/>";
};

player createDiaryRecord ["diary", [format ["%1 (%2)", localize "STR_WMT_MySquad", groupID group player], _txt]];