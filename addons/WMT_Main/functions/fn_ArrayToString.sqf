/*
    Name: WMT_fnc_ArrayToString

    Author(s):
        Zealot

    Description:
        Convert array to string
        ["Text1", 2,"Text3"] -> "Text1 2 Text3"

    Parameters:
        0: ARRAY

    Returns:
        STRING
*/
private ["_arr", "_count", "_res"];
params ["_arr"];
_count = count _arr;
_res = "";
{
    _res = format ["%1%2",_res,_x];
    if(_forEachIndex != (_count-1)) then {
        _res = _res + " ";
    };
} foreach _arr;
_res;
