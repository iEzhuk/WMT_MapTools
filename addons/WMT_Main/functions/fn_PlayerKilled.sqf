/*
 	Name: WMT_fnc_PlayerKilled
 	
 	Author(s):
		Ezhuk

 	Description:
		Callback for event "killed"

	Parameters:
 		Nothing
 		
 	Returns:
		Nothing 
*/

#define PR(x) private ['x']; x

if(wmt_param_Statistic==0)exitWith{};

closeDialog 0;

PR(_killer) = _this select 1; 
PR(_killerName) = _killer getVariable ["WMT_PlayerName", localize "STR_WMT_Unknow"];
PR(_killerSide) = _killer getVariable ["WMT_PlayerSide", sideLogic];

WMT_Local_Killer = [_killerName, _killerSide];

WMT_Global_AddKills = [WMT_Local_PlayerName,playerSide];
(owner _killer) publicVariableClient "WMT_Global_AddKills";