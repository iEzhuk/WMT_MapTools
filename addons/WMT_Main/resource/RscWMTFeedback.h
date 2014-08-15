#define IDD_FEEDBACK			63000
#define IDD_FEEDBACK_HEAD		63010
#define IDC_FEEDBACK_TEXT 		63001 
#define IDC_FEEDBACK_CLOSE 		63002
#define IDC_FEEDBACK_ADMIN	 	63003
#define IDC_FEEDBACK_ADMINNAME 	63004
#define IDC_FEEDBACK_SEND	 	63005

class RscWMTFeedback {
	movingEnable = 1;
	idd = IDD_FEEDBACK;
	onLoad = "['init',_this] call WMT_fnc_HandlerFeedback";
	onUnload = "['close',_this] call WMT_fnc_HandlerFeedback";
	class controlsBackground {
		class Background: RscText {
			colorBackground[] = {0, 0, 0, 0.75};
			idc = -1;
			x = 0.0;
			y = 0.35;
			w = 0.6;
			h = 0.18;
		};
		class BackgroundHead: RscText {
			colorBackground[] = {	"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])",
									"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])",
									"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",
									0.9
								};
			idc = IDD_FEEDBACK_HEAD;
			x = 0.00;
			y = 0.305;
			w = 0.6;
			h = 0.04;
			text = $STR_WMT_FeedBack;
		};
	};
	class controls {
		class Text : RscEdit{
			idc = IDC_FEEDBACK_TEXT;
			x = 0.05;
			y = 0.46;
			w = 0.5;
			h = 0.05;
			text = "";
		};
		class Admin : RscText{
			idc = IDC_FEEDBACK_ADMIN;
			x = 0.05;
			y = 0.36;
			w = 0.5;
			h = 0.04;
			text = $STR_WMT_GameAdmin;
		};
		class Admin_Name : RscText{
			idc = IDC_FEEDBACK_ADMINNAME;
			x = 0.1;
			y = 0.40;
			w = 0.4;
			h = 0.04;
			text = "";
			colorText[] = {0.85,0.57,0.11,1};
		};
		class Button_Send : RscWMTButton_ext {
			idc = IDC_FEEDBACK_SEND;
			x = 0.0;
			y = 0.535;
			text = $STR_WMT_Send;
			action = "['send',_this] call WMT_fnc_HandlerFeedback";
		};

		class Button_Close : RscWMTButton_ext {
			idc = IDC_FEEDBACK_CLOSE;
			x = 0.44;
			y = 0.535;
			text = $STR_WMT_Close;
			action = "closeDialog 0;";
		};
	};
};
