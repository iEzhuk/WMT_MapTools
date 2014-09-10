#define IDD_ADMINPANEL				62000
#define IDC_ADMINPANEL_TEXT 		62001 
#define IDD_ADMINPANEL_CLOSE 		62002
#define IDD_ADMINPANEL_ANNOUNCEMENT 62003
#define IDD_ADMINPANEL_ENDMISSION 	62004
#define IDD_ADMINPANEL_TEXTTIME		62005
#define IDD_ADMINPANEL_ADD5			62006
#define IDD_ADMINPANEL_ADD10		62007
#define IDD_ADMINPANEL_SUB			62008	

class RscWMTAdminPanel {
	movingEnable = 1;
	idd = IDD_ADMINPANEL;
	onLoad = "['init',_this] call WMT_fnc_HandlerAdminPanel";
	onUnload = "['close',_this] call WMT_fnc_HandlerAdminPanel";
	class controlsBackground {
		class Background1: RscText {
			colorBackground[] = {0, 0, 0, 0.75};
			idc = -1;
			x = 0.0;
			y = 0.35; // 35+9=45+5 = 50
			w = 0.7;
			h = 0.09;
		};
		class Background2: RscText {
			colorBackground[] = {0, 0, 0, 0.75};
			idc = -1;
			x = 0.0;
			y = 0.50;
			w = 0.7;
			h = 0.09;
		};
		class BackgroundHead: RscText {
			colorBackground[] = {	"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])",
									"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])",
									"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",
									0.9
								};
			idc = -1;
			x = 0.00;
			y = 0.305;
			w = 0.7;
			h = 0.04;
			text = $STR_WMT_AdminPanel;
		};
	};
	class controls {
		class Text : RscEdit{
			idc = IDC_ADMINPANEL_TEXT;
			x = 0.05;
			y = 0.53;
			w = 0.6;
			h = 0.05;
			text = "";
		};
		class Button_Announcement : RscWMTButton_ext {
			idc = IDD_ADMINPANEL_ANNOUNCEMENT;
			x = 0.0;
			y = 0.595;
			w = 0.22;
			text = $STR_WMT_Announcement;
			action = "['announcement',_this] call WMT_fnc_HandlerAdminPanel";
		};
		class Button_EndMission : RscWMTButton_ext {
			idc = IDD_ADMINPANEL_ENDMISSION;
			x = 0.24;
			y = 0.595;
			w = 0.22;
			text = $STR_WMT_EndMission;
			action = "['endMission',_this] call WMT_fnc_HandlerAdminPanel";
		};
		class Button_Close : RscWMTButton_ext {
			idc = IDD_ADMINPANEL_CLOSE;
			x = 0.48;
			y = 0.595;
			w = 0.22;
			text = $STR_WMT_Close;
			action = "closeDialog 0;";
		};
		class Text_Time : RscText {
			idc = IDD_ADMINPANEL_TEXTTIME;
			x = 0.05;
			y = 0.375;
			w = 0.4;
			text = "Left time: 45:12"; 
		};
		class Button_addTime10: RscWMTButton_ext{
			idc = IDD_ADMINPANEL_ADD10;
			x = 0.48;
			y = 0.445;
			w = 0.22;
			text = $STR_WMT_Add10Min;
			action = "['changeTime',10] call WMT_fnc_HandlerAdminPanel";
		};
		class Button_addTime5: RscWMTButton_ext{
			idc = IDD_ADMINPANEL_ADD5;
			x = 0.24;
			y = 0.445;
			w = 0.22;
			text = $STR_WMT_Add5Min;
			action = "['changeTime',5] call WMT_fnc_HandlerAdminPanel";
		};
		class Button_subtractTime: RscWMTButton_ext{
			idc = IDD_ADMINPANEL_SUB;
			x = 0.0;
			y = 0.445;
			w = 0.22;
			text = $STR_WMT_Sub5Min;
			action = "['changeTime',-5] call WMT_fnc_HandlerAdminPanel";
		};
	};
};

