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
//									DESTROY
//=======================================================================================
	class WMT_Task_Destroy: Module_F
	{
		scope = 2;
		author = "Ezhuk";
		displayName = "Destroy";
		category = "WMT";
		function = "WMT_fnc_InitModuleTaskDestroy";
		//icon = "";
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 0;
		class Arguments: ArgumentsBaseUnits
		{
			class EndCount
			{
				displayName  = "$STR_WMT_ObjectCount";
				description  = "$STR_WMT_ObjectCount_Desc";
				typeName 	 = "NUMBER";
				defaultValue = 0;
			};
			class Winner
			{
				displayName = "$STR_WMT_WinnerSide";
				description = "$STR_WMT_WinnerSide_Desc";
				typeName 	= "NUMBER";
				class values
				{
					class Empty	{name = "$STR_WMT_Nobody"; 		value = 4; default = 1;};
					class East 	{name = "$STR_WMT_East"; 		value = 0;};
					class West	{name = "$STR_WMT_West"; 		value = 1;};
					class Guer 	{name = "$STR_WMT_Resistance"; 	value = 2;};
					class Civ 	{name = "$STR_WMT_Civilian"; 	value = 3;};
				};
			};
			class Message
			{
				displayName  = "$STR_WMT_Message";
				description  = "$STR_WMT_Message_Desc";
				typeName 	 = "STRING";
				defaultValue = "";
			};
			class Notice
			{
				displayName = "$STR_WMT_Notice";
				description = "$STR_WMT_Notice_Desc";
				typeName 	= "NUMBER";
				class values
				{
					class Enable 	{name = "$STR_WMT_Enable";  value = 1; default = 1;};
					class Disable 	{name = "$STR_WMT_Disable"; value = 0;};
				};
			};
			class Delay
			{
				displayName  = "$STR_WMT_Delay";
				description  = "$STR_WMT_Delay_Desc";
				typeName 	 = "NUMBER";
				defaultValue = 60;
			};
		};
	};
//=======================================================================================
//									Arrive
//=======================================================================================
	class WMT_Task_Arrive: Module_F
	{
		scope = 2;
		author = "Ezhuk";
		displayName = "Arrived";
		category = "WMT";
		function = "WMT_fnc_initModuleTaskArrived";
		//icon = "";
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 0;
		class Arguments: ArgumentsBaseUnits
		{
			class Marker
			{
				displayName  = "EndCount";
				description  = "";
				typeName 	 = "STRING";
				defaultValue = "";
			};
			class Winner
			{
				displayName = "Winner";
				description = "";
				typeName 	= "NUMBER";
				class values
				{
					class Empty	{name = "$STR_WMT_Nobody"; 		value = 4; default = 1;};
					class East 	{name = "$STR_WMT_East"; 		value = 0;};
					class West	{name = "$STR_WMT_West"; 		value = 1;};
					class Guer 	{name = "$STR_WMT_Resistance"; 	value = 2;};
					class Civ 	{name = "$STR_WMT_Civilian"; 	value = 3;};
				};
			};
			class Message
			{
				displayName  = "Message";
				description  = "";
				typeName 	 = "STRING";
				defaultValue = "";
			};
			class Count
			{
				displayName  = "EndCount";
				description  = "";
				typeName 	 = "NUMBER";
				defaultValue = 0;
			};
			class Delay
			{
				displayName  = "Delay";
				description  = "";
				typeName 	 = "NUMBER";
				defaultValue = 0;
			};
		};
	};
//=======================================================================================
//									POINT
//=======================================================================================
	class WMT_Task_Point: Module_F
	{
		scope = 2;
		author = "Ezhuk";
		displayName = "Point";
		category = "WMT";
		function = "WMT_fnc_InitModuleTaskPoint";
		//icon = "";
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 0;
		class Arguments: ArgumentsBaseUnits
		{
			class Marker
			{
				displayName  = "Marker";
				description  = "";
				typeName 	 = "STRING";
				defaultValue = "";
			};
			class Owner
			{
				displayName = "Owner";
				description = "";
				typeName 	= "NUMBER";
				class values
				{
					class Empty	{name = "$STR_WMT_Nobody"; 		value = 4; default = 1;};
					class East 	{name = "$STR_WMT_East"; 		value = 0;};
					class West	{name = "$STR_WMT_West"; 		value = 1;};
					class Guer 	{name = "$STR_WMT_Resistance"; 	value = 2;};
					class Civ 	{name = "$STR_WMT_Civilian"; 	value = 3;};
				};
			};
			class Message
			{
				displayName  = "Message";
				description  = "";
				typeName 	 = "STRING";
				defaultValue = "";
			};
			class DefCount
			{
				displayName  = "DefCount";
				description  = "";
				typeName 	 = "NUMBER";
				defaultValue = 0;
			};
			class CaptureCount
			{
				displayName  = "CaptureCount";
				description  = "";
				typeName 	 = "NUMBER";
				defaultValue = 0;
			};
			class Lock
			{
				displayName = "Lock";
				description = "";
				typeName 	= "NUMBER";
				class values
				{
					class Disable 	{name = "$STR_WMT_Disable"; value = 0;};
					class Enable	{name = "$STR_WMT_Enable";  value = 1; default = 1;};
				};
			};
			class EasyCapture
			{
				displayName = "EasyCapture";
				description = "";
				typeName 	= "NUMBER";
				class values
				{
					class Disable 	{name = "$STR_WMT_Disable"; value = 0;};
					class Enable	{name = "$STR_WMT_Enable";  value = 1; default = 1;};
				};
			};
			class MinHeight
			{
				displayName  = "MinHeight";
				description  = "";
				typeName 	 = "NUMBER";
				defaultValue = -5;
			};
			class MaxHeight
			{
				displayName  = "MinHeight";
				description  = "";
				typeName 	 = "NUMBER";
				defaultValue = 30;
			};
			class AutoLose
			{
				displayName = "AutoLose";
				description = "";
				typeName 	= "NUMBER";
				class values
				{
					class No 	{name = "$STR_WMT_Disable";		value = -1; default = 1;};
					class Empty	{name = "$STR_WMT_Nobody"; 		value = 4;};
					class East 	{name = "$STR_WMT_East"; 		value = 0;};
					class West	{name = "$STR_WMT_West"; 		value = 1;};
					class Guer 	{name = "$STR_WMT_Resistance"; 	value = 2;};
					class Civ 	{name = "$STR_WMT_Civilian"; 	value = 3;};
				};
			};
			class Delay
			{
				displayName  = "Delay";
				description  = "";
				typeName 	 = "NUMBER";
				defaultValue = 60;
			};
		};
	};
};