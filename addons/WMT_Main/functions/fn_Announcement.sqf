/*
    Name: WMT_fnc_Announcement

    Author(s):
        Ezhuk

    Description:
        Anouncement from admin panel

    Parameters:
        STRING

    Returns:
        Nothing
*/

[(format [ "<t size='1.1' color='#ee9000' shadow=2>%1</t>", _this]), 0, 0.75*safeZoneH+safeZoneY, 12, 0, 0, 32] spawn BIS_fnc_dynamicText;
