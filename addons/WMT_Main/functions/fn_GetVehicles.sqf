/*
    Name: WMT_fnc_GetVehicles

    Author(s):
        Zealot

    Description:
        Get vehicles array

    Parameters:
        NONE

    Returns:
        ARRAY: vehicles
*/

if (isNil "WMT_Local_Vehicles") then {
    WMT_Local_Vehicles = [];
    {
        if (_x isKindof "Ship" || _x isKindof "Air" || _x isKindof "LandVehicle") then {
            WMT_Local_Vehicles pushBack _x;
        };
    } foreach vehicles;
};
WMT_Local_Vehicles
