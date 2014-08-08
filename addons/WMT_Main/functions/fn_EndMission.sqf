/*
 	Name: WMT_fnc_EndMission
 	
 	Author(s):
		Ezhuk

 	Description:
		Function for end mission 
	
	Parameters:
		0 - STRING: message
	or 
		0 - SIDE: win side 
		1 - STRING: message 
 		
 	Returns:
		Nothing
*/
#include "defines.sqf"

if(!isNil "WMT_Local_MissionEnd") exitWith {diag_log "WARNING!!! WMT_Local_MissionEnd - multiple call";};
WMT_Local_MissionEnd = true; 

if(count _this == 2) then {
	PR(_winner) = _this select 0;
	PR(_text) = _this select 1;

	PR(_isPlayerWin) = 	playerSide in ( [_winner] call bis_fnc_friendlysides );
						
	PR(_textWinner) = if(_isPlayerWin)then{localize "STR_WMT_Win"}else{localize "STR_WMT_Lose"};

	PR(_color) = if(_isPlayerWin)then{"#057f05"}else{"#7f0505"};//green or red

	[ (format [ "<t size='1.4' color='%1'>%2</t>", _color, _textWinner]), 0, 0.3, 15, 0, 0, 30] spawn bis_fnc_dynamicText;
	[ (format [ "<t size='1.4' color='%1'>%2</t>", _color, _text]), 0, 0.5, 15, 0, 0, 31] spawn bis_fnc_dynamicText;

	// Disable damage 
	if(player != vehicle player)then{
		(vehicle player) addEventHandler ['HandleDamage', {false}];
	};
	player addEventHandler ['HandleDamage', {false}];

	["end1",_isPlayerWin,10] call BIS_fnc_endMission;
};

if(count _this == 1) then {
	PR(_text) = _this select 0;
	[ (format [ "<t size='1.4' color='#ff9000' shadow=2 >%1</t>", localize "STR_WMT_EndMissionByAdmin"] ), 0, 0.3, 15, 0, 0, 30] spawn bis_fnc_dynamicText;
	[ (format [ "<t size='1.4' color='#ff9000' shadow=2 >%1</t>", _text] ), 0, 0.5, 15, 0, 0, 31] spawn bis_fnc_dynamicText;
	["end1",false,10] call BIS_fnc_endMission;
};
