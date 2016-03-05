
/*
    Name: WMT_fnc_ZoneCaptured

    Author(s):
        Zealot

    Description:
        Show notification to user when zone is captured

    Parameters:
        SIDE - side which is captured the zone
        String - message to users
        [STRINGS] - array of markers which is need to recolor to new side

    Returns:
        Nothing
*/
private _side = if (isNull player ) then {sideUnknown} else {playerSide};
private _text = "";
private _markers = [];

for "_x" from 0 to (count _this)-1 do {
    _a = _this select _x;
    switch true do {
        case (typeName _a == typeName west) : {_side = _a;};
        case (typeName _a == typeName "") : {_text = _a};
        case (typeName _a == typeName []) : {_markers = _a};
    };
};

private _mcolor = [_side, true] call bis_fnc_sidecolor;
private _tcolor = [_side] call bis_fnc_sidecolor call BIS_fnc_colorRGBtoHTML ;
// hint composeText [parsetext format["<t size='1' align='center' color='%2'>%1</t>",_text,_tcolor]];
private _playerside = if (isNull player ) then {_side} else {playerSide};
private _notifyType = if ( [_playerSide ,_side] call BIS_fnc_areFriendly ) then {"TaskSucceeded"} else {"TaskFailed"};
[_notifyType, [0, _text]] call bis_fnc_showNotification;

{
    if (markerAlpha _x != 0) then {
        switch (markerSHape _x) do {
            case ("ICON") : {
                ["destroyed"+str(time)+str(_x),getMarkerPos _x, "", _mcolor, "mil_objective" ] call WMT_fnc_CreateLocalMarker;
            };
            default {
                _x setMarkerColorLocal _mcolor;
            };
        };
    };
} foreach _markers;
