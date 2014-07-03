class CfgPatches 
{
	class wog_mt_vehicle 
	{
		units[] = {};
		weapons[] = {};
		requiredAddons[] = {};
		author[]= {"Zealot"}; 		
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
			file="wog_mt_freeze\functions";		
			class VehicleInit
			{
				postInit = 1;
			};
			class RepairInit{};
			class fieldrepair{};
			class CheckKindOfArray{};
			class VehicleIsDamaged{};
			class NotifyText{};
			class StaticWpnInit{};
			class PushBoatInit{};
			class ShowVehicleCrew{};
			class LowGearInit{};
			class RearmVehicle{};
			class InitRearmSystem{};
			
		};
	};
};




