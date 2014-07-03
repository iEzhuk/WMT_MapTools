/*
 	Name: 
 	
 	Author(s):
		Zealot

 	Description:
		Add list of squads and players to briefing 

*/
if (isNil "wog_mt_repairEnabled" or {wog_mt_repairEnabled == true}) then {
	[] spawn WMT_fnc_fieldrepair;
};