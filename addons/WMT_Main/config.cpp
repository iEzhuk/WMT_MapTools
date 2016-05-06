#include "resource\RscResourse.h"
#include "resource\CfgModuls.h"
#include "resource\CfgFunctions.h"
#include "resource\RscWMTMainMenu.h"
#include "resource\RscWMTOptions.h"
#include "resource\RscWMTAdminPanel.h"
#include "resource\RscWMTFeedback.h"
#include "resource\RscWMTChooseMarker.h"

class CfgPatches
{
    class WMT_Main
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {"A3_UI_F", "cba_keybinding"};
        author[] = {"Ezhuk","Zealot"};
        authorUrl = "https://github.com/iEzhuk/WMT_MapTools";
        version = 1.5.0;
        versionStr = "1.5.0";
        versionAr[] = {1,5,0};
    };
};

class CfgSounds
{
    sounds[] = {};
    class wmt_beep
    {
        name = "WMT Freeze end beep";
        sound[] = {"\wmt_main\sounds\buzz.ogg", 1db, 1};
        titles[]={};
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

class RscTitles {
    #include "resource\RscWMTDisableTI.h"
    #include "resource\RscWMTNameTag.h"
    #include "resource\RscWMTDogTag.h"
    #include "resource\RscWMTVehicleCrew.h"
};

class RscDisplayOptionsVideo
{
    onLoad = "['onLoad',_this,'RscDisplayOptionsVideo','GUI'] call  (uinamespace getvariable 'BIS_fnc_initDisplay'); ['disableOptions', _this] call WMT_fnc_HandlerOptions;";
};

// Fake map for wmt_fnc_briefingMap
class CfgWeapons
{
    class ItemMap;
    class ItemMapFake_WMT : ItemMap
    {
        displayName = "Fake map";
        descriptionShort = "Fake map";
    };
};
