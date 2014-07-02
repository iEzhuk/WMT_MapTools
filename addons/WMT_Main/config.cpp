#include "resource\RscResourse.h"
#include "resource\CfgModuls.h"
#include "resource\CfgFunctions.h"
#include "resource\RscMainMenu.h"
#include "resource\RscOptions.h"
#include "resource\RscAdminPanel.h"
#include "resource\RscFeedback.h"


class CfgPatches 
{
	class WMT_Main
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {};
		author[] = {"Ezhuk","Zealot"};
		authorUrl = "http://www.hia3.com";
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
	#include "resource\RscDisableTI.h"
	#include "resource\RscNameTag.h"
};