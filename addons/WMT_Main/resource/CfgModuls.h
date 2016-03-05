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
//                                  MAIN MODULE
//=======================================================================================
    class WMT_Main: Module_F
    {
        scope = 2;
        author = "Ezhuk";
        displayName = "Main";
        category = "WMT";
        function = "WMT_fnc_initModuleMain";
        icon = "\WMT_main\pic\main.paa";
        functionPriority = 2;
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
            class MaxViewDistanceTerrain
            {
                displayName = "$STR_WMT_ViewDistanceTerrain";
                description = "$STR_WMT_ViewDistanceTerrain_Desc";
                typeName = "NUMBER";
                defaultValue = 10000;
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
                    class Enable        {name = "$STR_WMT_TI_Enable"; value = 0;};
                    class DisableInVehs {name = "$STR_WMT_TI_DisableInVehicle"; value = 1;};
                    class Disable       {name = "$STR_WMT_TI_Disable"; value = 2;};
                };
            };
            class ExtendedBriefing
            {
                displayName = "$STR_WMT_ExtendedBriefing";
                description = "$STR_WMT_ExtendedBriefingInfo";
                typeName = "NUMBER";
                class values
                {
                    class Enable    {name = "$STR_WMT_Enable"; value = 1;};
                    class Disable   {name = "$STR_WMT_Disable"; value = 0;};
                };
            };

            class NameTag
            {
                displayName = "$STR_WMT_NameTag";
                description = "";
                typeName = "NUMBER";
                class values
                {
                    class Enable    {name = "$STR_WMT_Enable"; value = 1;};
                    class Disable   {name = "$STR_WMT_Disable"; value = 0;};
                };
            };
            class IndetifyTheBody
            {
                displayName = "$STR_WMT_IndetifyTheBody";
                description = "";
                typeName = "NUMBER";
                class values
                {
                    class Enable    {name = "$STR_WMT_Enable"; value = 1;};
                    class Disable   {name = "$STR_WMT_Disable"; value = 0;};
                };
            };
            class GenerateFrequencies
            {
                displayName = "$STR_WMT_MOD_GENFREQS";
                description = "";
                typeName = "NUMBER";
                class values
                {
                    class Enable    {name = "$STR_WMT_Enable"; value = 1;};
                    class Disable   {name = "$STR_WMT_Disable"; value = 0;};
                };
            };
            class AI
            {
                displayName = "$STR_WMT_AI";
                description = "";
                typeName = "NUMBER";
                class values
                {
                    class Disable   {name = "$STR_WMT_Disable"; value = 0;};
                    class Enable    {name = "$STR_WMT_Enable"; value = 1;};
                };
            };
            class Statistic
            {
                displayName = "$STR_WMT_Statistic";
                description = "$STR_WMT_Statistic_Desc";
                typeName = "NUMBER";
                class values
                {
                    class Enable    {name = "$STR_WMT_Enable"; value = 1;};
                    class Disable   {name = "$STR_WMT_Disable"; value = 0;};
                };
            };
        };
    };
//=======================================================================================
//                                  TIME MODULE
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
                    class Empty {name = "$STR_WMT_Nobody"; value = 4;};
                    class East  {name = "$STR_WMT_East"; value = 0;};
                    class West  {name = "$STR_WMT_West"; value = 1;};
                    class Guer  {name = "$STR_WMT_Resistance"; value = 2;};
                    class Civ   {name = "$STR_WMT_Civilian"; value = 3;};
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
                defaultValue = 5;
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
                defaultValue = 3;
            };
        };
    };
    //=======================================================================================
    //                                  Start Position
    //=======================================================================================
    class WMT_StartPosition: Module_F
    {
        scope = 2;
        author = "Ezhuk";
        displayName = "Start Position";
        category = "WMT";
        function = "WMT_fnc_InitModuleStartPosition";
        icon = "\WMT_main\pic\startPos.paa";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        class Arguments: ArgumentsBaseUnits
        {
            class Text
            {
                displayName = "$STR_WMT_Text";
                description = "$STR_WMT_SP_Text_Desc";
                typeName = "STRING";
                defaultValue = "";
            };
            class Owner
            {
                displayName = "$STR_WMT_SP_Owner";
                description = "$STR_WMT_SP_Owner_Desc";
                typeName = "STRING";
                defaultValue = "";
            };
            class CenterObject
            {
                displayName = "$STR_WMT_SP_Center";
                description = "$STR_WMT_SP_Center_Desc";
                typeName = "STRING";
                defaultValue = "";
            };
            class Positions
            {
                displayName = "$STR_WMT_SP_Positions";
                description = "";
                typeName = "STRING";
                defaultValue = "";
            };
            class MarkerSide
            {
                displayName = "$STR_WMT_SP_ShowMarkers";
                description = "";
                typeName = "NUMBER";
                class values
                {
                    class All  {name = "$STR_WMT_All"; value = 0;};
                    class East {name = "$STR_WMT_East"; value = 1;};
                    class West {name = "$STR_WMT_West"; value = 2;};
                    class Guer {name = "$STR_WMT_Resistance"; value = 3;};
                    class Civ  {name = "$STR_WMT_Civilian"; value = 4;};
                };
            };
            class Time
            {
                displayName = "$STR_WMT_SP_Time";
                description = "$STR_WMT_SP_Time_Desc";
                typeName = "NUMBER";
                defaultValue = 3;
            };
        };
    };

    // Change priority to default module for create diary
    class ModuleCreateDiaryRecord_F : Module_F
    {
        functionPriority = 5;
    };
};
