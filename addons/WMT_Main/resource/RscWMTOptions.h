#define IDD_OPTIONS_OPTIONS 		17000
#define IDC_OPTIONS_FOOT_TEXT 		17001
#define IDC_OPTIONS_FOOT_SLIDER 	17011
#define IDC_OPTIONS_FOOT_VAR 		17021
#define IDC_OPTIONS_VEH_TEXT 		17002
#define IDC_OPTIONS_VEH_SLIDER 		17012
#define IDC_OPTIONS_VEH_VAR 		17022
#define IDC_OPTIONS_AIR_TEXT 		17003
#define IDC_OPTIONS_AIR_SLIDER 		17013
#define IDC_OPTIONS_AIR_VAR 		17023
#define IDC_OPTIONS_SHIP_TEXT 		17004
#define IDC_OPTIONS_SHIP_SLIDER 	17014
#define IDC_OPTIONS_SHIP_VAR 		17024
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
			h = 0.37;
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


		class Text_LandVehicle : RscText {
			idc = IDC_OPTIONS_VEH_TEXT;
			x = 0.05;
			y = 0.44;
			w = 0.4;
			h = 0.04;
			text = $STR_WMT_InLandVehicle;
		};
		class Slider_LandVehicle : RscWMTXSliderH_ext {
			idc = IDC_OPTIONS_VEH_SLIDER;
			x = 0.05;
			y = 0.48;
			w = 0.4;
			h = 0.04;
			onSliderPosChanged = "['setDistance',[_this,1]] call WMT_fnc_HandlerOptions";
		};
		class Var_LandVehicle : RscText {
			idc = IDC_OPTIONS_VEH_VAR;
			x = 0.48;
			y = 0.48;
			w = 0.1;
			h = 0.04;
			text = "";
		};
		class Text_Air : RscText {
			idc = IDC_OPTIONS_AIR_TEXT;
			x = 0.05;
			y = 0.52;
			w = 0.4;
			h = 0.04;
			text = $STR_WMT_InAirVehicle;
		};
		class Slider_Air : RscWMTXSliderH_ext {
			idc = IDC_OPTIONS_AIR_SLIDER;
			x = 0.05;
			y = 0.56;
			w = 0.4;
			h = 0.04;
			onSliderPosChanged = "['setDistance',[_this,2]] call WMT_fnc_HandlerOptions";
		};
		class Var_Air : RscText {
			idc = IDC_OPTIONS_AIR_VAR;
			x = 0.48;
			y = 0.56;
			w = 0.1;
			h = 0.04;
			text = "";
		};
		class Text_Water : RscText {
			idc = IDC_OPTIONS_SHIP_TEXT;
			x = 0.05;
			y = 0.60;
			w = 0.4;
			h = 0.04;
			text = $STR_WNT_OnShip;
		};
		class Slider_Water : RscWMTXSliderH_ext {
			idc = IDC_OPTIONS_SHIP_SLIDER;
			x = 0.05;
			y = 0.64;
			w = 0.4;
			h = 0.04;
			onSliderPosChanged = "['setDistance',[_this,3]] call WMT_fnc_HandlerOptions";
		};
		class Var_Water : RscText {
			idc = IDC_OPTIONS_SHIP_VAR;
			x = 0.48;
			y = 0.64;
			w = 0.1;
			h = 0.04;
			text = "";
		};
		class ButtonMaxDistance : RscWMTButton_ext {
			idc = IDC_OPTIONS_MAX;
			x = 0.0;
			y = 0.725;
			text = $STR_WMT_MaxDistance;
			action = "['max'] call WMT_fnc_HandlerOptions";
		};
		class ButtonClose : RscWMTButton_ext {
			idc = IDC_OPTIONS_CLOSE;
			x = 0.44;
			y = 0.725;
			text = $STR_WMT_Close;
			action = "closedialog 0;";
		};
	};
};

