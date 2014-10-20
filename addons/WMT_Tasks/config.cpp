#include "resource\CfgModuls.h"
#include "resource\CfgFunctions.h"

class CfgPatches 
{
	class WMT_Tasks
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"WMT_Main"};
		author[] = {"Ezhuk","Zealot"};
		authorUrl = "https://github.com/iEzhuk/WOG3_MapTools";
		version = 1.2.4;
		versionStr = "1.2.4";
		versionAr[] = {1,2,4};	
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
