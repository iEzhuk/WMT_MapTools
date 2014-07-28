/*
 	Name: WMT_fnc_InitMain
 	
 	Author(s):
		Ezhuk

 	Description:
		Initialize general variables 
*/

if(!isDedicated) then {
	
	waitUntil{player==player};
	waitUntil{alive player};
	waitUntil{local player};


	WMT_Local_PlayerName = name player;
	WMT_Local_PlayerSide = side player;

	player setVariable ["WMT_PlayerName",WMT_Local_PlayerName,true];
	player setVariable ["WMT_PlayerSide",WMT_Local_PlayerSide,true];
};