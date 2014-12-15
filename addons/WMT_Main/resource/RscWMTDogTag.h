#define IDC_WMT_DOGTAGTEXT		59167
#define IDC_WMT_DOGTAGPIC		59168

class RscWMTDogTag
{
	idd			= -1;
	fadeout		= 0;
	fadein		= 0;
	duration	= 10;
	onLoad		= "uiNamespace setVariable ['RscWMTDogTag', _this select 0]";
	onUnLoad	= "uiNamespace setVariable ['RscWMTDogTag', nil]";


	class controlsBackground
	{
		class RscWMTDogTagPic
		{
			idc = IDC_WMT_DOGTAGPIC;
			text = "\wmt_main\pic\dogtag.paa";
			x = 0.0375;
			y = 0.46;
			w = 0.6;
			h = 0.39;
			fade = 0;
			type = 0;
			style = 48;
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "TahomaB";
			sizeEx = 0;
			lineSpacing = 0;
			fixedWidth = 0;
			shadow = 0;
			tooltipColorText[] = {1,1,1,1};
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,0.65};
		};
	};

	class controls
	{
		class RscWMTDogTagText
		{
			idc 	= IDC_WMT_DOGTAGTEXT;
			type 	= 0;
			style 	= 0x02;
			x = 0.0375;
			y = 0.46;
			w = 0.6;
			h = 0.39;
			fixedWidth = 0;
			font 	= "puristaMedium";
			sizeEx 	= 0.04;
			size 	= 0.04;
			shadow	= 1;
			text 	= "";
			colorText[] 		= {0.565,0.549,0.533,1};
			colorBackground[] 	= {0,0,0,0};
			colorShadow[] = { 1,1,1,0.5};
			linespacing = 1;


		};
	};
};

