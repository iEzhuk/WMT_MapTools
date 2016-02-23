/*
    Name: WMT_fnc_LongGroupNameToShort

    Author(s):
        Zealot

    Description:
        Contraction of the name of group
        "Alpha 1-1" -> "A1-1"

    Parameters:
        STRING: group

    Returns:
        STRING: short name of the group
*/
private _longGr  = _this;
private _arr     = [_longGr, " -"] call BIS_fnc_splitString;
private _shortGr = _longGr;

if (count _arr >= 2 and count (_arr select 0) >= 1) then {
    private _frstLttr = (_arr select 0) select [0,1];
    if (language == "Russian") then {
        _frstLttr = (_arr select 0) select [0,2];
    };
    _shortGr = _frstLttr + (_arr select 1) + "-" + (_arr select 2);
};

_shortGr;
