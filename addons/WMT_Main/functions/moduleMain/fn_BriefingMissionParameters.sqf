/*
    Name: WMT_fnc_BriefingMissionParameters

    Author(s):
        Ezhuk

    Description:
        Add list of squads and players to briefing

    Parameters:
        Nothing
    Returns:
        Nothing
*/

private _text = "";
//start redesigned by MODUL
if(!isNil "wmt_param_MaxViewDistance") then {
    _text = _text + "<font size='14'>" + format ["%1: <font color='#f0c059'>%2</font><br/>",
                    localize "STR_WMT_ViewDistance", wmt_param_MaxViewDistance];
};

if(!isNil "wmt_param_TI") then {
    switch wmt_param_TI do {
        case 0 : {
            _text = _text + format ["%1: <font color='#a8ef2b'>%2</font><br/>",
                            localize "STR_WMT_TI", localize "STR_WMT_Enable"];
        };
        case 1 : {
            _text = _text + format ["%1: <font color='#f0c059'>%2</font><br/>",
                            localize "STR_WMT_TI", localize "STR_WMT_TI_DisableInVehicle"];
        };
        case 2 : {
            _text = _text + format ["%1: <font color='#ed2616'>%2</font><br/>",
                            localize "STR_WMT_TI", localize "STR_WMT_Disable"];
        };
    };
};

_text = _text + format ["%1: <font color='#f0c059'>%2</font><br/>",
                    localize "STR_WMT_MissionStart", [dayTime,"HH:MM"] call bis_fnc_TimeToString];

_text = _text + format ["%1: <font color='#f0c059'>%2</font><br/>",
                    localize "STR_MDL_MissWillEndIn", [(wmt_param_MissionTime/60)+dayTime,"HH:MM"] call bis_fnc_TimeToString];

if(!isNil "wmt_param_MissionTime") then {
    _text = _text + format ["%1: <font color='#f0c059'>%2</font><br/>",
                    localize "STR_WMT_MissionDuration", [wmt_param_MissionTime*60,"HH:MM"] call BIS_fnc_secondsToString];
};

if(!isNil "wmt_param_PrepareTime") then {
    _text = _text + format ["%1: <font color='#f0c059'>%2</font><br/>",
                    localize "STR_WMT_PrepareTime_param", [wmt_param_PrepareTime*60,"HH:MM"] call BIS_fnc_secondsToString];
};
_text = _text + format ["<font color='#202020' size='10'>%1</font>",localize "STR_MDL_ReDesigned"];
//end
["diary",localize "STR_WMT_MissionParameters", _text] call WMT_fnc_CreateDiaryRecord;
