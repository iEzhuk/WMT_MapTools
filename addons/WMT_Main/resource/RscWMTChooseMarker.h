#define IDD_STARTPOS				62100
#define IDC_STARTPOS_MAP	 		62101 
#define IDC_STARTPOS_TEXT			62102

class RscMap;
class RscMapControl;
class RscWMTChooseMarker: RscMap {
	idd = IDD_STARTPOS;
	onLoad = "['init',_this] call WMT_fnc_chooseMarker_handler";
	onUnload = "['close',_this] call WMT_fnc_chooseMarker_handler";
	onKeyUp = "['keyUp',_this] call WMT_fnc_chooseMarker_handler";
	class controls {
		class bgpic
		{
			idc = 62103;
			text = "\WMT_Main\pic\tablet.paa";
			x = -0.57575;
			y = -0.1916;
			w = 2.175;
			h = 1.46822;
			access = 0;
			type = 0;
			style = 48;
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "TahomaB";
			sizeEx = 0;
			lineSpacing = 0;
			fixedWidth = 0;
			shadow = 0;
		};

		class hddpic
		{
			idc = 62104;
			text = "\wmt_main\pic\led_red.paa";
			x = -0.194948;
			y = 0.7;
			w = 0.194949;
			h = 0.2;
			access = 0;
			type = 0;
			style = 48;
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "TahomaB";
			sizeEx = 0;
			lineSpacing = 0;
			fixedWidth = 0;
			shadow = 0;
		};

		class netpic
		{
			idc = 62105;
			text = "\wmt_main\pic\led_blue.paa";
			x = -0.197096;
			y = 0.653604;
			w = 0.2;
			h = 0.2;
			access = 0;
			type = 0;
			style = 48;
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "TahomaB";
			sizeEx = 0;
			lineSpacing = 0;
			fixedWidth = 0;
			shadow = 0;
		};
    
		class Map : RscMapControl{
			idc = IDC_STARTPOS_MAP;
			x 	= 0.0124995;
			y 	= 0.00999999;
			w 	= 0.982322;
			h 	= 0.98148;
			sizeExNames = 0.044;
		};

		class Text : RscText{
			idc 	= IDC_STARTPOS_TEXT;
			type 	= 13;
			style 	= 0;
			x 		= 0.2 * safezoneW + safezoneX;
			y 		= 0.1 * safezoneH + safezoneY;
			w 		= 1.0 * safezoneW;
			h 		= 0.6 * safezoneH;
			font 	= "puristaMedium";
			sizeEx 	= 0.04;
			size 	= 0.04;
			text 	= "";

			colorText[] 		= {1,1,1,1};
			colorBackground[] 	= {0,0,0,0};
		};
	};
};