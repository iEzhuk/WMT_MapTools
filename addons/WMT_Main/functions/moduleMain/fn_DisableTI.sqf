/*
    Name: WMT_fnc_DisableTI

    Author(s):
        Ezhuk

    Description:
        Disable thermal image

    Parameters:
        0 - STRING: Type
        1 - ARRAY: Arguments

    Returns:
        BOOL: for standart handlers
*/
#include "defines_IDC.sqf"

private _event = _this select 0;
private _arg = _this select 1;
private _return = false;
private _vehicles = (call WMT_fnc_GetVehicles);


switch (_event) do
{
    case "vehicle": {
        private _force = _arg select 0;
        {
            if(_x getVariable ["WMT_DisableTI",false] || _force) then {
                _x disableTIEquipment true;
            };
        } foreach _vehicles;
    };
    case "full": {
        disableSerialization;

        private _dialog = _arg select 0;
        private _ctrl = _dialog displayCtrl IDD_DISABLETI_TEXT;
        private _tiOn = false;

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
