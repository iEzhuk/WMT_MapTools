/*
 	Name: WMT_fnc_PrepareTime_server
 	
 	Author(s):
		Ezhuk

 	Description:
		Client part for prepare time

	Parameters:
		0 - time 
 	
 	Returns:
		Nothing 
*/
#include "defines.sqf"

PR(_duration) = (_this select 0)*60; 

if(_duration > 0) then {
	WMT_Global_FreezeTime_Left 	= _duration;
	WMT_Global_Vote_StartGame   = [];
	WMT_Global_Vote_NoStartGame = [];
	publicVariable "WMT_Global_FreezeTime_Left";
	publicVariable "WMT_Global_Vote_StartGame";
	publicVariable "WMT_Global_Vote_NoStartGame";
	
	PR(_vehs) = [];
	{
		private ["_fuel"];
		if (local _x) then {
			_fuel = fuel _x;
			if (_fuel > 0) then {
				_vehs set [count _vehs, [_x,_fuel]];
				_x setFuel 0;
			};
		};
	} forEach (vehicles);

	sleep 1;

	// get Time after end of briefing
	PR(_start) = diag_tickTime;
	PR(_endDef) = _start + _duration;
	PR(_end) = _endDef;

	sleep 5;
	//==========================================================================================
	//										TIMER
	//==========================================================================================
	while {WMT_Global_FreezeTime_Left>0} do {
		if((count WMT_Global_Vote_StartGame)>0 && (count WMT_Global_Vote_NoStartGame)==0) then {
			if(_end==_endDef && diag_tickTime+FAST_START<_endDef) then {
				_end = diag_tickTime + FAST_START;  
			};
		}else{
			if(_end != _endDef) then {
				_end = _endDef;
			};	
		};

		WMT_Global_FreezeTime_Left = ceil(_end - diag_tickTime);
		
		if(WMT_Global_FreezeTime_Left<0) then {
			WMT_Global_FreezeTime_Left = 0;
		};

		publicVariable "WMT_Global_FreezeTime_Left";
		sleep 0.9;
	};
	//==========================================================================================

	{
		_veh  = _x select 0;
		_fuel = _x select 1;
		_veh  setFuel _fuel;

		WMT_Global_prepareTime_vehicleFuel = [_veh,_fuel];
		owner(_veh) publicVariableClient "WMT_Global_prepareTime_vehicleFuel";
	} forEach _vehs;

};
