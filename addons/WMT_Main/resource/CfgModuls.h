class ArgumentsBaseUnits;
class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class ModuleDescription
		{
			class AnyBrain;
		};
	};
//=======================================================================================
//									MAIN MODULE
//=======================================================================================
	class WMT_Main: Module_F
	{
		scope = 2; ]
		author = "Ezhuk";
		displayName = "Main";
		category = "Map tools";

		function = "WMT_fnc_initModuleMain";
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 0;
		class Arguments: ArgumentsBaseUnits
		{
			class MaxViewDistance 
			{
				displayName = "$STR_WMT_ViewDistance";
				description = "$STR_WMT_ViewDistance_Desc";
				typeName = "NUMBER";
				defaultValue = 2500;
			};
			class TI 
			{
				displayName = "$STR_WMT_TI";
				typeName = "NUMBER";
				class values
				{
					class Enable		{name = "$STR_WMT_TI_Enable"; value = 0; default = 1;};
					class DisableInVehs	{name = "$STR_WMT_TI_DisableInVehicle"; value = 1;};
					class Disable 		{name = "$STR_WMT_TI_Disable"; value = 2;};
				};
			};
			class NameTag{
				displayName = "$STR_WMT_NameTag";
				typeName = "BOOL";
				defaultValue = true;
			};
		};
	};
//=======================================================================================
//									TIME MODULE
//=======================================================================================
	class WMT_Time: Module_F
	{
		scope = 2;
		author = "HI,A3 Project";
		displayName = "Time";
		category = "Map tools";
		function = "WMT_fnc_initModuleTime";
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 0;
		class Arguments: ArgumentsBaseUnits
		{
			class MissionTime
  			{
				displayName = "$STR_MissionTime";
				typeName = "NUMBER"; 
				defaultValue = 60;
			};
			class WinnerByTime
  			{
				displayName = "$STR_WinnerSide";
				description = "$STR_WinnerSide_Desc";
				typeName = "NUMBER";
				class values
				{
					class Empty	{name = "$STR_Nobody"; value = 0; default = 1;};
					class West	{name = "$STR_West"; value = 1;};
					class East 	{name = "$STR_East"; value = 2;};
					class Guer 	{name = "$STR_Resistance"; value = 3;};
					class Civ 	{name = "$STR_Civilian"; value = 4;};
				};
			};
			class WinnerByTimeText 
			{
				displayName = "$STR_Message";
				description = "$STR_Message_Desc";
				typeName = "STRING";
				defaultValue = "End time";
			};
			class PrepareTime 
			{
				displayName = "$STR_PrepareTime";
				typeName = "NUMBER";
				defaultValue = 3;
			};
			class StartZone 
			{
				displayName = "$STR_StartZone";
				typeName = "NUMBER";
				defaultValue = 100;
			};
			class RemoveBots
			{
				displayName = "$STR_RemoveBots";
				typeName = "NUMBER";
				defaultValue = 1;
			};
			class RemoveSpotMarker
			{
				displayName = "$STR_RemoveMarkers";
				description = "$STR_RemoveMarkers_Desc";
				typeName = "NUMBER";
				defaultValue = 1;
			};
		};
	};
};