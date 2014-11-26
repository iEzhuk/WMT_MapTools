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
#define PR(x) private ['x']; x

PR(_longGr) = _this;
PR(_arr) = [_longGr, " -"] call BIS_fnc_splitString;
PR(_shortGr) = _longGr;
if (count _arr >= 2) then {
	PR(_frstLttr) = [_arr select 0, 0, 0] call BIS_fnc_trimString;
	_shortGr = _frstLttr + (_arr select 1) + "-" + (_arr select 2);
};
_shortGr;
