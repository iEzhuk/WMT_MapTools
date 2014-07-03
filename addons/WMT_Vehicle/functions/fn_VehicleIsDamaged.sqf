/*
 	Name: 
 	
 	Author(s):
		Zealot

 	Description:
		Checks whether vehicle is damaged enough to field repair it 

*/

private ["_veh","_vehtype","_flag"];
_veh =  [_this, 0] call BIS_fnc_param;
if (isNil {_veh}) exitWith {false};
_vehtype = typeOf _veh;
_flag = false;
if (true) then {
	{
		_cdmg = _veh getHitPointDamage (_x);
		if (not isNil {_cdmg} ) then {
			if (_cdmg > 0.64) exitWith {_flag = true};
		};
	}  forEach WMT_fieldRepairHps;
};
_flag;