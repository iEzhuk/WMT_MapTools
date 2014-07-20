#include "defines.sqf"

PR(_rtime) = [_this, 0, 300] call BIS_fnc_param;

waitUntil{sleep 0.725; time > _rtime};

{
	PR(_isplayer) = _x getVariable ["WMT_PlayerName", nil];
	if (isNil "_isplayer") then {
		deleteVehicle _x;
	};
} forEach playableUnits;




