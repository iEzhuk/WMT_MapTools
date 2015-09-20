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

        (_dialog displayCtrl IDC_OPTIONS_PRESET_1_SLIDER) sliderSetSpeed [100,100];
        (_dialog displayCtrl IDC_OPTIONS_PRESET_1_SLIDER) slidersetRange [100,wmt_param_MaxViewDistance];
        (_dialog displayCtrl IDC_OPTIONS_PRESET_2_SLIDER) sliderSetSpeed [100,100];
        (_dialog displayCtrl IDC_OPTIONS_PRESET_2_SLIDER) slidersetRange [100,wmt_param_MaxViewDistance];
        (_dialog displayCtrl IDC_OPTIONS_PRESET_3_SLIDER) sliderSetSpeed [100,100];
        (_dialog displayCtrl IDC_OPTIONS_PRESET_3_SLIDER) slidersetRange [100,wmt_param_MaxViewDistance];
        
        (_dialog displayCtrl IDC_OPTIONS_TERRAIN_SLIDER) sliderSetSpeed [100,100];
        (_dialog displayCtrl IDC_OPTIONS_TERRAIN_SLIDER) slidersetRange [wmt_param_MaxViewDistance,wmt_param_MaxViewDistanceTerrain];

        (_dialog displayCtrl IDC_OPTIONS_MUTING_SLIDER) sliderSetSpeed [0.01,0.01];
        (_dialog displayCtrl IDC_OPTIONS_MUTING_SLIDER) slidersetRange [0.01,0.6];

        ['update'] call WMT_fnc_HandlerOptions;
    };
    case "close": {
        uiNamespace setVariable ["WMT_Dialog_Menu", nil];
    };
    case "setDistance": {
        PR(_slider) = _arg select 0;
        PR(_index) = _arg select 1;
        PR(_dist) = _slider select 1;
        PR(_dialog) = uiNamespace getVariable "WMT_Dialog_Menu";
        PR(_ctrlVar) = IDC_OPTIONS_PRESET_1_VALUE + _index;
        PR(_ctrlSlider) = IDC_OPTIONS_PRESET_1_SLIDER + _index;

        _dist = (floor(_dist/100))*100;

        WMT_Options_ViewDistance set [_index, _dist];

        (_dialog displayCtrl _ctrlVar) ctrlSetText str(wmt_param_MaxViewDistance min _dist);
        (_dialog displayCtrl _ctrlSlider) sliderSetPosition (wmt_param_MaxViewDistance min _dist);

        if (_index == 0) then {
            (_dialog displayCtrl IDC_OPTIONS_TERRAIN_SLIDER) slidersetRange [_dist,wmt_param_MaxViewDistanceTerrain];
        };
        
        profilenamespace setvariable ['WMT_Profile_ViewDistance_Presets', WMT_Options_ViewDistance];
        ['updateViewDistance'] call WMT_fnc_HandlerOptions;
    };
    case "setDistanceTerrain": {
        PR(_slider) = _arg select 0;
        PR(_dist) = _slider select 1;
        PR(_dialog) = uiNamespace getVariable "WMT_Dialog_Menu";
        PR(_ctrlVar) = IDC_OPTIONS_TERRAIN_VALUE;
        PR(_ctrlSlider) = IDC_OPTIONS_TERRAIN_SLIDER;

        _dist = (floor(_dist/100))*100;

        WMT_Options_ViewDistanceTerrain = _dist;

        (_dialog displayCtrl _ctrlVar) ctrlSetText str(wmt_param_MaxViewDistanceTerrain min _dist);
        (_dialog displayCtrl _ctrlSlider) sliderSetPosition (wmt_param_MaxViewDistanceTerrain min _dist);

        profilenamespace setvariable ['WMT_Profile_ViewDistance_Terrain', WMT_Options_ViewDistanceTerrain];
        ['updateViewDistance'] call WMT_fnc_HandlerOptions;
    };
    case "setMutingLevel": {
        private ["_slider","_index"];
        PR(_slider) = _arg select 0;
        PR(_index) = _arg select 1;
        PR(_lvl) = _slider select 1;
        PR(_dialog) = uiNamespace getVariable "WMT_Dialog_Menu";

        _lvl = floor(100*_lvl)/100;

        WMT_Options_Muting = _lvl;

        (_dialog displayCtrl IDC_OPTIONS_MUTING_SLIDER) sliderSetPosition (WMT_Options_Muting);
        (_dialog displayCtrl IDC_OPTIONS_MUTING_VALUE)  ctrlSetText str(WMT_Options_Muting);

        profilenamespace setvariable ['WMT_Profile_Muting', WMT_Options_Muting];

        if (WMT_Options_Muted) then {
            0.1 fadeSound WMT_Options_Muting;
            missionNameSpace setVariable ["AGM_Hearing_disableVolumeUpdate", true];
            WMT_SoundCurrentLevel = WMT_Options_Muting;
        };
    };
    case "update": {
        PR(_dialog) = uiNamespace getVariable "WMT_Dialog_Menu";

        (_dialog displayCtrl IDC_OPTIONS_FOOT_VAR) ctrlSetText str(wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select 0));
        (_dialog displayCtrl IDC_OPTIONS_VEH_VAR) ctrlSetText str(wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select 1));


        (_dialog displayCtrl IDC_OPTIONS_PRESET_1_SLIDER) sliderSetPosition (wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select 0));
        (_dialog displayCtrl IDC_OPTIONS_PRESET_2_SLIDER) sliderSetPosition (wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select 1));
        (_dialog displayCtrl IDC_OPTIONS_PRESET_3_SLIDER) sliderSetPosition (wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select 2));
        (_dialog displayCtrl IDC_OPTIONS_TERRAIN_SLIDER)  sliderSetPosition (wmt_param_MaxViewDistanceTerrain min WMT_Options_ViewDistanceTerrain);
        (_dialog displayCtrl IDC_OPTIONS_MUTING_SLIDER)   sliderSetPosition (WMT_Options_Muting);

        (_dialog displayCtrl IDC_OPTIONS_PRESET_1_VALUE) ctrlSetText str(wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select 0));
        (_dialog displayCtrl IDC_OPTIONS_PRESET_2_VALUE) ctrlSetText str(wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select 1));
        (_dialog displayCtrl IDC_OPTIONS_PRESET_3_VALUE) ctrlSetText str(wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select 2));
        (_dialog displayCtrl IDC_OPTIONS_TERRAIN_VALUE)  ctrlSetText str(wmt_param_MaxViewDistanceTerrain min WMT_Options_ViewDistanceTerrain);
        (_dialog displayCtrl IDC_OPTIONS_MUTING_VALUE)   ctrlSetText str(WMT_Options_Muting);

        (_dialog displayCtrl IDC_OPTIONS_CHECK_NICKNAME) cbSetChecked ((profilenamespace getvariable ['WMT_ShowNickNameOption', 1]) == 1);
        (_dialog displayCtrl IDC_OPTIONS_CHECK_FRZBEEP)  cbSetChecked ((profilenamespace getvariable ['WMT_BeepAfterFreezeOption', 0]) == 1);
        (_dialog displayCtrl IDC_OPTIONS_SAVE_TERRAIN)   cbSetChecked ((profilenamespace getvariable ['WMT_Profile_ViewDistance_TerraineSave', 0]) == 1);
    };
    case "updateViewDistance": {
        PR(_dist) = wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select WMT_Options_ViewDistance_Preset);
        PR(_distterrain) = (wmt_param_MaxViewDistanceTerrain min WMT_Options_ViewDistanceTerrain);

        if (WMT_Options_ViewDistance_Preset == 0) then {
            setObjectViewDistance _dist;
            setViewDistance _distterrain;
        } else {
            setObjectViewDistance _dist;
            setViewDistance _dist;
        };
    };
    case "preinit": {
        private["_dist","_maxDist","_spectator","_state"];

        WMT_Options_ViewDistance = profilenamespace getvariable ['WMT_Profile_ViewDistance_Presets', [wmt_param_MaxViewDistance,wmt_param_MaxViewDistance,wmt_param_MaxViewDistance]];

        if (profilenamespace getvariable ['WMT_Profile_ViewDistance_TerraineSave', 0] == 1) then {
            WMT_Options_ViewDistanceTerrain = WMT_Options_ViewDistance max profilenamespace getvariable ['WMT_Profile_ViewDistance_Terrain', wmt_param_MaxViewDistanceTerrain];
        } else {
            WMT_Options_ViewDistanceTerrain = wmt_param_MaxViewDistance;
        };

        WMT_Options_Muting = profilenamespace getvariable ['WMT_Profile_Muting',0.6];
        WMT_Options_ViewDistance_Preset = 0;

        WMT_Options_Muted = false;
        WMT_SoundCurrentLevel = 1;

        // Set max distance in first preset
        WMT_Options_ViewDistance set [0, wmt_param_MaxViewDistance];
    };
    case 'action_vd_preset': {
        WMT_Options_ViewDistance_Preset = _arg;
        hint format ["%1:\n%2", localize"STR_WMT_ViewDistance", wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select WMT_Options_ViewDistance_Preset)];

        _dist = wmt_param_MaxViewDistance min (WMT_Options_ViewDistance select WMT_Options_ViewDistance_Preset);
        _distterrain = (wmt_param_MaxViewDistanceTerrain min WMT_Options_ViewDistanceTerrain);

        if (WMT_Options_ViewDistance_Preset == 0) then {
            setViewDistance _distterrain;
            setObjectViewDistance _dist;
        } else {
           setViewDistance _dist;
           setObjectViewDistance _dist; 
        };
    };
    case 'action_muting': {
        WMT_Options_Muted = !WMT_Options_Muted;
        if (WMT_Options_Muted) then {
            hint format [localize "STR_WMT_ReducedSound", WMT_Options_Muting];
            0.1 fadeSound WMT_Options_Muting;
            missionNameSpace setVariable ["AGM_Hearing_disableVolumeUpdate", true];
            WMT_SoundCurrentLevel = WMT_Options_Muting;
        } else {
            hint localize "STR_WMT_RestoredSound";            
            0.1 fadeSound 1;
            missionNameSpace setVariable ["AGM_Hearing_disableVolumeUpdate", false];
            WMT_SoundCurrentLevel = 1;
        };
    };
};
_return