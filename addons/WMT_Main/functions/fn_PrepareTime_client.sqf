/*
 	Name: WMT_fnc_PrepareTime_client
 	
 	Author(s):
		Ezhuk

 	Description:
		Server part of prepare time - immobilaze vehicles, timer.

	Parameters:
		0 - time 
		1 - radius of start zone 
 		2 - time to remove markers

 	Returns:
		Nothing 
*/
#include "defines.sqf"

PR(_func_checkPos) = {
	private ["_dist"];
	_dist = player distance _startPos;

	if(_dist > _zone) then {
		_text = "Stop";
		[format ["<t size='1' color='#bb0202'>%1</t>",_text], 0,0.1,3,0,0,28] spawn bis_fnc_dynamicText;
	};
	if(_dist - _zone > 20) then {
		player setPosATL _startPos;
	};
};

PR(_func_checkUAV) = {
 	{
	 	if( _x in assigneditems player) then
	 	{
			player unassignitem _x;
		};
	} foreach _uav_term;
};


PR(_duration) = (_this select 0)*60; 
PR(_zone) = _this select 1;
PR(_timeToRemoveMarkers) = (_this select 2)*60;

PR(_startPos) = getPosATL player;
PR(_marker) = ["WMT_PlayerStartPos",_startPos,"","ColorGreen","EMPTY",[_zone, _zone],"ELLIPSE",0,"Solid"] call WMT_fnc_CreateLocalMarker;
PR(_markerPool) = [] call WMT_fnc_SpotMarkers;

if(_duration > 0) then {
	"WMT_Global_prepareTime_vehicleFuel" addPublicVariableEventHandler { ((_this select 1) select 0) setFuel ((_this select 1) select 1) };

	if(isNil "WMT_Global_FreezeTime_Left") then {
		WMT_Global_FreezeTime_Left = _duration;
	};

	PR(_uav_term) = ["B_UavTerminal","O_UavTerminal","I_UavTerminal"];

	PR(_firedHendler) = player addEventHandler ["Fired", {deleteVehicle (_this select 6)}];
	PR(_vehFierHandler) = [];

	{
		if((_x distance _startPos) < (_zone + 40)) then {
			_vehFierHandler = _vehFierHandler + [[_x,(_x addEventHandler ["Fired",{deleteVehicle (_this select 6)}])]];
		};
	} foreach vehicles;

	enableEngineArtillery false;

	//==========================================================================================
	//										TIMER
	//==========================================================================================
	while {WMT_Global_FreezeTime_Left>0} do {
		[_startPos] call _func_checkPos;
		[] call _func_checkUAV;
		sleep 0.3;
	};
	//==========================================================================================

	enableEngineArtillery true;

	//remove fire handlers
	{(_x select 0) removeEventHandler ["Fired", (_x select 1)];} foreach _vehFierHandler;
	player removeEventHandler ["Fired", _firedHendler];

	// assign uav terminal 
	{if(_x in items player)then{player assignitem _x;};} foreach _uav_term;
};

// Sleep to wait end of briefing without prepare time
sleep 0.1;

// Start 
deleteMarkerLocal _marker;

[_timeToRemoveMarkers,_markerPool] spawn {
	sleep (_this select 0);
	{deleteMarkerLocal _x;} foreach (_this select 1);
};