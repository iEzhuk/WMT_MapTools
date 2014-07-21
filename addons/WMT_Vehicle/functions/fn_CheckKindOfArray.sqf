/*
 	Name: WMT_fnc_CheckKindOfArray
 	
 	Author(s):
		Zealot

 	Description:
		Checks parts of vehicle for repair 

	Parameters:
		0: OBJECT
 		1: vehcile parts

 	Returns:
		BOOL
*/
 
#define PR(x) private ['x']; x

PR(_obj) = _this select 0;
PR(_kindArr) = _this select 1;
PR(_res) = false;
{
	if (_obj isKindOf _x) exitWith {_res = true;};

} foreach _kindArr;
_res;
