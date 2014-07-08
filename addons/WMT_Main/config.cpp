#include "resource\RscResourse.h"
#include "resource\CfgModuls.h"
#include "resource\CfgFunctions.h"
#include "resource\RscWMTMainMenu.h"
#include "resource\RscWMTOptions.h"
#include "resource\RscWMTAdminPanel.h"
#include "resource\RscWMTFeedback.h"


class CfgPatches 
{
	class WMT_Main
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {};
		author[] = {"Ezhuk","Zealot"};
		authorUrl = "https://github.com/iEzhuk/WOG3_MapTools";
		version = 0.1.0;
		versionStr = "0.1.0";
		versionAr[] = {0,1,0};	
	};
};

class CfgFactionClasses
{
	class WMT
	{
		displayName = "WMT";
		priority = 13;
		side = 7;
	};
};

class RscTitles {
	#include "resource\RscWMTDisableTI.h"
	#include "resource\RscWMTNameTag.h"
};