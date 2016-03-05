/*
    Name: WMT_fnc_EndMissionByTime

    Author(s):
        Ezhuk

    Description:
        End mission by time

    Parameters:
        0 - time
        1 - winner side
        2 - message

    Returns:
        Nothing
*/
private _time = _this select 0;
private _winSide = _this select 1;
private _message = _this select 2;

sleep 1;

if (not isNil "WMT_pub_frzState") then {
    waitUntil {sleep 0.67; WMT_pub_frzState >= 3};
};

private ["_startTime", "_leftTime"];
_startTime = diag_tickTime;

while {diag_tickTime-_startTime<(wmt_param_MissionTime*60)} do {
    _leftTime = ceil(((wmt_param_MissionTime*60)-(diag_tickTime-_startTime)));

    WMT_Global_LeftTime = [_leftTime];
    publicVariable "WMT_Global_LeftTime";

    WMT_Local_LeftTime = [diag_tickTime, _leftTime, true];

    sleep 30;
};

if (isNil "WMT_fnc_ChooseWinnerByTime") then {
    [[[_winSide, _message], {_this call WMT_fnc_EndMission;}], "bis_fnc_spawn"] call bis_fnc_mp;
} else {
    private _args = [_winSide, _message] call WMT_fnc_ChooseWinnerByTime;
    [[_args, {_this call WMT_fnc_EndMission;}], "bis_fnc_spawn"] call bis_fnc_mp;
};
