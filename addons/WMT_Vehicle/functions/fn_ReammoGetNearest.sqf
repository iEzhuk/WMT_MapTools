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

private ["_res","_objs"];
_res = objNull;

_objs = nearestObjects [player, ["Car","Tank","Air","Ship","ReammoBox_F"], DISTANCE_TO_REAMMOVEHICLE];
{ if ( alive _x and {_x getVariable ["wmt_ammo_cargo", -1] > 0} ) exitWith {_res = _x;}; } foreach _objs;

_res