#define IDD_MENU_MAINMENU 61000
#define IDC_MENU_OPTION 61001 
#define IDC_MENU_ADMIN 61002
#define IDC_MENU_CLOSE 61003

class RscWMTMainMenu {
	idd = IDD_DSIAPLAY_MAINMENU;
	onLoad = "['init',_this] call WMT_fnc_HandlerMenu";
	onUnload = "['close',_this] call WMT_fnc_HandlerMenu";
	class controlsBackground {
	
		class BackgroundTop: RscWMTText_ext {
			colorBackground[] = {0, 0, 0, 0.700000};
			idc = -1;
			x = 0.02;
			y = 0.18;
			w = 0.3;
			h = 0.07;
			text = $STR_WMT_MainMenu;
		};
	};
	class controls {
		class Button_Options: RscWMTButtonMenu_ext
		{
			idc = IDC_MENU_OPTION;
			x = 0.02;
			y = 0.255;
			text = $STR_WMT_Options;
			action = "['options',_this] call WMT_fnc_HandlerMenu";
		};
		class Button_FeedBack: RscWMTButtonMenu_ext
		{
			idc = IDC_MENU_ADMIN;
			x = 0.02;
			y = 0.360;
			text = $STR_WMT_FeedBack;
			action = "['admin',_this] call WMT_fnc_HandlerMenu";
		};
		class Button_Close : RscWMTButtonMenu_ext {
			idc = IDC_MENU_CLOSE;
			x = 0.02;
			y = 0.465;
			text = $STR_WMT_Close;
			action = "closeDialog 0;";
		};
	};
};