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
		class Background : RscText{
			colorBackground[] = {0, 0, 0, 0.75};
			idc = -1;
			x 	= 0.0 * safezoneW + safezoneX;
			y 	= 0.0 * safezoneH + safezoneY;
			w 	= 1.0 * safezoneW;
			h 	= 1.0 * safezoneH;
		};

		class Map : RscMapControl{
			idc = IDC_STARTPOS_MAP;
			x 	= 0.2 * safezoneW + safezoneX;
			y 	= 0.2 * safezoneH + safezoneY;
			w 	= 0.6 * safezoneW;
			h 	= 0.6 * safezoneH;
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