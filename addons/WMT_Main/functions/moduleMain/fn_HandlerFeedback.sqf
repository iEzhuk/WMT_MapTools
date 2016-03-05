/*
    Name: WMT_fnc_HandlerFeedback

    Author(s):
        Ezhuk

    Description:
        Handler function for feedback menu

    Parameters:
        0 - STR: type of event
        1 - ARRAY: argument from event

    Returns:
        BOOL: for standart handlers
*/
#include "defines_IDC.sqf"

private _event = _this select 0;
private _arg = _this select 1;
private _return = false;

switch (_event) do
{
    case "init": {
        private _dialog = _arg select 0;
        uiNamespace setVariable ["WMT_Dialog_Menu", _dialog];

        private _admin = localize "STR_WMT_NoAdmin";

        if not isNil "WMT_Global_Admin" then {
            if(isPlayer (WMT_Global_Admin select 0)) then {
                _admin = WMT_Global_Admin select 1;
            };
        };

        (_dialog displayCtrl IDC_FEEDBACK_TEXT) ctrlSetText "";
        (_dialog displayCtrl IDC_FEEDBACK_ADMINNAME) ctrlSetText _admin;
    };
    case "close": {
        uiNamespace setVariable ["WMT_Dialog_Menu", nil];
    };
    case "send": {
        // Send message to admin
        if (isNil "WMT_Global_Admin") exitWith {
            hint localize "STR_WMT_NoAdmin";
        };
        if (not isPlayer (WMT_Global_Admin select 0)) exitWith {
            hint localize "STR_WMT_NoAdmin";
        };

        private _dialog = uiNamespace getVariable "WMT_Dialog_Menu";
        private _text = ctrlText (_dialog displayCtrl IDC_FEEDBACK_TEXT);

        if(_text != "") then {
            WMT_Global_ToAdmin = format ["%1: %2", WMT_Local_PlayerName, _text];

            publicVariable "WMT_Global_ToAdmin";

            closeDialog 0;
        }else{
            hint localize "STR_WMT_EmptyTextField";
        };

        closeDialog 0;
    };
    case "loop": {
        // Update information about admin
        while{true} do {
            if(serverCommandAvailable("#kick")) then {
                if( isNil "WMT_Global_Admin" ) then {
                    WMT_Global_Admin = [player, WMT_Local_PlayerName];
                    publicVariable "WMT_Global_Admin";
                } else {
                    if((WMT_Global_Admin select 0)!= player) then {
                        WMT_Global_Admin = [player, WMT_Local_PlayerName];
                        publicVariable "WMT_Global_Admin";
                    };
                };
            };
            // Disable chat
            if (isnil "wmt_flg_dontDisableChat" and (missionNamespace getVariable ["WMT_pub_frzState",3]) >= 3) then {
                showChat false;
            };
            sleep 30;
        };
    };
};
_return
