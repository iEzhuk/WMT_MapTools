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
	icon = "\WMT_Vehicle\pic\vehicle.paa";
	functionPriority = 1;
	isGlobal = 1;
	isTriggerActivated = 0;
	class Arguments: ArgumentsBaseUnits
	{
		class FullRepair
		{
			displayName = "$STR_WMT_ModuleFullRepair";
			description = "";
			typeName 	= "NUMBER";
			class values
			{
				class Enable 	{name = "$STR_WMT_Enable";  value = 0; default = 0;};
				class Disable 	{name = "$STR_WMT_Disable"; value = 1;};
			};
		};
		class VehicleCrew
		{
			displayName = "$STR_WMT_ModuleVehicleCrew";
			description = "";
			typeName 	= "NUMBER";
			class values
			{
				class Enable	{name = "$STR_WMT_Enable";  value = 0; default = 0;};
				class Disable 	{name = "$STR_WMT_Disable"; value = 1;};
			};
		};
		class LowGear
		{
			displayName = "$STR_WMT_ModuleLowGear";
			description = "";
			typeName 	= "NUMBER";
			class values
			{
				class Enable	{name = "$STR_WMT_Enable";  value = 0; default = 0;};
				class Disable 	{name = "$STR_WMT_Disable"; value = 1;};
			};
		};
		class PushBoat
		{
			displayName = "$STR_WMT_ModulePushBoat";
			description = "";
			typeName 	= "NUMBER";
			class values
			{
				class Enable	{name = "$STR_WMT_Enable";  value = 0; default = 0;};
				class Disable 	{name = "$STR_WMT_Disable"; value = 1;};
			};
		};
		class Reammo
		{
			displayName = "$STR_WMT_ModuleReammo";
			description = "";
			typeName 	= "NUMBER";
			class values
			{
				class Enable	{name = "$STR_WMT_Enable";  value = 0; default = 0;};
				class Disable 	{name = "$STR_WMT_Disable"; value = 1;};
			};
		};		
		class StaticWeaponDrag
		{
			displayName = "$STR_WMT_ModuleStaticWeaponDrag";
			description = "";
			typeName 	= "NUMBER";
			class values
			{
				class Enable	{name = "$STR_WMT_Enable";  value = 0; default = 0;};
				class Disable 	{name = "$STR_WMT_Disable"; value = 1;};
			};
		};														
	};
};
