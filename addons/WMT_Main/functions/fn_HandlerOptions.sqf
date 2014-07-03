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

#include "defines.sqf"

#define MAX_DISTANCE 10000

PR(_event) = _this select 0;
PR(_arg) = _this select 1;
PR(_return) = false;

switch (_event) do 
{
	case "init": {	
		PR(_dialog) = _arg select 0;
		PR(_slider) = [IDC_OPTIONS_FOOT_SLIDER,IDC_OPTIONS_VEH_SLIDER,IDC_OPTIONS_AIR_SLIDER,IDC_OPTIONS_SHIP_SLIDER,IDC_OPTIONS_SPECT_SLIDER];
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

		profileNamespace setVariable ["HIA3_BG_ViewDistance",WMT_Options_ViewDistance];
	};
	case "max": {
		WMT_Options_ViewDistance = 
		[MAX_DISTANCE, MAX_DISTANCE, MAX_DISTANCE, MAX_DISTANCE, MAX_DISTANCE];
		profileNamespace setVariable ["HIA3_BG_ViewDistance",WMT_Options_ViewDistance];

		['update'] call WMT_fnc_HandlerOptions;
	};
	case "update": {
		PR(_dialog) = uiNamespace getVariable "WMT_Dialog_Menu";
		(_dialog displayCtrl IDC_OPTIONS_FOOT_VAR) ctrlSetText str(wmt_param_ViewDistance min (WMT_Options_ViewDistance select 0));
		(_dialog displayCtrl IDC_OPTIONS_VEH_VAR) ctrlSetText str(wmt_param_ViewDistance min (WMT_Options_ViewDistance select 1));
		(_dialog displayCtrl IDC_OPTIONS_AIR_VAR) ctrlSetText str(wmt_param_ViewDistance min (WMT_Options_ViewDistance select 2));
		(_dialog displayCtrl IDC_OPTIONS_SHIP_VAR) ctrlSetText str(wmt_param_ViewDistance min (WMT_Options_ViewDistance select 3));
		(_dialog displayCtrl IDC_OPTIONS_SPECT_VAR) ctrlSetText str(MAX_DISTANCE min (WMT_Options_ViewDistance select 4));


		(_dialog displayCtrl IDC_OPTIONS_FOOT_SLIDER) sliderSetSpeed [100,100];
		(_dialog displayCtrl IDC_OPTIONS_FOOT_SLIDER) slidersetRange [100,wmt_param_ViewDistance];
		(_dialog displayCtrl IDC_OPTIONS_FOOT_SLIDER) sliderSetPosition (wmt_param_ViewDistance min (WMT_Options_ViewDistance select 0));

		(_dialog displayCtrl IDC_OPTIONS_VEH_SLIDER) sliderSetSpeed [100,100];
		(_dialog displayCtrl IDC_OPTIONS_VEH_SLIDER) slidersetRange [100,wmt_param_ViewDistance];
		(_dialog displayCtrl IDC_OPTIONS_VEH_SLIDER) sliderSetPosition (wmt_param_ViewDistance min (WMT_Options_ViewDistance select 1));

		(_dialog displayCtrl IDC_OPTIONS_AIR_SLIDER) sliderSetSpeed [100,100];
		(_dialog displayCtrl IDC_OPTIONS_AIR_SLIDER) slidersetRange [100,wmt_param_ViewDistance];
		(_dialog displayCtrl IDC_OPTIONS_AIR_SLIDER) sliderSetPosition (wmt_param_ViewDistance min (WMT_Options_ViewDistance select 2));

		(_dialog displayCtrl IDC_OPTIONS_SHIP_SLIDER) sliderSetSpeed [100,100];
		(_dialog displayCtrl IDC_OPTIONS_SHIP_SLIDER) slidersetRange [100,wmt_param_ViewDistance];
		(_dialog displayCtrl IDC_OPTIONS_SHIP_SLIDER) sliderSetPosition (wmt_param_ViewDistance min (WMT_Options_ViewDistance select 3));

		(_dialog displayCtrl IDC_OPTIONS_SPECT_SLIDER) sliderSetSpeed [100,100];
		(_dialog displayCtrl IDC_OPTIONS_SPECT_SLIDER) slidersetRange [100,MAX_DISTANCE];
		(_dialog displayCtrl IDC_OPTIONS_SPECT_SLIDER) sliderSetPosition (MAX_DISTANCE min (WMT_Options_ViewDistance select 4));
	};
	case "loop": {
		disableSerialization;

		private["_dist","_maxDist","_spectator","_fnc_state"];

		_fnc_state = {
			PR(_veh) = vehicle player;
			PR(_spectator) = uiNamespace getVariable "WMT_DisaplaySpectator";
			if(!(isNil "_spectator"))exitWith{4};
			if(_veh isKindOf "Air")exitWith{2};
			if(_veh isKindOf "LandVehicle")exitWith{1};
			if(_veh isKindOf "Ship")exitWith{3};
			0
		};

		WMT_Options_ViewDistance = profileNamespace getVariable ["HIA3_BG_ViewDistance",
		[MAX_DISTANCE, MAX_DISTANCE, MAX_DISTANCE, MAX_DISTANCE, MAX_DISTANCE]];

		while{true} do {
			_spectator = uiNamespace getVariable "WMT_DisaplaySpectator";
			_maxDist = if(isNil "_spectator")then{wmt_param_ViewDistance}else{MAX_DISTANCE};

			_dist = _maxDist min (WMT_Options_ViewDistance select ([] call _fnc_state));

			if(viewDistance != _dist) then {
				setViewDistance _dist;
			};

			sleep 0.1;
		};
	};
};
_return