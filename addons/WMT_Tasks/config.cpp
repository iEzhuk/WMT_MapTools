#include "resource\CfgModuls.h"
#include "resource\CfgFunctions.h"

class CfgPatches 
{
	class WMT_Main
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"WMT_Main"};
		author[] = {"Ezhuk","Zealot"};
		authorUrl = "https://github.com/iEzhuk/WOG3_MapTools";
		version = 1.2.3;
		versionStr = "1.2.3";
		versionAr[] = {1,2,3};	
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
