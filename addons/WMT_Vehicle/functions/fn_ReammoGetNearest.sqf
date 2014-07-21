/*
 	Name: WMT_fnc_ReammoGetNearest
 	
 	Author(s):
		Ezhuk

 	Description:
		Fine the nearest vehicle with ammo  

	Parameters:
		Nothing

 	Returns:
		OBJECT
*/
#define DISTANCE_TO_REAMMOVEHICLE 15

private ["_res"];
_res = objNull;
{
	if( player distance _x < DISTANCE_TO_REAMMOVEHICLE) exitWith {_res = _x;};
} foreach (wmt_ammoCargoVehs);
_res