// by Zealot
#include "defines.sqf"

_freeztime = [_this, 0, 60] call BIS_fnc_param;
_distance = [_this, 1, 150] call BIS_fnc_param;
_maxdistance = _distance + 20;

PR(_startpos) = getpos player;
PR(_mrk) = ["PlayerFreeze",_startpos,"","ColorGreen","EMPTY",[_distance, _distance],"ELLIPSE",0,"Solid"] call WMT_fnc_CreateLocalMarker;
waitUntil{sleep 0.4; time > 0};
PR(_freezeGrenadeHandler) = player addEventHandler ["Fired", { if (WMT_pub_frzState < 3) then { deleteVehicle (_this select 6);};}]; 
_uav_term = ["B_UavTerminal","O_UavTerminal","I_UavTerminal"];
enableEngineArtillery false;

PR(_vehs) = [];
{ PR(_evh) = _x addEventHandler ["Fired",{if (WMT_pub_frzState < 3) then { deleteVehicle (_this select 6); };}];
	_x setVariable ["frz_evh", _evh];
	_vehs = _vehs + [_x];
} foreach vehicles;

while {WMT_pub_frzState < 3} do {
	_dist = player distance _startpos;
	if ( _dist > _distance and _dist < _maxdistance ) then {
		_msg = "<t size='0.75' color='#ff0000'>"+localize "STR_WMT_FreezeZoneFlee" +"</t>";
		[_msg, 0,0.25,3,0,0,27] spawn bis_fnc_dynamicText;

	};
	if (_dist > _maxdistance) then {
		player setVelocity [0,0,0];
		player setPos _startpos;
	};
	
	_aitems = assigneditems player;
	if ( (_uav_term select 0) in _aitems or (_uav_term select 1) in _aitems or (_uav_term select 2) in _aitems) then {
		{player unassignitem _x;} foreach _uav_term;
		_msg = "<t size='0.5' color='#ff0000'>"+localize "STR_WMT_FreezeUAVTerminal"+"</t>";
		[_msg, 0,0.25,3,0,0,273] spawn bis_fnc_dynamicText;
	};
	sleep 0.75;
};
enableEngineArtillery true;
_aitems = (assigneditems player + items player);
if ( (_uav_term select 0) in _aitems or (_uav_term select 1) in _aitems or (_uav_term select 2) in _aitems) then {
		{player assignitem _x;} foreach _uav_term;
};

deleteMarkerLocal _mrk;
player removeEventHandler ["Fired",_freezeGrenadeHandler];
{

	_evh = _x getVariable "frz_evh";
	if (!isNil "_evh") then {
		_x removeEventHandler ["Fired", _evh];
	};
} foreach _vehs;