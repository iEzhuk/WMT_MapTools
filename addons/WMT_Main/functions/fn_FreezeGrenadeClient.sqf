	// by Zealot

	#include "defines.sqf"

	PR(_freeztime) = [_this, 0, 60] call BIS_fnc_param;
	waitUntil {!isNull player};
	evhandlervar = player addEventHandler ["Fired", { if (true) then { deleteVehicle (_this select 6); }; }]; 
	waitUntil {sleep 1.3; WMT_pub_frzState >= 3};
	player removeEventHandler ["Fired",evhandlervar];