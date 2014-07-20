/*
 	Name: WMT_fnc_InitModuleTime
 	
 	Author(s):
		Ezhuk

 	Description:
		Initialize time module
*/
#include "defines.sqf"

PR(_logic) = [_this,0,objNull,[objNull]] call BIS_fnc_param;
PR(_units) = [_this,1,[],[[]]] call BIS_fnc_param;
PR(_activated) = [_this,2,true,[true]] call BIS_fnc_param;


if(_activated) then {
	// mission time 
	if(isNil "wmt_param_MissionTime") then {
		wmt_param_MissionTime = _logic getVariable "MissionTime";
	};
	// winner by end of time 
	if(isNil "wmt_param_WinnerByTime") then {
		wmt_param_WinnerByTime = [east,west,resistance,civilian,sideLogic] select (_logic getVariable "WinnerByTime");
	};	
	// message 
	if(isNil "wmt_param_WinnerByTimeText") then {
		wmt_param_WinnerByTimeText = _logic getVariable "WinnerByTimeText";
	};	
	// prepare time  
	if(isNil "wmt_param_PrepareTime") then {
		wmt_param_PrepareTime = _logic getVariable "PrepareTime";
	};
	// prepare time  
	if(isNil "wmt_param_StartZone") then {
		wmt_param_StartZone = _logic getVariable "StartZone";
	};
	// time to remove bots
	if(isNil "wmt_param_RemoveBots") then {
		wmt_param_RemoveBots = _logic getVariable "RemoveBots";
	};

	wmt_param_MissionTime = 0 max wmt_param_MissionTime;
	wmt_param_PrepareTime = 0 max wmt_param_PrepareTime;
	wmt_param_StartZone = 20 max wmt_param_StartZone;
	wmt_param_RemoveBots = 0 max wmt_param_RemoveBots;
	//================================================
	//					SERVER
	//================================================
	if(isServer) then {
		[] spawn {

			[wmt_param_PrepareTime] call WMT_fnc_PrepareTime_server;
			if(wmt_param_MissionTime>0) then {
				[wmt_param_MissionTime,wmt_param_WinnerByTime,wmt_param_WinnerByTimeText] spawn WMT_fnc_EndMissionByTime;
			};
			if (wmt_param_RemoveBots > 0 ) then {
				[wmt_param_RemoveBots*60] spawn WMT_fnc_RemoveBots;
			};
		};
	}; 

	//================================================
	//					CLIENT
	//================================================
	if(!isDedicated) then {
		[] spawn {
			waitUntil{player==player};
			waitUntil{alive player};
			waitUntil{local player};

			[wmt_param_PrepareTime,wmt_param_StartZone] spawn WMT_fnc_PrepareTime_client;
		};
	};
};
