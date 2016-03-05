 /*
    Name: WMT_fnc_HideUsersMarkers

    Author(s):
        Zealot

    Description:
        Hide markers based on their names

    Parameters:
        Nothing

    Returns:
        Nothing
*/
if (!hasInterface) exitWith{};

["itemAdd", ["wmthideusermarkers",
{
    {
        if (count _x >= 7) then {
            if (_x select [0,4] == "wmt_" && _x select [count _x-4,4] == "_del") then {
                _x setMarkerAlphaLocal 0;
            };
        };
    } foreach allMapMarkers;
},
nil, nil, { (missionNamespace getVariable ["WMT_pub_frzState",0]) >= 3}, {false}, true]] call BIS_fnc_loop;
