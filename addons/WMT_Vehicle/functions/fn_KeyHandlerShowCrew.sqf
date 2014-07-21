/*
 	Name: WMT_fnc_KeyHandlerShowCrew
 	
 	Author(s):
		Ezhuk

 	Description:
		Show list of vehicle crew by scrolling

	Parameters:
		Nothing

 	Returns:
		Nothing
*/

if ((_this select 1) < 0)exitWith{};

if ((alive player) && (alive (vehicle player)) && (vehicle player != player)) then {
	if(!((vehicle player) isKindOf "StaticWeapon")) then {
		50 cutRsc ["RscWMTVehicleCrew","PLAIN"];	
	};	
};