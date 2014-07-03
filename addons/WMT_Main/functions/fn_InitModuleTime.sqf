/*
 	Name: WMT_fnc_InitModuleTime
 	
 	Author(s):
		Ezhuk

 	Description:
		Initialize time module
*/
#define PR(x) private ['x']; x

PR(_logic) = [_this,0,objNull,[objNull]] call BIS_fnc_param;
PR(_units) = [_this,1,[],[[]]] call BIS_fnc_param;
PR(_activated) = [_this,2,true,[true]] call BIS_fnc_param;


if(_activated) then {
	// mission time 
	if(isNil "wmt_param_MissionTime") then {
		wmt_param_TI = _logic getVariable "MissionTime";
	};
	// winner by end of time 
	if(isNil "wmt_param_WinnerByTime") then {
		wmt_param_WinnerByTime = _logic getVariable "WinnerByTime";
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
};
