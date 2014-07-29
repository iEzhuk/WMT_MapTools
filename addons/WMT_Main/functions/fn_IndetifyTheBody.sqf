/*
 	Name: WMT_fnc_IndetifyTheBody
 	
 	Author(s):
		Ezhuk

 	Description:
		Show name of player in center of the screen
*/

private ["_unit"];
_unit = cursortarget;
_name = _unit getvariable ["WMT_PlayerName", localize "STR_WMT_Unknow"];

[format["<t size='1' font='PuristaMedium' color='#b1f240' shadow = 2>%1</t>",_name], 0,0.65*safezoneH + safezoneY,2,0,0,60] spawn bis_fnc_dynamicText;