/*
    Name: WMT_fnc_InitModuleTime

    Author(s):
        Ezhuk

    Description:
        Initialize time module
*/
private _logic = [_this,0,objNull,[objNull]] call BIS_fnc_param;
private _units = [_this,1,[],[[]]] call BIS_fnc_param;
private _activated = [_this,2,true,[true]] call BIS_fnc_param;

if(_activated) then {
    if ( not isnil "wmt_Time_ModuleRunning" ) exitWith {};
    wmt_Time_ModuleRunning = true;
    // mission time
    if(isNil "wmt_param_MissionTime") then {
        wmt_param_MissionTime = _logic getVariable "MissionTime";
    };
    // winner by end of time
    if(isNil "wmt_param_WinnerByTime") then {
        wmt_param_WinnerByTime = [east,west,resistance,civilian,sideLogic] select (_logic getVariable "WinnerByTime");
    };
    // message
    if(isNil "wmt_param_WinnerByTimeText") then {
        wmt_param_WinnerByTimeText = _logic getVariable "WinnerByTimeText";
    };
    // prepare time
    if(isNil "wmt_param_PrepareTime") then {
        wmt_param_PrepareTime = _logic getVariable "PrepareTime";
    };
    // prepare time
    if(isNil "wmt_param_StartZone") then {
        wmt_param_StartZone = _logic getVariable "StartZone";
    };
    // time to remove bots
    if(isNil "wmt_param_RemoveBots") then {
        wmt_param_RemoveBots = _logic getVariable "RemoveBots";
    };

    wmt_param_MissionTime = 0 max wmt_param_MissionTime;
    wmt_param_PrepareTime = 0 max wmt_param_PrepareTime;
    wmt_param_StartZone = 20 max wmt_param_StartZone;
    wmt_param_RemoveBots = 0 max wmt_param_RemoveBots;
    //================================================
    //                  SERVER
    //================================================
    if(isServer) then {
        [] spawn {
            [wmt_param_PrepareTime] call WMT_fnc_PrepareTime_server;
            if(wmt_param_MissionTime>0) then {
                [wmt_param_MissionTime,wmt_param_WinnerByTime,wmt_param_WinnerByTimeText] spawn WMT_fnc_EndMissionByTime;
            };
            if (wmt_param_RemoveBots > 0 && wmt_param_PrepareTime == 0) then {
                ["itemAdd", ["wmtrmvbots", { [] call wmt_fnc_removeBots; }, nil, nil, {time > (wmt_param_RemoveBots*60)}, {false}, true]] call BIS_fnc_loop;
            };
        };
    };

    //================================================
    //                  CLIENT
    //================================================
    if(!isDedicated) then {
        "WMT_Global_LeftTime" addPublicVariableEventHandler {WMT_Local_LeftTime=[diag_tickTime, ((_this select 1) select 0),true]; };

        if(isNil "WMT_Local_LeftTime") then {
            WMT_Local_LeftTime=[diag_tickTime, wmt_param_MissionTime*60,false];
        };

        [] spawn {
            waitUntil{!isNil {player}};
            [wmt_param_PrepareTime,wmt_param_StartZone] spawn WMT_fnc_PrepareTime_client;
        };
    };
};
