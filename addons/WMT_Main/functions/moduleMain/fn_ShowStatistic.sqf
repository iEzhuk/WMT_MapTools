/*
    Name: WMT_fnc_ShowStatistic

    Author(s):
        Ezhuk

    Description:
        show statistic of kills

    Parameters:
        Nothing

    Returns:
        Nothing
*/
if (wmt_param_Statistic==0) exitWith {};
if (isNil "WMT_Local_MissionEnd" && alive player) exitWith {};

private _text = "";

if (count WMT_Local_Killer > 0) then {
    private _killerName = WMT_Local_Killer select 0;
    private _killerSide = WMT_Local_Killer select 1;
    _text = _text + format ["<t color='#c7861b'>%1</t>:<br/>",localize "STR_WMT_Killer"];

    if (_killerName != WMT_Local_PlayerName) then {
        _text = _text + _killerName;
        if(_killerSide == playerSide) then {
            _text = _text + format [" (%1)", localize "STR_WMT_Ally"];
        };
    } else {
        _text = _text + format ["%1", localize "STR_WMT_Unknow"];
    };
};

if (count WMT_Local_Kills > 0) then {
    private _friendlySides = ([playerSide] call BIS_fnc_friendlySides) - [civilian];
    _text = _text + format ["<br/><br/><t color='#c7861b'>%1</t>: %2<br/>", localize "STR_WMT_Kills", count WMT_Local_Kills];

    {
        private _name = _x select 0;
        private _side = _x select 1;
        switch (true) do {
            // Killed civilian
            case (_side == civilian) : {
                _text = _text + format ["%1 <t color='#c7861b'>(%2)</t><br/>", _name, localize "STR_WMT_Civilian_m"];
            };
            // Friendly fire
            case (_side in _friendlySides) : {
                _text = _text + format ["%1 <t color='#c7861b'>(%2)</t><br/>", _name, localize "STR_WMT_Ally"];
            };
            default {
                _text = _text + format ["%1<br/>", _name];
            };
        };
    } foreach WMT_Local_Kills;
};

[(format [ "<t size='0.6'>%1</t>", _text]), 0, 0.25*safeZoneH+safeZoneY, 10, 0, 0, 35] spawn bis_fnc_dynamicText;
