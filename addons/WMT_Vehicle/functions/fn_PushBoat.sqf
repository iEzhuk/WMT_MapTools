#include "defines.sqf"

PR(_veh) = (nearestObjects [player,["Ship"], 8]) select 0;
PR(_unit) =  player;
PR(_spd) = if (surfaceIsWater getpos _veh) then {3} else {3};
if (isNil "_veh") exitwith {};
PR(_withcrew) = (count crew _veh != 0);
if (_withcrew) exitwith {titleText [localize("STR_BOAT_ERR"),"PLAIN",1];};
WMT_mutexAction = true;  
_unit playActionNow "PutDown";
sleep 1.;
if (not WMT_mutexAction) exitWith {};
_dir = direction _unit;
_veh setOwner (owner _unit); _veh setVelocity [(sin _dir)*_spd, (cos _dir)*_spd, 0]; 
for "_i" from 0 to 5 do {
	_vel = velocity _veh;
	_veh setvelocity [(_vel select 0) * 0.5, (_vel select 1) * 0.5, (_vel select 2) * 0.5 ];
	sleep 0.3;
};


