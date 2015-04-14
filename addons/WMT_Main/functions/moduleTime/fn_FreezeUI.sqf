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
#define PR(x) private ['x']; x

PR(_action) = -1;
PR(_gearaction)=-1;


if (leader player == player || serverCommandAvailable('#kick') ) then {
	// добавить - действие - не удалять бота
	_action = player addAction ["<t color='#0353f5'>"+localize('STR_WMT_DontRemove')+"</t>",{cursorTarget setVariable ["PlayerName", "AI", true];}, [], -1, false, true, "", 'cursorTarget isKindOf "Man" && {cursorTarget in (units group player)} && {(cursorTarget getVariable ["PlayerName",""]) == "" } '];  
    _gearaction = player addAction ["<t color='#0353f5'>"+localize('STR_WMT_FreezeAIINv')+"</t>",
        {player action ["Gear", cursorTarget];}, 
        [], -1, false, true, "", 
        'cursorTarget isKindOf "Man" && {cursorTarget in (units group player)} && {!isplayer cursorTarget}'];
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


    0 call WMT_fnc_FreezeVoteInfo;
	sleep 1;
	if (WMT_pub_frzState == 2 and not isServer) then { WMT_pub_frzTimeLeftForced = WMT_pub_frzTimeLeftForced - 1; };	
	if (not isServer) then { WMT_pub_frzTimeLeft = WMT_pub_frzTimeLeft - 1; };	
};

["<t size='1' color='#ff0000'>"+localize "STR_WMT_FreezeStart"+"</t>", 0,safeZoneY+0.01,5,0,0,3] spawn bis_fnc_dynamicText;
player removeAction _action;
player removeAction _gearaction;

 