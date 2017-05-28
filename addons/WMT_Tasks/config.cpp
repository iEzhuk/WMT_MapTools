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
		author = "Ezhuk, Zealot";
		authorUrl = "https://github.com/iEzhuk/WMT_MapTools";
		version = 1.5.0;
		versionStr = "1.5.0";
		versionAr[] = {1,5,0};
	};
};

class CfgFactionClasses
{
	class WMT
	{
		displayName = "WMT";
		priority = 0;
		side = 7;
	};
};
