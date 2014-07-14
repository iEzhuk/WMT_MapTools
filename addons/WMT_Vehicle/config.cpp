class CfgPatches 
{
	class wog_mt_vehicle 
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Characters_F_BLUFOR","A3_Characters_F_OPFOR","A3_Characters_F_Gamma","A3_Characters_F_INDEP","A3_Characters_F_Civil"};
		authorUrl = "https://github.com/iEzhuk/WOG3_MapTools";
		author[]= {"Zealot, Ezhuk"}; 		
		version = 1.0.0;
		versionStr = "1.0.0";
		versionAr[] = {1,0,0};

	};
};

class CfgFunctions
{
	class WMT
	{
		class Vehicle
		{
			file="WMT_Vehicle\functions";		
			class CheckKindOfArray{};
			class FieldRepairVehicle{};
			class FullRepair{};
			class InitModuleVehicle{};
			class KeyHandlerShowCrew{};
			class LowGearCond{};
			class LowGear{};
			class NotifyText{};
			class PartRepair{};
			class PushBoat{};
			class ReammoCond{};
			class ReammoGetNearest{};
			class Reammo{};
			class RearmVehicle{};
			class ShowCrew{};
			class StaticWpnDrag{};
			class VehicleIsDamaged{};
	
		};
	};
};




class RscTitles 
{
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
				x 		= 0.86 * safezoneW + safezoneX;
				y 		= 0.25 * safezoneH + safezoneY;
				w 		= 0.13 * safezoneW;
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

};

class ArgumentsBaseUnits;
class CfgVehicles
{
	class B_Soldier_base_F;
	class B_engineer_F : B_Soldier_base_F
	{
		engineer = 0;
	};
	class B_Story_Engineer_F : B_Soldier_base_F
	{
		engineer = 0;
	};
	class B_CTRG_soldier_engineer_exp_F : B_Soldier_base_F
	{
		engineer = 0;
	};
	class B_soldier_repair_F : B_Soldier_base_F
	{
		engineer=0;
	};

	class O_Soldier_base_F;
	class O_Soldier_Urban_base;
	class O_engineer_U_F : O_Soldier_base_F 
	{
		engineer = 0;
	};
	class O_engineer_F: O_Soldier_base_F
	{
		engineer = 0;
	};

	class O_soldier_repair_F : O_Soldier_base_F 
	{
		engineer = 0;
	};
	class O_soldierU_repair_F  : O_Soldier_Urban_base  
	{
		engineer=0;		
	};

	class I_Soldier_base_F;
	class I_engineer_F : I_Soldier_base_F
	{
		engineer=0;
	};
	class I_soldier_repair_F : I_Soldier_base_F
	{
		engineer=0;
	};

	class I_G_Soldier_base_F;
	class I_G_engineer_F : I_G_Soldier_base_F
	{
		engineer=0;
	};
	class B_G_engineer_F : I_G_engineer_F
	{
		engineer = 0;
	};
	class O_G_engineer_F   : I_G_engineer_F
	{
		engineer=0;
	};
// ============================================== MODULE ============================================
	class Logic;
	class Module_F: Logic
	{
		class ModuleDescription
		{
			class AnyBrain;
		};
	};

	class WMT_Vehicle: Module_F
	{
		scope = 2;
		author = "Zealot";
		displayName = "Vehicle";
		category = "WMT";
		function = "WMT_fnc_initModuleVehicle";
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 0;
		class Arguments: ArgumentsBaseUnits
		{
			class FullRepair
			{
				displayName = "$STR_WMT_ModuleFullRepair";
				description = "";
				typeName = "NUMBER";
				class values
				{
					class Enable		{name = "$STR_WMT_Enable"; value = 0; default = 0;};
					class Disable 		{name = "$STR_WMT_Disable"; value = 1;};
				};
			};
			class VehicleCrew
			{
				displayName = "$STR_WMT_ModuleVehicleCrew";
				description = "";
				typeName = "NUMBER";
				class values
				{
					class Enable		{name = "$STR_WMT_Enable"; value = 0; default = 0;};
					class Disable 		{name = "$STR_WMT_Disable"; value = 1;};
				};
			};
			class LowGear
			{
				displayName = "$STR_WMT_ModuleLowGear";
				description = "";
				typeName = "NUMBER";
				class values
				{
					class Enable		{name = "$STR_WMT_Enable"; value = 0; default = 0;};
					class Disable 		{name = "$STR_WMT_Disable"; value = 1;};
				};
			};
			class PushBoat
			{
				displayName = "$STR_WMT_ModulePushBoat";
				description = "";
				typeName = "NUMBER";
				class values
				{
					class Enable		{name = "$STR_WMT_Enable"; value = 0; default = 0;};
					class Disable 		{name = "$STR_WMT_Disable"; value = 1;};
				};
			};
			class Reammo
			{
				displayName = "$STR_WMT_ModuleReammo";
				description = "";
				typeName = "NUMBER";
				class values
				{
					class Enable		{name = "$STR_WMT_Enable"; value = 0; default = 0;};
					class Disable 		{name = "$STR_WMT_Disable"; value = 1;};
				};
			};															
		};
	};
};

