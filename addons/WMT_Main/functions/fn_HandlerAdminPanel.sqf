/*
 	Name: WMT_fnc_HandlerAdminPanel
 	
 	Author(s):
		Ezhuk

 	Description:
		Handler function for admin panel
	
	Parameters:
		0 - STR: type of event
		1 - ARRAY: argument from event
 	
 	Returns:
		BOOL: for standart handlers 
*/
#include "defines.sqf"
		
PR(_event) = _this select 0;
PR(_arg) = _this select 1;
PR(_return) = false;

switch (_event) do 
{
	case "init": {	
		PR(_dialog) = _arg select 0;
		uiNamespace setVariable ["WMT_Dialog_Menu", _dialog];
		_dialog displayAddEventHandler ["MouseMoving", "true"];
	};
	case "close": {
		uiNamespace setVariable ["WMT_Dialog_Menu", nil];
	};
	case "announcement": {
		PR(_dialog) = uiNamespace getVariable "WMT_Dialog_Menu";
		PR(_text) = ctrlText (_dialog displayCtrl IDC_ADMINPANEL_TEXT);

		if(_text != "")then
		{
			WMT_Global_Announcement = format ["%1: %2",WMT_Local_PlayerName,_text];

			publicVariable "WMT_Global_Announcement";
			WMT_Global_Announcement call WMT_fnc_Announcement;

			closeDialog 0;
		}else{
			hint localize "STR_WMT_EmptyTextField";
		};

		closeDialog 0;
	};
	case "endMission": {
		PR(_dialog) = uiNamespace getVariable "WMT_Dialog_Menu";
		PR(_text) = ctrlText (_dialog displayCtrl IDC_ADMINPANEL_TEXT);

		if(_text != "")then
		{
			WMT_Global_EndMission = [_text];

			publicVariable "WMT_Global_EndMission";
			[ [ [WMT_Global_EndMission], {(_this select 0) call WMT_fnc_EndMission;} ],"bis_fnc_spawn"] call bis_fnc_mp;

			closeDialog 0;
		}else{
			hint localize "STR_WMT_EmptyTextField"; 
		};

		closeDialog 0;
	};
};
_return