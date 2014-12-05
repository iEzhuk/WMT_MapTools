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
			x 		= 0.55;
			y 		= 0.45;
			w 		= 0.40;
			h 		= 0.05;
			font 	= "puristaMedium";
			sizeEx 	= 0.035;
			size 	= 0.035;
			text 	= "";

			colorText[] 		= {1,1,1,1};
			colorBackground[] 	= {0,0,0,0};

			class Attributes {
				font 			= "PuristaMedium"; 
				align 			= "left"; 
				valign 			= "middle"; 
			};
		};
	};
};

