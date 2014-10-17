#include "resource\CfgVehicles.h"
#include "resource\CfgFunctions.h"

class CfgPatches 
{
	class WMT_Vehicle 
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Characters_F_BLUFOR","A3_Characters_F_OPFOR","A3_Characters_F_Gamma","A3_Characters_F_INDEP","A3_Characters_F_Civil"};
		authorUrl = "https://github.com/iEzhuk/WOG3_MapTools";
		author[]= {"Zealot, Ezhuk"}; 		
		version = 1.2.3;
		versionStr = "1.2.3";
		versionAr[] = {1,2,3};

	};
};

class RscTitles 
{
	#include "resource\RscWMTProgressBar.h"
	#include "resource\RscWMTVehicleCrew.h"
};



