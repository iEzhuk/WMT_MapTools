/*
    Name: WMT_fnc_DisableAI

    Author(s):
        Ezhuk

    Description:
        Disable AI for all units

    Parameters:
        Nothing
    
    Returns:
        Nothing
*/

params ["_unit"];

_unit disableAI "AUTOTARGET";
_unit disableAI "TARGET";
_unit disableAI "FSM";
_unit disableAI "MOVE";
_unit disableAI "PATHPLAN";
_unit stop true;
_unit setBehaviour "CARELESS";
_unit allowFleeing 0;
_unit disableConversation true;
_unit setVariable ["BIS_noCoreConversations", false];
_unit setSpeaker "NoVoice";

