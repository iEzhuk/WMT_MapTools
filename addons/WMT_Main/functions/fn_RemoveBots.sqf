#include "defines.sqf"

PR(_rtime) = [_this, 0, 300] call BIS_fnc_param;

if (_rtime == 0) exitWith {};

if (!isDedicated) then {
	waituntil{sleep 0.33; time > 10};
	player setVariable ["wmt_player", true, true];
};

if (isServer) then {
	waitUntil{sleep 0.725; time > _rtime};
	{
		PR(_isplayer) = _x getVariable ["wmt_player", nil];
		if (isNil "_isplayer") then {
			deleteVehicle _x;
		};
	} forEach playableUnits;

};




