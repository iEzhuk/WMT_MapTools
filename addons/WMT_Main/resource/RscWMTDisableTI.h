#define IDD_DISABLETI		59000
#define IDD_DISABLETI_TEXT	59001

class RscWMTDisableTI
{
	idd			= IDD_DISABLETI;
	fadeout		= 0;
	fadein		= 0;
	duration	= 100000;
	onLoad		= "['full', _this] spawn WMT_fnc_disableTI";

	class controls
	{
		class DisableTI
		{
			idc 	= IDD_DISABLETI_TEXT;
			type 	= 13;
			style 	= 0;
			x 		= 0.0 * safezoneW + safezoneX;
			y 		= 0.0 * safezoneH + safezoneY;
			w 		= 1.0 * safezoneW;
			h 		= 1.0 * safezoneH;
			font 	= "puristaMedium";
			sizeEx 	= 0.038;
			size 	= 0.038;
			text 	= "";

			colorText[] 		= {1,1,1,1};
			colorBackground[] 	= {0,0,0,0};

			class Attributes {
				font 			= "PuristaMedium"; 
				align 			= "center"; 
				valign 			= "middle"; 
			};
			class TextPos {
				left = 0.06;
				top = 0.46;
				right = 0.005;
				bottom = 0.005;
			};
		};
	};
};
