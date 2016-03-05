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
private _fixPAA = {
	if((toLower _this) select [count _this-4,4] == ".paa")then {_this} else {_this + ".paa"};
};

private _fnc_getMagazinsForWeapon = {
	private _weapon = _this select 0;
	private _mag = _this select 1;
	private _wmag = getArray (configfile >> "CfgWeapons" >> _weapon >> "magazines");
	private _res = [];
	{
		if (_x in _wmag) then {
			_res pushBack _x;
		};
	} foreach _mag;
	_res
};

private _fnc_fixPicName = {
	private _res = _this;
	if (count (_res) < 4) exitwith {_res};
	private _ext = _res select [count _res - 4,1];
	if(_ext!=".") then {_res=_res+".paa";};
	_res
};

private _fnc_textForWeapon = {
	_w = _this select 0;
	_a = _this select 1;

	if(_w != "") then {
		_name = getText(configFile >> "CfgWeapons" >> _w >> "displayName");
		_pic = getText(configFile >> "CfgWeapons" >> _w >> "picture") call _fixPAA;
		_txt = _txt + format ["<img image='%1' height=36 />", _pic call _fnc_fixPicName];
		_wm = [_w, _magazines] call _fnc_getMagazinsForWeapon;
		_magazines = _magazines - _wm;

		{
			_pic = getText(configFile >> "CfgMagazines" >> (_x select 0) >> "picture");
			_txt = _txt + format [" <img image='%1' height=24/>x%2", _pic call _fnc_fixPicName, _x select 1];
		} foreach (_wm call BIS_fnc_consolidateArray);

		{
			_pic = getText(configFile >> "CfgWeapons" >> _x >> "picture");
			_txt = _txt + format [" <img image='%1' height=28/>", _pic call _fnc_fixPicName];
		} foreach _a;
	};
};

private _txt = "";
private _units = units group player;

for "_i" from 0 to (count _units - 1) do {
	_unit = _units select _i;
	_unitname = if (isPlayer _unit) then {name _unit} else {"[AI]"};
	_unitdesc = getText (configFile >> "CfgVehicles" >> typeOf _unit >> "Displayname");
	_wpn = if (primaryWeapon _unit == "") then {""} else {getText (configFile >> "CfgVehicles" >> primaryWeapon _unit >> "Displayname")};

	_txt = _txt + format ["%1: <font color='#c7861b'>%2</font> (%3) %4<br/>", _i+1, _unitname, _unitdesc, _wpn];

	_magazines = magazines _unit + secondaryWeaponMagazine _unit + primaryWeaponMagazine _unit + handgunMagazine _unit;

	//==============================
	// Weapons
	//==============================
	[primaryWeapon _unit, primaryWeaponItems _unit - [""]] call _fnc_textForWeapon;
	_txt = _txt + "<br/>";
	[secondaryWeapon _unit, []] call _fnc_textForWeapon;
	[handgunWeapon _unit, []] call _fnc_textForWeapon;
	if (secondaryWeapon _unit != "" or handgunWeapon _unit != "") then {
		_txt = _txt + "<br/>";
	};

	//==============================
	// Assigned Items
	//==============================
	{
		_pic = getText(configFile >> "CfgWeapons" >> (_x select 0) >> "picture");
		_txt = _txt + format ["<img image='%1' height=24/>x%2  ", _pic call _fnc_fixPicName, _x select 1];
	} foreach ((assignedItems _unit) call BIS_fnc_consolidateArray);
	_txt = _txt + "<br/>";

	//==============================
	// Other magazines and items
	//==============================
	{
		_pic = getText(configFile >> "CfgMagazines" >> (_x select 0) >> "picture");
		_txt = _txt + format ["<img image='%1' height=24/>x%2 ", _pic call _fnc_fixPicName, _x select 1];
	} foreach (_magazines call BIS_fnc_consolidateArray);

	{
		_pic = getText(configFile >> "CfgWeapons" >> (_x select 0) >> "picture");
		_txt = _txt + format ["<img image='%1' height=24/>x%2 ", _pic call _fnc_fixPicName, _x select 1];
	} foreach ((items _unit) call BIS_fnc_consolidateArray);

	_txt = _txt + "<br/><br/>";
};

player createDiaryRecord ["diary", [format ["%1 (%2)", localize "STR_WMT_MySquad", groupID group player], _txt]];
