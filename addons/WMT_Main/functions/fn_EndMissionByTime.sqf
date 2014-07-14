/*
 	Name: WMT_fnc_EndMissionByTime
 	
 	Author(s):
		Ezhuk

 	Description:
		End mission by time

	Parameters:
		0 - time 
		1 - winner side
		2 - message
		3 - brodcast left time
 	
 	Returns:
		Nothing 
*/
#include "defines.sqf"

PR(_time) = _this select 0;
PR(_winSide) = _this select 1; 
PR(_message) = _this select 2;

sleep 1;

PR(_startTime) = diag_tickTime;
PR(_missionTime) = _time*60;

Global_WMT_Specator_Time = ceil((_missionTime-_startTime)/60);

while {diag_tickTime-_startTime<_missionTime} do {
	PR(_tmp) = ceil((_missionTime-(diag_tickTime-_startTime))/60);
	if(_tmp != Global_WMT_Specator_Time) then {
		Global_WMT_Specator_Time = _tmp;
		publicVariable "Global_HIA3_Specator_Time";
	};
	sleep 20;
};

[ [ [_winSide, _message], {_this call WMT_fnc_EndMission;} ],"bis_fnc_spawn"] call bis_fnc_mp;			
