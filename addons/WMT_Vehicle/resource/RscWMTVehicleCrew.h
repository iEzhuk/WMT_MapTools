class RscWMTVehicleCrew
{
	idd			= 5000;
	fadeout		= 0;
	fadein		= 0;
	duration	= 3;
	onLoad		= "_this call WMT_fnc_ShowCrew;";

	class controls
	{
		class RscWMTVehicleCrewText
		{
			idc 	= 5001;
			type 	= 13;
			style 	= 0;
			x 		= 0.80 * safezoneW + safezoneX;
			y 		= 0.25 * safezoneH + safezoneY;
			w 		= 0.20 * safezoneW;
			h 		= 0.65 * safezoneH;
			font 	= "puristaMedium";
			sizeEx 	= 0.02;
			size 	= 0.02;
			text 	= "";

			colorText[] 		= {0.8,0.8,0.8,0.8};
			colorBackground[] 	= {0,0,0,0};
		};
	};
};