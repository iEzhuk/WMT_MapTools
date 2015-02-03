/*
 	Name: WMT_fnc_RearmVehicle
 	
 	Author(s):
		Ezhuk

 	Description:
		Ream vehicle 

	Parameters:
		0: vehicle 

 	Returns:
		Nothing
*/
private ["_veh","_mag"];

_veh = _this select 0;

_mag = GetArray (configFile >> "CfgVehicles" >> typeOf _veh >> "Magazines");
_mag = _mag+GetArray (configFile >> "CfgVehicles" >> typeOf _veh >> "Turrets" >> "MainTurret" >> "Magazines");

_mag = _veh getVariable ["WMT_Magazines", _mag];

{_veh removeMagazine _x} ForEach _mag;
{_veh addMagazine _x} ForEach _mag;

_veh setVehicleAmmo 1;