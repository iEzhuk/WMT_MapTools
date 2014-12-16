/*
 	Name: WMT_fnc_HandlerOptions
 	
 	Author(s):
		Ezhuk

 	Description:
		Handler function for main menu
	
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
		disableSerialization;
		uiNamespace setVariable ["WMT_Dialog_Menu", _dialog];
		['update'] call WMT_fnc_HandlerOptions;
	};
	case "close": {
		uiNamespace setVariable ["WMT_Dialog_Menu", nil];
	};
	case "setDistance": {
		private ["_slider","_index"];
		PR(_slider) = _arg select 0;
		PR(_index) = _arg select 1;
		PR(_dist) = _slider select 1;
		PR(_dialog) = uiNamespace getVariable "WMT_Dialog_Menu";
		PR(_ctrlVar) = IDC_OPTIONS_FOOT_VAR + _index;
		PR(_ctrlSlider) = IDC_OPTIONS_FOOT_SLIDER + _index;

		_dist = (floor(_dist/100))*100;

		WMT_Options_ViewDistance set [_index, _dist];

		(_dialog displayCtrl _ctrlVar) ctrlSetText str(_dist);
		(_dialog displayCtrl _ctrlSlider) sliderSetPosition _dist;
	};
	case "max": {
		WMT_Options_ViewDistance = [wmt_param_MaxViewDistance, wmt_param_MaxViewDistance, wmt_param_MaxViewDistance, wmt_param_MaxViewDistance];

		['update'] call WMT_fnc_HandlerOptions;
	};
	case "update": {
		PR(_dialog) = uiNamespace getVariable "WMT_Dialog_Menu";
		(_dialog displayCtrl IDC_OPTIONS_FOOT_VAR) ctrlSetText str(wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select 0));
		(_dialog displayCtrl IDC_OPTIONS_VEH_VAR) ctrlSetText str(wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select 1));

		(_dialog displayCtrl IDC_OPTIONS_FOOT_SLIDER) sliderSetSpeed [100,100];
		(_dialog displayCtrl IDC_OPTIONS_FOOT_SLIDER) slidersetRange [100,wmt_param_MaxViewDistance];
		(_dialog displayCtrl IDC_OPTIONS_FOOT_SLIDER) sliderSetPosition (wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select 0));

		(_dialog displayCtrl IDC_OPTIONS_VEH_SLIDER) sliderSetSpeed [100,100];
		(_dialog displayCtrl IDC_OPTIONS_VEH_SLIDER) slidersetRange [100,wmt_param_MaxViewDistance];
		(_dialog displayCtrl IDC_OPTIONS_VEH_SLIDER) sliderSetPosition (wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select 1));

		(_dialog displayCtrl IDC_OPTIONS_CHECK_NICKNAME) cbSetChecked ((profilenamespace getvariable ['WMT_ShowNickNameOption', 1]) == 1);

	};
	case "loop": {
		disableSerialization;

		private["_dist","_maxDist","_spectator","_state"];

		WMT_Options_ViewDistance = [wmt_param_MaxViewDistance, wmt_param_MaxViewDistance, wmt_param_MaxViewDistance, wmt_param_MaxViewDistance];

		while{true} do {
			_state = if(vehicle player == player ) then {0} else {1};
			_dist = wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select _state);

			if(viewDistance != _dist) then {
				setViewDistance _dist;
			};

			sleep 0.1;
		};
	};
};
_return