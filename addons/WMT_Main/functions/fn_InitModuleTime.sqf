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
	//================================================
	//					SERVER
	//================================================
	if(isServer) then {
		[_logic] spawn {
			PR(_logic) = _this select 0;
			PR(_missionTime) 		= _logic getVariable "MissionTime";
			PR(_winnerByTime) 		= [sideLogic,WEST,EAST,RESISTANCE,CIVILIAN] select (_logic getVariable "WinnerByTime");
			PR(_winnerText) 		= _logic getVariable "WinnerByTimeText";
			PR(_prepareTime) 		= _logic getVariable "PrepareTime";
			PR(_removeBotsTime) 	= _logic getVariable "RemoveBots";

			[_prepareTime] call WMT_fnc_PrepareTime_server;
			[_missionTime,_winnerByTime,_winnerText] call WMT_fnc_EndMissionByTime;
		};
	}; 


	//================================================
	//					CLIENT
	//================================================
	if(!isDedicated) then {
		[_logic] spawn {
			PR(_logic) = _this select 0;
			PR(_prepareTime) = _logic getVariable "PrepareTime";
			PR(_startZone) 	 = _logic getVariable "StartZone";

			[_prepareTime,_startZone] call WMT_fnc_PrepareTime_client;
		};
	};
};
