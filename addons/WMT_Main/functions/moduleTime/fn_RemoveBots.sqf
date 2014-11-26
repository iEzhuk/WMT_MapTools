private["_isplayer"];
{
	_isplayer = _x getVariable ["PlayerName", nil];
	if (isNil "_isplayer") then {
		deleteVehicle _x;
	};
} forEach playableUnits;
