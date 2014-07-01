/*
 	Name: WMT_fnc_NameTag
 	
 	Author(s):
		Ezhuk

 	Description:
		Show player tags

	Parameters:
		0 - STRING: Type
		1 - ARRAY: Arguments
 	
 	Returns:
		BOOL: for standart handlers 
*/	
#include "defines.sqf"

disableSerialization;

PR(_dialog) = _this select 0;
PR(_ctrl) = _dialog displayCtrl IDC_NAMETAG_TEXT;

while { true } do { 
	private ["_unit","_text"];
	_unit = cursorTarget;
	_text = "";

	if(alive player) then {
		if(!visibleMap) then {
			if(player != _unit) then {
				if(side _unit == WMT_Local_PlayerSide) then {
					if(alive _unit) then {
						if(!(["Error:", name _unit] call BIS_fnc_inString)) then {
							if(_unit distance player < 10) then {
								_text = format [ "<t color='#b1f240' shadow=2>%1</t>", name _unit];
							};
						};
					};
				};
			};
		};
	};

	_ctrl ctrlSetStructuredText (parseText _text);
	_ctrl ctrlCommit 0;

	sleep 0.3; 
};