/*
 	Name: WMT_fnc_FreezeUI
 	
 	Author(s):
		Zealot

 	Description:
	
	Parameters:
		Nothing
 	
 	Returns:
		Nothing
*/
#include "defines.sqf"

PR(_triggers) = [];
PR(_action) = -1;

if (leader player == player || serverCommandAvailable('#kick') ) then {
	_triggers =  [
		[true, 0, "ALPHA", "PRESENT","this","[] call WMT_fnc_FreezeVoteStart ","",localize "STR_WMT_FreezeVoteStart"] call WMT_fnc_CreateTrigger,
		[true, 0, "BRAVO", "PRESENT","this","[] call WMT_fnc_FreezeVoteWait ","",localize "STR_WMT_FreezeVoteWait"] call WMT_fnc_CreateTrigger
	];
	// добавить - действие - не удалять бота
	_action = player addAction ["<t color='#0353f5'>"+localize('STR_WMT_DontRemove')+"</t>",{cursorTarget setVariable ["PlayerName", "AI", true];}, [], -1, false, true, "", 'cursorTarget isKindOf "Man" && {cursorTarget in (units group player)} && {(cursorTarget getVariable ["PlayerName",""]) == "" } '];  
};

sleep 0.01;
while {WMT_pub_frzState < 3} do {

	PR(_time3) = round(WMT_pub_frzTimeLeft);
	PR(_sec) = 0;
	if (WMT_pub_frzState == 2) then {
		_sec = round (WMT_pub_frzTimeLeftForced);
	} else {
		_sec = _time3;
	};
	PR(_infoStr1) = format ["<t size='0.6' color='%2'>%1</t>", [0 max (_sec min _time3),"MM:SS"] call BIS_fnc_secondsToString, if (_sec >= 30 ) then {"#cccccc"} else {"#ff0000"}];
	[_infoStr1, 0, safeZoneY+0.01, 1.5, 0, 0, 3] spawn bis_fnc_dynamicText;


	if (count WMT_pub_frzVoteWait != 0 or count WMT_pub_frzVoteStart != 0) then {
		PR(_infoStr5) = format ["<t size='0.4' color='#aaaaaa'>"+localize "STR_WMT_FreezeVoteStartCaption"+" %1<br/>"+localize "STR_WMT_FreezeVoteWaitCaption"+" %2<br/></t>",
		[WMT_pub_frzVoteStart] call WMT_fnc_ArrayToString, [WMT_pub_frzVoteWait] call WMT_fnc_ArrayToString ];
		[_infoStr5, 0.3, safeZoneY+0.01, 1.5, 0, 0, 4]  spawn bis_fnc_dynamicText;

	};
	sleep 1;
	if (WMT_pub_frzState == 2 and not isServer) then { WMT_pub_frzTimeLeftForced = WMT_pub_frzTimeLeftForced - 1; };	
	if (not isServer) then { WMT_pub_frzTimeLeft = WMT_pub_frzTimeLeft - 1; };	
};

["<t size='1' color='#ff0000'>"+localize "STR_WMT_FreezeStart"+"</t>", 0,safeZoneY+0.01,5,0,0,3] spawn bis_fnc_dynamicText;
{deleteVehicle _x} foreach _triggers;
player removeAction _action;


 