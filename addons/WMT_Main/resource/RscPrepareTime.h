class RscTimer
{
	idd			= 5010;
	fadeout		= 1;
	fadein		= 0;
	duration	= 2;
	onLoad		= "_this call Func_ShowTimer";

	class controls
	{
		class RscTimerText
		{
			idc 	= 5011;
			type 	= 13;
			style 	= 0;
			x 		= 0.38 * safezoneW + safezoneX;
			y 		= 0.00 * safezoneH + safezoneY;
			w 		= 0.24 * safezoneW;
			h 		= 0.04 * safezoneH;
			font 	= "puristaMedium";
			sizeEx 	= 0.02;
			size 	= 0.02;
			text 	= "";

			colorText[] 		= {1,1,1,1};
			colorBackground[] 	= {0,0,0,0.7};

			class Attributes {
				font 			= "PuristaMedium"; 
				align 			= "center"; 
				valign 			= "middle"; 
			};
		};
	};
};