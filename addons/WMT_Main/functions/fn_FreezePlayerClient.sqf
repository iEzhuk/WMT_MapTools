/*
 	Name: WMT_fnc_FreezePlayerClient
 	
 	Author(s):
		Zealot

 	Description:
	
	Parameters:
		0 - size of start zone 
 	
 	Returns:
		Nothing
*/
#include "defines.sqf"

PR(_distance) 	 = [_this, 0, 150] call BIS_fnc_param;
PR(_maxdistance) = _distance + 20;

PR(_startpos) = getpos player;
PR(_mrk) = ["PlayerFreeze",_startpos,"","ColorGreen","EMPTY",[_distance, _distance],"ELLIPSE",0,"Solid"] call WMT_fnc_CreateLocalMarker;
PR(_uav_term) = ["B_UavTerminal","O_UavTerminal","I_UavTerminal"];

sleep 0.01;

PR(_freezeGrenadeHandler) = player addEventHandler ["Fired", { if (WMT_pub_frzState < 3) then { deleteVehicle (_this select 6);};}]; 

enableEngineArtillery false;

PR(_vehs) = [];
{ 
	PR(_evh) = _x addEventHandler ["Fired",{if (WMT_pub_frzState < 3) then { deleteVehicle (_this select 6);};}];
	_x setVariable ["frz_evh", _evh];
	_vehs = _vehs + [_x];

	PR(_handler) = _x addEventHandler ["Engine", {
		_car = _this select 0;
		_engineon = _this select 1;
		if ( zlt_pub_frz_state < 3 and local _car and _engineon) then {
				player action ["engineoff", _car];
			};
	}];
	_x setVariable ["wmtfrzEngine", _handler];

} foreach vehicles;

wmt_frzDisconnectUav = _freeztime spawn {
	while {time < _this} do {
		player connectTerminalToUAV objNull;
		sleep 0.08;
	};
};



// Check UAV terminal
[] spawn {
	PR(_msg) = "<t size='0.7' color='#ff2222'>"+localize "STR_WMT_FreezeUAVTerminal"+"</t>";
	while {WMT_pub_frzState < 3} do {
		if(!isNull (findDisplay 160)) then {
			(findDisplay 160) closeDisplay 0;
			[_msg, 0, 0.2*safeZoneH+safeZoneY, 3, 0, 0, 273] spawn bis_fnc_dynamicText;
		};	
		sleep 0.0001;
	};
};

// check position 
while {WMT_pub_frzState < 3} do {
	PR(_dist) = player distance _startpos;
	if ( _dist > _distance and _dist < _maxdistance ) then {
		_msg = "<t size='0.75' color='#ff0000'>"+localize "STR_WMT_FreezeZoneFlee" +"</t>";
		[_msg, 0, 0.25, 3, 0, 0, 27] spawn bis_fnc_dynamicText;

	};
	if (_dist > _maxdistance) then {
		player setVelocity [0,0,0];
		player setPos _startpos;
	};


	
	sleep 0.75;
};

enableEngineArtillery true;

deleteMarkerLocal _mrk;
player removeEventHandler ["Fired",_freezeGrenadeHandler];
{

	PR(_evh) = _x getVariable "frz_evh";
	if (!isNil "_evh") then {
		_x removeEventHandler ["Fired", _evh];
	};
	_x removeEventHandler ["Engine", (_x getVariable ["wmtfrzEngine",0]) ];
} foreach _vehs;

if ( not isNil 'wmt_frzDisconnectUav' and {not scriptdone wmt_frzDisconnectUav}) then {
	terminate wmt_frzDisconnectUav;
};
