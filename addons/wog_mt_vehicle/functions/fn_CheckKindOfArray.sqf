/*
 	Name: 
 	
 	Author(s):
		Zealot

 	Description:
		Checks whether is vehicle is belongs to one or more classes 
		

*/
 
#define PR(x) private ['x']; x

PR(_obj) = _this select 0;
PR(_kindArr) = _this select 1;
PR(_res) = false;
{
	if (_obj isKindOf _x) exitWith {_res = true;};

} foreach _kindArr;
_res;
