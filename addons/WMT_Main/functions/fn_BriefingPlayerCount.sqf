/*
    Name:
        WMT_fnc_BriefingPlayerCount

    Author(s):
        Ezhuk

    Description:
        Add information about player count

    Parameters:
        Nothing

    Returns:
        Nothing
*/
if (!hasInterface) exitwith {};

private _sideToColor = {
	switch _this do {
		case WEST:{"#00478f"};
		case EAST:{"#5f0000"};
		case RESISTANCE:{"#005f00"};
		default{"#4c005f"};
	};
};

disableSerialization;
uisleep 1.;

private _display = uinamespace getVariable ["RscDiary",displaynull];

if (isnull _display) exitwith {};
_ctrl = _display ctrlCreate ["RscStructuredText", -1];
_ctrl ctrlSetPosition [safeZoneX, 0.75, 0.15, 0.3];
_ctrl ctrlSetText "";
_ctrl ctrlSetTextColor [0.95, 0.95, 0.95, 1];
_ctrl ctrlCommit 0;

while {time < 0.1} do {
    _txt = "";
    {
        _side = _x;
        _color = _side call _sideToColor;
        _count = {alive _x && side _x == _side && isPlayer _x} count allUnits;
        if (_count > 0) then {
            _txt = _txt + format ["<t color='%1'><img image='a3\ui_f\data\gui\rsc\rscdisplaymultiplayersetup\flag_bluefor_ca.paa'/></t> %2<br/>", _color, _count];
        };
    } foreach [west, east, resistance, civilian];

    _ctrl ctrlSetStructuredText parseText _txt;
    _ctrl ctrlCommit 0;
    uisleep 1;
};

ctrlDelete _ctrl;
