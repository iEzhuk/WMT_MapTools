/*
 	Name: 
 	
 	Author(s):
		Ezhuk

 	Description:
		

*/

private ["_veh"];

_veh = _this select 0;

if ((count (magazines _veh))==0) then
{
	private["_mag"];
	_mag=GetArray (configFile >> "CfgVehicles" >> typeOf _veh >> "Magazines");
	_mag=_mag+GetArray (configFile >> "CfgVehicles" >> typeOf _veh >> "Turrets" >> "MainTurret" >> "Magazines");
	{_veh removeMagazine _x} ForEach magazines _veh;
	{_veh addMagazine _x} ForEach _mag;
};
_veh setVehicleAmmo 1;