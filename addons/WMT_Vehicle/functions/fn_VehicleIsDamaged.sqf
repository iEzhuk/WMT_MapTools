 /*
 	Name: WMT_fnc_VehicleIsDamaged
 	
 	Author(s):
		Zealot

 	Description:
		Check hitpoint vehicle's parts 

	Parameters:
		0: vehicle

 	Returns:
		BOOL
*/

private ["_veh","_vehtype","_flag","_cdmg"];

_veh =  [_this, 0] call BIS_fnc_param;

if (isNil {_veh}) exitWith {false};

_flag 	 = false;
_vehtype = typeOf _veh;

if (true) then {
	{
		_cdmg = _veh getHitPointDamage (_x);
		if (not isNil {_cdmg} ) then {
			if (_cdmg > 0.64) exitWith {_flag = true};
		};
	}  forEach WMT_Local_fieldRepairHps;
};
_flag