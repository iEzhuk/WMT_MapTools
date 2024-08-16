/*
    Name: WMT_fnc_PlayerKilled

    Author(s):
        Ezhuk

    Description:
        Callback for event "killed"

    Parameters:
        Nothing

    Returns:
        Nothing
*/


if(wmt_param_Statistic==0)exitWith{};

closeDialog 0;

params ["_unit", "_killer", "_instigator", "_useEffects"];

_killer = _instigator;

private ["_killerName","_killerSide"];

_killerName = _killer getVariable ["PlayerName", localize "STR_WMT_Unknow"];
_killerSide = _killer getVariable ["PlayerSide", sideLogic];

WMT_Local_Killer = [_killerName, _killerSide];

private _killerAce = player getVariable ["ace_medical_lastDamageSource", objNull];

if (!isNull _killerAce) then {
    WMT_Local_Killer_Ace = _killerAce getVariable ["PlayerName", localize "STR_WMT_Unknow"];
} else {
	WMT_Local_Killer_Ace = "";
}; 

[[WMT_Local_PlayerName,playerSide], {
    private _id = WMT_Local_Kills findIf {(_x select 0) isEqualTo (_this select 0)};
    if (_id isEqualTo -1) then {
        WMT_Local_Kills pushback (_this); 
    };
}] remoteExec ["call",_killer];
