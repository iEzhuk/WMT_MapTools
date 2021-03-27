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

private _killerAce = player getVariable ["ace_medical_lastDamageSource", objNull];

if (!isNull _killerAce) then {
    WMT_Local_Killer_Ace = _killerAce getVariable ["PlayerName", localize "STR_WMT_Unknow"];
} else {
	WMT_Local_Killer_Ace = "";
};

