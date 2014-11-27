/*
 	Name: WMT_fnc_InitModuleStartPosition
 	
 	Author(s):
		Ezhuk

 	Description:
		Initialize main module
*/
#include "defines_WMT.sqf"

PR(_logic) = [_this,0,objNull,[objNull]] call BIS_fnc_param;
PR(_units) = [_this,1,[],[[]]] call BIS_fnc_param;
PR(_activated) = [_this,2,true,[true]] call BIS_fnc_param;

if(_activated) then {
	

};
