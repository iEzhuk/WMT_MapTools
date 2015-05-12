/*
 	Name: WMT_fnc_HandlerFeedback
 	
 	Author(s):
		Ezhuk

 	Description:
		Handler function for feedback menu
	
	Parameters:
		0 - STR: type of event
		1 - ARRAY: argument from event
 	
 	Returns:
		BOOL: for standart handlers 
*/
#include "defines_WMT.sqf"
#include "defines_IDC.sqf"
		
PR(_event) = _this select 0;
PR(_arg) = _this select 1;
PR(_return) = false;

switch (_event) do 
{
	case "init": {	
		PR(_dialog) = _arg select 0;
		uiNamespace setVariable ["WMT_Dialog_Menu", _dialog];

		PR(_admin) = localize "STR_WMT_NoAdmin";
		
		if !(isNil "WMT_Global_Admin") then {
			if(isPlayer (WMT_Global_Admin select 0)) then {
				_admin = WMT_Global_Admin select 1;
			};
		};

		(_dialog displayCtrl IDC_FEEDBACK_TEXT) ctrlSetText "";
		(_dialog displayCtrl IDC_FEEDBACK_ADMINNAME) ctrlSetText _admin;
	};
	case "close": {
		uiNamespace setVariable ["WMT_Dialog_Menu", nil];
	};
	case "send": {
		// Send message to admin
		if(isNil "WMT_Global_Admin") exitWith {
			hint localize "STR_WMT_NoAdmin";
		};
		if(!isPlayer (WMT_Global_Admin select 0)) exitWith {
			hint localize "STR_WMT_NoAdmin";
		};

		PR(_dialog) = uiNamespace getVariable "WMT_Dialog_Menu";
		PR(_text) = ctrlText (_dialog displayCtrl IDC_FEEDBACK_TEXT);

		if(_text != "") then {
			WMT_Global_ToAdmin = format ["%1: %2", WMT_Local_PlayerName, _text];

			(owner (WMT_Global_Admin select 0)) publicVariable "WMT_Global_ToAdmin";

			closeDialog 0;
		}else{
			hint localize "STR_WMT_EmptyTextField"; 
		};

		closeDialog 0;
	};
	case "loop": {
		// Update information about admin
		while{true} do {
			if(serverCommandAvailable("#kick")) then {
				if( isNil "WMT_Global_Admin" ) then	{
					WMT_Global_Admin = [player,WMT_Local_PlayerName];
					publicVariable "WMT_Global_Admin";
				} else {
					if((WMT_Global_Admin select 0)!= player) then {
						WMT_Global_Admin = [player,WMT_Local_PlayerName];
						publicVariable "WMT_Global_Admin";
					};
				};
			};
			sleep 15;
		};
	};
};
_return