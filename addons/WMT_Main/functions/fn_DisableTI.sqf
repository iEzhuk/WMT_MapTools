/*
 	Name: WMT_fnc_DisableTI
 	
 	Author(s):
		Ezhuk

 	Description:
		Disable terminal image

	Parameters:
		0 - STRING: Type
		1 - ARRAY: Arguments
 	
 	Returns:
		BOOL: for standart handlers 
*/	
#include "defines.sqf"

PR(_event) = _this select 0;
PR(_arg) = _this select 1;
PR(_return) = false;

switch (_event) do 
{
	case "vehicle": {
		PR(_force) = _arg select 0;	
		{
			if(_x getVariable ["WMT_DisableTI",false] || _force) then {
				_x disableTIEquipment true;
			};
		} foreach vehicles;
	};
	case "full": {
		disableSerialization;

		PR(_dialog) = _arg select 0;
		PR(_ctrl) = _dialog displayCtrl IDD_DISABLETI_TEXT;
		PR(_tiOn) = false;

		while {true} do { 

			if (alive player) then {
				if (currentVisionMode player == 2) then { 
					if (!_tiOn) then {
						_ctrl ctrlSetBackgroundColor [0, 0, 0, 1];
						_ctrl ctrlSetText localize "STR_WMT_DisableTI";
					};
					_tiOn = true;
				} else {
					if (_tiOn) then {
						_ctrl ctrlSetBackgroundColor [0, 0, 0, 0];
						_ctrl ctrlSetText "";
					};
					_tiOn = false;
				};
			};

			sleep 0.016;
		};
	};
};

_return