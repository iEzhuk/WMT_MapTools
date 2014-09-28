#define IDD_OPTIONS_OPTIONS 		17000
#define IDC_OPTIONS_FOOT_TEXT 		17001
#define IDC_OPTIONS_FOOT_SLIDER 	17011
#define IDC_OPTIONS_FOOT_VAR 		17021
#define IDC_OPTIONS_VEH_TEXT 		17002
#define IDC_OPTIONS_VEH_SLIDER 		17012
#define IDC_OPTIONS_VEH_VAR 		17022
#define IDC_OPTIONS_MAX				17090
#define IDC_OPTIONS_CLOSE 			17091

class RscWMTOptions {
	movingEnable = 1;
	idd = IDD_OPTIONS_OPTIONS;
	onLoad = "['init',_this] call WMT_fnc_HandlerOptions";
	onUnload = "['close',_this] call WMT_fnc_HandlerOptions";
	class controlsBackground {
		class Background: RscText {
			colorBackground[] = {0, 0, 0, 0.75};
			idc = -1;
			x = 0.0;
			y = 0.35;
			w = 0.6;
			h = 0.22;
		};
		class BackgroundHead: RscText {
			colorBackground[] = {	"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])",
									"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])",
									"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",
									0.9
								};
			x = 0.00;
			y = 0.305;
			w = 0.6;
			h = 0.04;
			text = $STR_WMT_Options;
		};
	};
	class controls {
		class Text_Foot : RscText {
			idc = IDC_OPTIONS_FOOT_TEXT;
			x = 0.05;
			y = 0.36;
			w = 0.4;
			h = 0.04;
			text = $STR_WMT_OnFoot;
		};
		class Slider_Foot : RscWMTXSliderH_ext {
			idc = IDC_OPTIONS_FOOT_SLIDER;
			x = 0.05;
			y = 0.4;
			w = 0.4;
			h = 0.04;
			onSliderPosChanged = "['setDistance',[_this,0]] call WMT_fnc_HandlerOptions";
		};
		class Var_Foot : RscText {
			idc = IDC_OPTIONS_FOOT_VAR;
			x = 0.48;
			y = 0.4;
			w = 0.1;
			h = 0.04;
			text = "";
		};		
		class Text_Vehicle : RscText {
			idc = IDC_OPTIONS_VEH_TEXT;
			x = 0.05;
			y = 0.44;
			w = 0.4;
			h = 0.04;
			text = $STR_WMT_InLandVehicle;
		};
		class Slider_Vehicle : RscWMTXSliderH_ext {
			idc = IDC_OPTIONS_VEH_SLIDER;
			x = 0.05;
			y = 0.48;
			w = 0.4;
			h = 0.04;
			onSliderPosChanged = "['setDistance',[_this,1]] call WMT_fnc_HandlerOptions";
		};
		class Var_Vehicle : RscText {
			idc = IDC_OPTIONS_VEH_VAR;
			x = 0.48;
			y = 0.48;
			w = 0.1;
			h = 0.04;
			text = "";
		};
		class ButtonMaxDistance : RscWMTButton_ext {
			idc = IDC_OPTIONS_MAX;
			x = 0.0;
			y = 0.575;
			text = $STR_WMT_MaxDistance;
			action = "['max'] call WMT_fnc_HandlerOptions";
		};
		class ButtonClose : RscWMTButton_ext {
			idc = IDC_OPTIONS_CLOSE;
			x = 0.44;
			y = 0.575;
			text = $STR_WMT_Close;
			action = "closedialog 0;";
		};
	};
};

