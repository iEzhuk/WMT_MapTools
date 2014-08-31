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

if (not isNil "WMT_pub_frzState") then {
	waitUntil {sleep 0.67; WMT_pub_frzState >= 3};

};

//PR(_missionTime) = _time*60;
PR(_startTime) = diag_tickTime;
	
Global_HIA3_Specator_Time = ceil((wmt_param_MissionTime*60-_startTime)/60);

while {diag_tickTime-_startTime<(wmt_param_MissionTime*60)} do {
	PR(_tmp) = ceil(((wmt_param_MissionTime*60)-(diag_tickTime-_startTime))/60);
	if(_tmp != Global_HIA3_Specator_Time) then {
		Global_HIA3_Specator_Time = _tmp;
		publicVariable "Global_HIA3_Specator_Time";
	};
	sleep 60;
};

[[[_winSide, _message], {_this call WMT_fnc_EndMission;}], "bis_fnc_spawn"] call bis_fnc_mp;			
