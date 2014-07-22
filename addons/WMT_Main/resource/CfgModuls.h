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
		scope = 2;
		author = "Ezhuk";
		displayName = "Main";
		category = "WMT";
		function = "WMT_fnc_initModuleMain";
		icon = "\WMT_main\pic\main.paa";
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
			class HeavyLossesCoeff
			{
				displayName = "$STR_WMT_HeavyLossesCoeff";
				description = "";
				typeName = "NUMBER";
				defaultValue = 0.1;
			};
			class TI 
			{
				displayName = "$STR_WMT_TI";
				description = "";
				typeName = "NUMBER";
				class values
				{
					class Enable		{name = "$STR_WMT_TI_Enable"; value = 0; default = 1;};
					class DisableInVehs	{name = "$STR_WMT_TI_DisableInVehicle"; value = 1;};
					class Disable 		{name = "$STR_WMT_TI_Disable"; value = 2;};
				};
			};
			class NameTag
			{
				displayName = "$STR_WMT_NameTag";
				description = "";
				typeName = "NUMBER";
				class values
				{
					class Disable 	{name = "$STR_WMT_Disable"; value = 0;};
					class Enable	{name = "$STR_WMT_Enable"; value = 1; default = 1;};
				};
			};
			class ShowSquadsBriefing
			{
				displayName = "$STR_WMT_ShowSquadsBriefingShort";
				description = "$STR_WMT_ShowSquadsBriefing";
				typeName = "NUMBER";
				class values
				{
					class Disable 	{name = "$STR_WMT_Disable"; value = 0; };
					class Enable	{name = "$STR_WMT_Enable"; value = 1; default = 1;};
				};
			};
			class ShowVehiclesBriefing
			{
				displayName = "$STR_WMT_ShowVehsBriefingShort";
				description = "$STR_WMT_ShowVehsBriefing";
				typeName = "NUMBER";
				class values
				{
					class Disable 	{name = "$STR_WMT_Disable"; value = 0; };
					class Enable	{name = "$STR_WMT_Enable"; value = 1; default = 1;};
				};
			};
			class ShowEnemyVehiclesInNotes
			{
				displayName = "$STR_WMT_ShowEnemyVehsNotes";
				description = "$STR_WMT_ShowEnemyVehsNotes_Desc";
				typeName = "NUMBER";
				class values
				{
					class Disable 	{name = "$STR_WMT_Disable"; value = 0; };
					class Enable	{name = "$STR_WMT_Enable"; value = 1; default = 1;};
				};
			};
			class GenerateFrequencies
			{
				displayName = "$STR_WMT_MOD_GENFREQS";
				description = "";
				typeName = "NUMBER";
				class values
				{
					class Disable 	{name = "$STR_WMT_Disable"; value = 0; };
					class Enable	{name = "$STR_WMT_Enable"; value = 1; default = 1;};
				};
			};	
			class AI
			{
				displayName = "$STR_WMT_AI";
				description = "";
				typeName = "NUMBER";
				class values
				{
					class Disable 	{name = "$STR_WMT_Disable"; value = 0; default = 1;};
					class Enable 	{name = "$STR_WMT_Enable"; value = 1;};
				};
			};	
			class Statistic
			{
				displayName = "$STR_WMT_Statistic";
				description = "$STR_WMT_Statistic_Desc";
				typeName = "NUMBER";
				class values
				{
					class Disable 	{name = "$STR_WMT_Disable"; value = 0; };
					class Enable	{name = "$STR_WMT_Enable"; value = 1;default = 1;};
				};
			};
		};
	};
//=======================================================================================
//									TIME MODULE
//=======================================================================================
	class WMT_Time: Module_F
	{
		scope = 2;
		author = "Ezhuk";
		displayName = "Time";
		category = "WMT";
		function = "WMT_fnc_initModuleTime";
		icon = "\WMT_main\pic\time.paa";
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 0;
		class Arguments: ArgumentsBaseUnits
		{
			class MissionTime
  			{
				displayName = "$STR_WMT_MissionTime";
				typeName = "NUMBER"; 
				defaultValue = 60;
			};
			class WinnerByTime
  			{
				displayName = "$STR_WMT_WinnerSide";
				description = "$STR_WMT_WinnerSide_Desc";
				typeName = "NUMBER";
				class values
				{
					class Empty	{name = "$STR_WMT_Nobody"; value = 4; default = 4;};
					class East 	{name = "$STR_WMT_East"; value = 0;};
					class West	{name = "$STR_WMT_West"; value = 1;};
					class Guer 	{name = "$STR_WMT_Resistance"; value = 2;};
					class Civ 	{name = "$STR_WMT_Civilian"; value = 3;};
				};
			};
			class WinnerByTimeText 
			{
				displayName = "$STR_WMT_Message";
				description = "$STR_WMT_Message_Desc";
				typeName = "STRING";
				defaultValue = "End time";
			};
			class PrepareTime 
			{
				displayName = "$STR_WMT_PrepareTime";
				description = "";
				typeName = "NUMBER";
				defaultValue = 3;
			};
			class StartZone 
			{
				displayName = "$STR_WMT_StartZone";
				description = "";
				typeName = "NUMBER";
				defaultValue = 100;
			};
			class RemoveBots
			{
				displayName = "$STR_WMT_RemoveBots";
				description = "";
				typeName = "NUMBER";
				defaultValue = 0;
			};
		};
	};
};