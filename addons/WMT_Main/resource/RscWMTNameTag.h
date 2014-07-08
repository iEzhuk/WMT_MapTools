#define IDD_NAMETAG 		59100
#define IDC_NAMETAG_TEXT 	59101

class RscWMTNameTag
{
	idd			= IDD_NAMETAG;
	fadeout		= 0;
	fadein		= 0;
	duration	= 90000;
	onLoad		= "_this spawn WMT_fnc_nameTag";

	class controls
	{
		class RscPlayerNameText
		{
			idc 	= IDC_NAMETAG_TEXT;
			type 	= 13;
			style 	= 0;
			x 		= 0.30 * safezoneW + safezoneX;
			y 		= 0.70 * safezoneH + safezoneY;
			w 		= 0.40 * safezoneW;
			h 		= 0.05 * safezoneH;
			font 	= "puristaMedium";
			sizeEx 	= 0.045;
			size 	= 0.045;
			text 	= "";

			colorText[] 		= {1,1,1,1};
			colorBackground[] 	= {0,0,0,0};

			class Attributes {
				font 			= "PuristaMedium"; 
				align 			= "center"; 
				valign 			= "middle"; 
			};
		};
	};
};

