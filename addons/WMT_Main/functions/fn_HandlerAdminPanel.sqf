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
		
		if ( WMT_pub_frzState >= 3 ) then {
			(_dialog displayCtrl IDD_ADMINPANEL_FREEZETIME) ctrlShow false;
			(_dialog displayCtrl IDD_ADMINPANEL_FREEZEADD5) ctrlShow false;
			(_dialog displayCtrl IDD_ADMINPANEL_FREEZEADD10) ctrlShow false;
			(_dialog displayCtrl IDD_ADMINPANEL_FREEZESUB) ctrlShow false;
			(_dialog displayCtrl IDD_ADMINPANEL_FREEZEBK) ctrlShow false;
		};

		["loop", _dialog] call WMT_fnc_HandlerAdminPanel;
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
	case "loop" : {
		[_arg] spawn {
			disableSerialization;

			PR(_dialog) = _this select 0;
			PR(_ctrlTime) = _dialog displayCtrl IDD_ADMINPANEL_TEXTTIME;

			if (isNil "wmt_param_MissionTime") then {
				_ctrlTime ctrlSetText format ["%1:   --:--",localize "STR_WMT_TimeLeft"];
			} else {
				while {(uiNamespace getVariable ["WMT_Dialog_Menu",displayNull]) == _dialog} do {
					PR(_leftTime) = (WMT_Local_LeftTime select 1);

					if (WMT_Local_LeftTime select 2) then {
						_leftTime = _leftTime - (diag_tickTime - (WMT_Local_LeftTime select 0));
					};

					_leftTime = 0 max _leftTime;

					PR(_min) = floor(_leftTime/60);
					PR(_sec) = floor(_leftTime%60);
					PR(_text) = "";

					if(_sec<10) then {
						_text = format ["%1:   %2:0%3",localize "STR_WMT_TimeLeft", _min, _sec];
					} else {
						_text = format ["%1:   %2:%3",localize "STR_WMT_TimeLeft", _min, _sec];
					};

					_ctrlTime ctrlSetText _text;
					sleep 0.1;
				};
			};
		};
		[_arg] spawn  {
			disableSerialization;
			PR(_dialog) = _this select 0;
			PR(_ctrlTime) = _dialog displayCtrl IDD_ADMINPANEL_FREEZETIME;
			while {(uiNamespace getVariable ["WMT_Dialog_Menu",displayNull]) == _dialog && WMT_pub_frzState < 3} do {
			
				PR(_leftTime) = 0 max WMT_pub_frzTimeLeft;
				PR(_min) = floor(_leftTime/60);
				PR(_sec) = floor(_leftTime%60);
				PR(_text) = "";
				
				if(_sec<10) then {
					_text = format ["%1:   %2:0%3",localize "STR_WMT_TimeLeftFreeze", _min, _sec];
				} else {
					_text = format ["%1:   %2:%3",localize "STR_WMT_TimeLeftFreeze", _min, _sec];
				};
	
				_ctrlTime ctrlSetText _text;
				sleep 0.1;
	
			};
			if ((uiNamespace getVariable ["WMT_Dialog_Menu",displayNull]) == _dialog) then {
				(_dialog displayCtrl IDD_ADMINPANEL_FREEZETIME) ctrlShow false;
				(_dialog displayCtrl IDD_ADMINPANEL_FREEZEADD5) ctrlShow false;
				(_dialog displayCtrl IDD_ADMINPANEL_FREEZEADD10) ctrlShow false;
				(_dialog displayCtrl IDD_ADMINPANEL_FREEZESUB) ctrlShow false;
				(_dialog displayCtrl IDD_ADMINPANEL_FREEZEBK) ctrlShow false;
			};
		};
	};
	case "changeTime" : {
		if !(isNil "wmt_param_MissionTime") then {
			PR(_deltaTime) = _arg; // minutes

			// Change mission time
			wmt_param_MissionTime = wmt_param_MissionTime + _deltaTime;
			publicVariable "wmt_param_MissionTime";

			// Syncronize time left for spectators
			PR(_timeLeft) = ((WMT_Local_LeftTime select 1) + _deltaTime*60);
			if (WMT_Local_LeftTime select 2) then {
				_timeLeft = _timeLeft - (diag_tickTime - (WMT_Local_LeftTime select 0));
			};

			WMT_Local_LeftTime = [diag_tickTime, _timeLeft, (WMT_Local_LeftTime select 2)];
			WMT_Global_LeftTime = [_timeLeft];
			publicVariable "WMT_Global_LeftTime";

			// Announcement
			if(_deltaTime>0) then {
				WMT_Global_Announcement = format [localize "STR_WMT_TimeIncreased", _deltaTime, wmt_param_MissionTime];
			} else {
				WMT_Global_Announcement = format [localize "STR_WMT_TimeReduced", -_deltaTime, wmt_param_MissionTime];
			};

			WMT_Global_Announcement call WMT_fnc_Announcement;
			publicVariable "WMT_Global_Announcement";
		};	
	};
	
	case "freezeTime" : {
		PR(_deltaTime) = _arg; // minutes
		WMT_pub_frzTimeLeft = WMT_pub_frzTimeLeft + _deltaTime * 60;
		publicVariable "WMT_pub_frzTimeLeft";
		
		if(_deltaTime>0) then {
			WMT_Global_Announcement = format [localize "STR_WMT_TimeIncreasedFreeze", _deltaTime, round(WMT_pub_frzTimeLeft/60)];
		} else {
			WMT_Global_Announcement = format [localize "STR_WMT_TimeReducedFreeze", -_deltaTime, round(WMT_pub_frzTimeLeft/60)];
		};
		WMT_Global_Announcement call WMT_fnc_Announcement;
		publicVariable "WMT_Global_Announcement";
	};
};
_return