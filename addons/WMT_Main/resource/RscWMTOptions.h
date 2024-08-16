#define IDD_OPTIONS                 171000
#define IDC_OPTIONS_PRESET_1_SLIDER 171010
#define IDC_OPTIONS_PRESET_1_VALUE  171020
#define IDC_OPTIONS_PRESET_2_SLIDER 171011
#define IDC_OPTIONS_PRESET_2_VALUE  171021
#define IDC_OPTIONS_PRESET_3_SLIDER 171012
#define IDC_OPTIONS_PRESET_3_VALUE  171022
#define IDC_OPTIONS_TERRAIN_SLIDER  171013
#define IDC_OPTIONS_TERRAIN_VALUE   171023
#define IDC_OPTIONS_SHADOW_SLIDER  171014
#define IDC_OPTIONS_SHADOW_VALUE   171024
#define IDC_OPTIONS_PIP_SLIDER  171015
#define IDC_OPTIONS_PIP_VALUE   171025

#define IDC_OPTIONS_MUTING_SLIDER   171050
#define IDC_OPTIONS_MUTING_VALUE    171051

#define IDC_OPTIONS_CHECK_NICKNAME  17090
#define IDC_OPTIONS_SAVE_TERRAIN    17091
#define IDC_OPTIONS_CHECK_FRZBEEP   17092

class RscButtonMenuOK;
class RscWMTOptions {
    movingEnable = 1;
    idd = IDD_OPTIONS;
    onLoad = "['init',_this] call WMT_fnc_HandlerOptions";
    onUnload = "['close',_this] call WMT_fnc_HandlerOptions";
    class controlsBackground {
        class Background: RscText
        {
            x = 0.04;
            y = 0.16;
            w = 0.45;
            h = 0.67;
            colorBackground[] = {0,0,0,0.75};
        };
        class Title: RscText
        {
            text = $STR_WMT_Options;
            x = 0.04;
            y = 0.116;
            w = 0.45;
            h = 0.04;
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.9};
        };
    };
    class controls {
        class Text_ViewDistance: RscText
        {
            text = $STR_WMT_ViewDistance;
            x = 0.05;
            y = 0.18;
            w = 0.425;
            h = 0.04;
        };
        //==========================
        // View distance: Terrain
        //==========================
        class Text_Terrain: RscText
        {
            text = $STR_WMT_Terrain;
            x = 0.05;
            y = 0.23;
            w = 0.13;
            h = 0.04;
            tooltip = $STR_WMT_Tooltip_terrain;
        };
        class Slider_Terrain: RscWMTXSliderH_ext
        {
            idc = IDC_OPTIONS_TERRAIN_SLIDER;
            x = 0.19;
            y = 0.23;
            w = 0.2;
            h = 0.04;
            onSliderPosChanged = "['setDistanceEx',[_this]] call WMT_fnc_HandlerOptions";
        };
        class Value_Terrain: RscText
        {
            idc = IDC_OPTIONS_TERRAIN_VALUE;
            text = "";
            x = 0.4;
            y = 0.23;
            w = 0.09;
            h = 0.04;
        };
        //==========================
        // View distance: Preset 1
        //==========================
        class Text_Preset_1: RscText
        {
            text = $STR_WMT_Preset1;
            x = 0.05;
            y = 0.23 + 0.05 * 1;
            w = 0.13;
            h = 0.04;
            tooltip = $STR_WMT_Tooltip_preset1;
        };
        class Slider_Preset_1: RscWMTXSliderH_ext
        {
            idc = IDC_OPTIONS_PRESET_1_SLIDER;
            x = 0.19;
            y = 0.23 + 0.05 * 1;
            w = 0.2;
            h = 0.04;
            onSliderPosChanged = "['setDistanceEx',[_this,0]] call WMT_fnc_HandlerOptions";
        };
        class Value_Preset_1: RscText
        {
            idc = IDC_OPTIONS_PRESET_1_VALUE;
            text = "";
            x = 0.4;
            y = 0.23 + 0.05 * 1;
            w = 0.13;
            h = 0.04;
        };
        //==========================
        // View distance: Preset 2
        //==========================
        class Text_Preset_2: RscText
        {
            text = $STR_WMT_Preset2;
            x = 0.05;
            y = 0.23 + 0.05 * 2;
            w = 0.13;
            h = 0.04;
            tooltip = $STR_WMT_Tooltip_preset2;
        };
        class Slider_Preset_2: RscWMTXSliderH_ext
        {
            idc = IDC_OPTIONS_PRESET_2_SLIDER;
            x = 0.19;
            y = 0.23 + 0.05 * 2;
            w = 0.2;
            h = 0.04;
            onSliderPosChanged = "['setDistanceEx',[_this,1]] call WMT_fnc_HandlerOptions";
        };
        class Value_Preset_2: RscText
        {
            idc = IDC_OPTIONS_PRESET_2_VALUE;
            text = "";
            x = 0.4;
            y = 0.23 + 0.05 * 2;
            w = 0.09;
            h = 0.04;
        };
        //==========================
        // View distance: Preset 3
        //==========================
        class Text_Preset_3: RscText
        {
            text = $STR_WMT_Preset3;
            x = 0.05;
            y = 0.23 + 0.05 * 3;
            w = 0.13;
            h = 0.04;
            tooltip = $STR_WMT_Tooltip_preset3;
        };
        class Slider_Preset_3: RscWMTXSliderH_ext
        {
            idc = IDC_OPTIONS_PRESET_3_SLIDER;
            x = 0.19;
            y = 0.23 + 0.05 * 3;
            w = 0.2;
            h = 0.04;
            onSliderPosChanged = "['setDistanceEx',[_this,2]] call WMT_fnc_HandlerOptions";
        };
        class Value_Preset_3: RscText
        {
            idc = IDC_OPTIONS_PRESET_3_VALUE;
            text = "";
            x = 0.4;
            y = 0.23 + 0.05 * 3;
            w = 0.09;
            h = 0.04;
        };
        //==========================
        // PIP distance 
        //==========================
        class Text_PIP: RscText
        {
            text = $STR_WMT_PRESET_PIP;
            x = 0.05;
            y = 0.23 + 0.05 * 4;
            w = 0.13;
            h = 0.04;
            tooltip = $STR_WMT_PRESET_PIP;
        };
        class Slider_PIP: RscWMTXSliderH_ext
        {
            idc = IDC_OPTIONS_PIP_SLIDER;
            x = 0.19;
            y = 0.23 + 0.05 * 4;
            w = 0.2;
            h = 0.04;
            onSliderPosChanged = "['setDistanceEx',[_this,3]] call WMT_fnc_HandlerOptions";
        };
        class Value_PIP: RscText
        {
            idc = IDC_OPTIONS_PIP_VALUE;
            text = "";
            x = 0.4;
            y = 0.23 + 0.05 * 4;
            w = 0.09;
            h = 0.04;
        };
        //==========================
        // Shadow distance
        //==========================
        class Text_Shadow: RscText
        {
            text = $STR_WMT_PRESET_SHADOWS;
            x = 0.05;
            y = 0.23 + 0.05 * 5;
            w = 0.13;
            h = 0.04;
            tooltip = $STR_WMT_PRESET_SHADOWS;
        };
        class Slider_Shadow: RscWMTXSliderH_ext
        {
            idc = IDC_OPTIONS_SHADOW_SLIDER;
            x = 0.19;
            y = 0.23 + 0.05 * 5;
            w = 0.2;
            h = 0.04;
            onSliderPosChanged = "['setDistanceEx',[_this,4]] call WMT_fnc_HandlerOptions";
        };
        class Value_Shadow: RscText
        {
            idc = IDC_OPTIONS_SHADOW_VALUE;
            text = "";
            x = 0.4;
            y = 0.23 + 0.05 * 5;
            w = 0.09;
            h = 0.04;
        };

        //==========================
        // Mute sound
        //==========================
        class Text_sound_settings: RscText
        {
            text = $STR_WMT_SoundSettings;
            x = 0.05;
            y = 0.23 + 0.05 * 6;
            w = 0.425;
            h = 0.04;
        };
        class Text_Muting: RscText
        {
            text = $STR_WMT_Muting;
            x = 0.05;
            y = 0.23 + 0.05 * 7;
            w = 0.13;
            h = 0.04;
            tooltip = $STR_WMT_Tooltip_mute;
        };
        class Slider_Muting: RscWMTXSliderH_ext
        {
            idc = IDC_OPTIONS_MUTING_SLIDER;
            x = 0.19;
            y = 0.23 + 0.05 * 7;
            w = 0.2;
            h = 0.04;
            onSliderPosChanged = "['setMutingLevel',[_this]] call WMT_fnc_HandlerOptions";
        };
        class Value_Muting: RscText
        {
            idc = IDC_OPTIONS_MUTING_VALUE;
            text = "";
            x = 0.4;
            y = 0.23 + 0.05 * 7;
            w = 0.09;
            h = 0.04;
        };
        //==========================
        // Checkboxes
        //==========================
        class Text_SaveTerrainSettings: RscText
        {
            text = $STR_WMT_SaveTerrainSettings;
            x = 0.05;
            y = 0.23 + 0.05 * 8;
            w = 0.35;
            h = 0.04;
            tooltip = $STR_WMT_Tooltip_Checkbox_terrain;
        };
        class Checkbox_SaveTerrainSettings: RscCheckbox
        {
            idc = IDC_OPTIONS_SAVE_TERRAIN;
            x = 0.42;
            y = 0.23 + 0.05 * 8;
            w = 0.04*safeZoneH/safeZoneW;
            h = 0.04;
            onCheckedChanged = "profilenamespace setvariable ['WMT_Profile_ViewDistance_TerraineSave', (_this select 1)]";
        };
        class Text_UIShowNickName: RscText
        {
            text = $STR_WMT_UIShowNickName;
            x = 0.05;
            y = 0.23 + 0.05 * 9;
            w = 0.35;
            h = 0.04;
        };
        class Checkbox_UIShowNickName: RscCheckbox
        {
            idc = IDC_OPTIONS_CHECK_NICKNAME;
            x = 0.42;
            y = 0.23 + 0.05 * 9;
            w = 0.04*safeZoneH/safeZoneW;
            h = 0.04;
            onCheckedChanged = "profilenamespace setvariable ['WMT_ShowNickNameOption', (_this select 1)]";
        };
        class Text_Beep: RscText
        {
            idc = IDC_WMT_OPTIONS_RSCTEXT_1014;
            text = $STR_WMT_PlaySoundOnFreezeEnd;
            x = 0.05;
            y = 0.23 + 0.05 * 10;
            w = 0.35;
            h = 0.04;
        };
        class Checkbox_Beep: RscCheckbox
        {
            idc = IDC_OPTIONS_CHECK_FRZBEEP;
            x = 0.42;
            y = 0.23 + 0.05 * 10;
            w = 0.04*safeZoneH/safeZoneW;
            h = 0.04;
            onCheckedChanged = "profilenamespace setvariable ['WMT_BeepAfterFreezeOption', (_this select 1)]";
        };

        class ButtonClose: RscButtonMenuOK
        {
            x = 0.34;
            y = 0.834 ;
            w = 0.15;
            h = 0.04;
            text = $STR_WMT_Close;
            action = "closedialog 0;";
        };
    };
};
