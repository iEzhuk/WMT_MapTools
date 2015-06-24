#define IDC_OPTIONS_PRESET_1_SLIDER 171010
#define IDC_OPTIONS_PRESET_1_VALUE  171020
#define IDC_OPTIONS_PRESET_2_SLIDER 171011
#define IDC_OPTIONS_PRESET_2_VALUE  171021
#define IDC_OPTIONS_PRESET_3_SLIDER 171012
#define IDC_OPTIONS_PRESET_3_VALUE  171022

#define IDC_OPTIONS_MUTING_SLIDER   171050
#define IDC_OPTIONS_MUTING_VALUE    171051

#define IDC_OPTIONS_CHECK_NICKNAME	17090
#define IDC_OPTIONS_CHECK_MINVD		17091
#define IDC_OPTIONS_CHECK_FRZBEEP	17092

class RscButtonMenuOK;
class RscWMTOptions {
	movingEnable = 1;
	idd = IDD_OPTIONS_OPTIONS;
	onLoad = "['init',_this] call WMT_fnc_HandlerOptions";
	onUnload = "['close',_this] call WMT_fnc_HandlerOptions";
	class controlsBackground {
		class Background: RscText
		{
			x = 0.04;
			y = 0.16;
			w = 0.45;
			h = 0.7;
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
		// View distance: Preset 1
		//==========================
		class Text_Preset_1: RscText
		{
			text = $STR_WMT_Preset1;
			x = 0.05;
			y = 0.23;
			w = 0.13;
			h = 0.04;
		};
		class Slider_Preset_1: RscWMTXSliderH_ext
		{
			idc = IDC_OPTIONS_PRESET_1_SLIDER;
			x = 0.19;
			y = 0.23;
			w = 0.2;
			h = 0.04;
			onSliderPosChanged = "['setDistance',[_this,0]] call WMT_fnc_HandlerOptions";
		};
		class Value_Preset_1: RscText
		{
			idc = IDC_OPTIONS_PRESET_1_VALUE;
			text = "";
			x = 0.4;
			y = 0.23;
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
			y = 0.28;
			w = 0.13;
			h = 0.04;
		};
		class Slider_Preset_2: RscWMTXSliderH_ext
		{
			idc = IDC_OPTIONS_PRESET_2_SLIDER;
			x = 0.19;
			y = 0.28;
			w = 0.2;
			h = 0.04;
			onSliderPosChanged = "['setDistance',[_this,1]] call WMT_fnc_HandlerOptions";
		};
		class Value_Preset_2: RscText
		{
			idc = IDC_OPTIONS_PRESET_2_VALUE;
			text = "";
			x = 0.4;
			y = 0.28;
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
			y = 0.33;
			w = 0.13;
			h = 0.04;
		};
		class Slider_Preset_3: RscWMTXSliderH_ext
		{
			idc = IDC_OPTIONS_PRESET_3_SLIDER;
			x = 0.19;
			y = 0.33;
			w = 0.2;
			h = 0.04;
			onSliderPosChanged = "['setDistance',[_this,2]] call WMT_fnc_HandlerOptions";
		};
		class Value_Preset_3: RscText
		{
			idc = IDC_OPTIONS_PRESET_3_VALUE;
			text = "";
			x = 0.4;
			y = 0.33;
			w = 0.09;
			h = 0.04;
		};
		//==========================
		// Sound: Preset 1
		//==========================
		class Text_sound_settings: RscText
		{
			text = $STR_WMT_SoundSettings;
			x = 0.05;
			y = 0.45;
			w = 0.425;
			h = 0.04;
		};
		class Text_Muting: RscText
		{
			text = $STR_WMT_Muting;
			x = 0.05;
			y = 0.5;
			w = 0.13;
			h = 0.04;
		};
		class Slider_Muting: RscWMTXSliderH_ext
		{
			idc = IDC_OPTIONS_MUTING_SLIDER;
			x = 0.19;
			y = 0.5;
			w = 0.2;
			h = 0.04;
			onSliderPosChanged = "['setMutingLevel',[_this]] call WMT_fnc_HandlerOptions";
		};
		class Value_Muting: RscText
		{
			idc = IDC_OPTIONS_MUTING_VALUE;
			text = "";
			x = 0.4;
			y = 0.5;
			w = 0.09;
			h = 0.04;
		};		
		//==========================
		// Checkboxes
		//==========================
		class Text_UIShowNickName: RscText
		{
			text = $STR_WMT_UIShowNickName;
			x = 0.05;
			y = 0.62;
			w = 0.3;
			h = 0.04;
		};
		class Checkbox_UIShowNickName: RscCheckbox
		{
			idc = IDC_OPTIONS_CHECK_NICKNAME;
			x = 0.4;
			y = 0.62;
			w = 0.04*safeZoneH/safeZoneW;
			h = 0.04;
			onCheckedChanged = "profilenamespace setvariable ['WMT_ShowNickNameOption', (_this select 1)]";
		};
		class Text_LoadMinimalVD: RscText
		{
			idc = IDC_WMT_OPTIONS_RSCTEXT_1013;
			text = $STR_WMT_EnforceMaxVD;
			x = 0.05;
			y = 0.67;
			w = 0.3;
			h = 0.04;
		};
		class Checkbox_LoadMinimalVD: RscCheckbox
		{
			idc = IDC_OPTIONS_CHECK_MINVD;
			x = 0.4;
			y = 0.67;
			w = 0.04*safeZoneH/safeZoneW;
			h = 0.04;
			onCheckedChanged = "profilenamespace setvariable ['WMT_MaxVDonmissionStart', (_this select 1)]";
		};
		class Text_Beep: RscText
		{
			idc = IDC_WMT_OPTIONS_RSCTEXT_1014;
			text = $STR_WMT_PlaySoundOnFreezeEnd;
			x = 0.05;
			y = 0.72;
			w = 0.3;
			h = 0.04;
		};
		class Checkbox_Beep: RscCheckbox
		{
			idc = IDC_OPTIONS_CHECK_FRZBEEP;
			x = 0.4;
			y = 0.72;
			w = 0.04*safeZoneH/safeZoneW;
			h = 0.04;
			onCheckedChanged = "profilenamespace setvariable ['WMT_BeepAfterFreezeOption', (_this select 1)]";
		};

		class ButtonClose: RscButtonMenuOK
		{
			x = 0.34;
			y = 0.864;
			w = 0.15;
			h = 0.04;
			text = $STR_WMT_Close;
			action = "closedialog 0;";
		};
	};
};