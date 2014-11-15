/*
 	Name: WMT_fnc_NameTag
 	
 	Author(s):
		Ezhuk

 	Description:
		Show player tag with name

	Parameters:
		ARRAY: from dialog handler 
 	
 	Returns:
		Nothing
*/	
#include "defines.sqf"

disableSerialization;

PR(_dialog) = _this select 0;
PR(_ctrl) = _dialog displayCtrl IDC_NAMETAG_TEXT;
PR(_friendlySides) = [playerSide] call BIS_fnc_friendlySides;

sleep 0.1;

while { true } do { 
	private ["_unit","_text"];
	_unit = cursorTarget;
	_text = "";

	if (!(_unit isKindOf "Animal")) then {
		if (count (crew _unit) > 0) then {
			_unit = (crew _unit) select 0;
			if (alive player) then {
				if (!visibleMap) then {
					if (player != _unit) then {
						if (alive _unit) then {
							PR(_side) = _unit getVariable ["PlayerSide", side _unit];
							if (_side in _friendlySides) then {
								if (_unit distance player < 10) then {
									PR(_name) = _unit getVariable ["PlayerName", name _unit];
									if (isPlayer _unit) then {
										_text = format [ "<t color='#b1f240' shadow=2>%1</t>", _name];
									} else {
										_text = format [ "<t color='#b1f240' shadow=2>%1 [AI]</t>", _name];
									};
								};
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