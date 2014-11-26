/*
 	Name: WMT_fnc_KeyUp
 	
 	Author(s):
		Ezhuk

 	Description:
		Handler function for keyUp handler from display #46
	
	Parameters:
		ARRAY: argument from event
 	
 	Returns:
		BOOL: for standart handlers 
*/

#include "defines_WMT.sqf"
#include "defines_KEY.sqf"

PR(_key)	= _this select 1;
PR(_shift)	= _this select 2;
PR(_ctrl)	= _this select 3;
PR(_alt)	= _this select 4;

PR(_denyaction) = false;

switch (_key) do
{
	case (KEY_END):
	{
		if(!isNil "WMT_Local_MissionEnd" || count WMT_Local_Killer > 0) then {
			call WMT_fnc_ShowStatistic;
		};
	};
};

_denyaction
