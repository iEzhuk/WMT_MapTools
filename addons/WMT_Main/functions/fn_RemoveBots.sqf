#include "defines.sqf"

PR(_rtime) = [_this, 0, 300] call BIS_fnc_param;



waitUntil{!isNil "WMT_pub_frzState"};
waitUntil{sleep 0.725; time > _rtime && WMT_pub_frzState >= 3};

{
	PR(_isplayer) = _x getVariable ["WMT_PlayerName", nil];
	if (isNil "_isplayer") then {
		deleteVehicle _x;
	};
} forEach playableUnits;




