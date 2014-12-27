#include "resource\RscResourse.h"
#include "resource\CfgModuls.h"
#include "resource\CfgFunctions.h"
#include "resource\RscWMTMainMenu.h"
#include "resource\RscWMTOptions.h"
#include "resource\RscWMTAdminPanel.h"
#include "resource\RscWMTFeedback.h"
#include "resource\RscWMTChooseMarker.h"

class CfgPatches 
{
	class WMT_Main
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {};
		author[] = {"Ezhuk","Zealot"};
		authorUrl = "https://github.com/iEzhuk/WMT_MapTools";
		version = 1.4.1;
		versionStr = "1.4.1";
		versionAr[] = {1,4,1};
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
	#include "resource\RscWMTDogTag.h"
};