class RscWMTProgressBar
{
	idd			= 5100;
	fadeout		= 0;
	fadein		= 0;
	duration	= 9999999;
	onLoad		= "uiNamespace setVariable ['wMT_Disaply_ProgressBar', _this select 0]";
	onUnload	= "uiNamespace setVariable ['wMT_Disaply_ProgressBar', nil]";
	class controls
	{
		class Background
		{
			idc 	= 5100;
			type 	= 13;
			style 	= 0;
			x 		= 0.0 * safezoneW + safezoneX;
			y 		= 0.0 * safezoneH + safezoneY;
			w 		= 0.0 * safezoneW;
			h 		= 0.0 * safezoneH;
			font 	= "puristaMedium";
			sizeEx 	= 0.02;
			size 	= 0.02;
			text 	= "";

			colorText[] 		= {0,0,0,0};
			colorBackground[] 	= {0,0,0,0.5};
		};
		class Progress
		{
			idc 	= 5101;
			type 	= 13;
			style 	= 0;
			x 		= 0.0 * safezoneW + safezoneX;
			y 		= 0.0 * safezoneH + safezoneY;
			w 		= 0.0 * safezoneW;
			h 		= 0.0 * safezoneH;
			font 	= "puristaMedium";
			sizeEx 	= 0.02;
			size 	= 0.02;
			text 	= "";

			colorText[] 		= {0,0,0,0};
			colorBackground[] 	= {1,1,1,0.9};
		};
	};
};