/*
    Name: WMT_fnc_chooseMarker_handler

    Author(s):
        Ezhuk
*/
#include "defines_IDC.sqf"
#include "..\defines_KEY.sqf"

params ["_event", "_arg"];
private _return = false;

switch (_event) do
{
    case "init":{
        private _display = _arg select 0;
        uiNamespace setVariable ['WMT_StartPos_Disaplay', _display];

        private _ctrlText = _display displayCtrl IDC_STARTPOS_TEXT;
        _ctrlText ctrlSetText wmt_startPos_text;

        // Show selected position on map
        private _selectedMarker = wmt_startPos_param getVariable ["IndexPosition",-1];
        if (_selectedMarker!=-1) then {
            private _ctrlMap = _display displayCtrl IDC_STARTPOS_MAP;
            _ctrlMap ctrlMapAnimAdd [0.5, 0.3, getMarkerPos (wmt_startPos_marker select _selectedMarker)];
            ctrlMapAnimCommit _ctrlMap;


            private _textMarker = markerText (wmt_startPos_marker select _selectedMarker);
            if (_textMarker=="") then {
                _textMarker = str(_selectedMarker+1);
            };
            _ctrlText ctrlSetText format [localize "STR_WMT_SP_ChosenPosition", _textMarker];
        };

        onMapSingleClick "['mapClick',_pos] call WMT_fnc_chooseMarker_handler";

        (_display displayCtrl IDC_STARTPOS_LEDHDD) ctrlShow false;
        (_display displayCtrl IDC_STARTPOS_LEDNET) ctrlShow false;

        ["net_activity", [0.15, 0.1, 20]] spawn WMT_fnc_chooseMarker_handler;
        ["hdd_activity", [0.6, 0.12, ceil(random 3)+2]] spawn WMT_fnc_chooseMarker_handler;
    };
    case "close":{
        uiNamespace setVariable ['WMT_StartPos_Disaplay', nil];
        onMapSingleClick "";

        wmt_startPos_marker   = nil;
        wmt_startPos_param    = nil;
        wmt_startPos_setIndex = nil;
    };
    case "openMap":{
        wmt_startPos_marker   = _arg select 0;
        wmt_startPos_param    = _arg select 1;
        wmt_startPos_setIndex = _arg select 2;
        wmt_startPos_text     = _arg select 3;

        createDialog "RscWMTChooseMarker";
    };
    case "mapClick":{
        private _pos = _arg;
        private _nearestMarker = -1;
        private _nearestDist = 300;

        for "_i" from 0 to ((count wmt_startPos_marker)-1) do {
            private _marker = wmt_startPos_marker select _i;
            private _dist = _pos distance (getMarkerPos _marker);
            if (_dist < _nearestDist) then {
                _nearestDist = _dist;
                _nearestMarker = _i;
            };
        };

        if (_nearestMarker != -1) then {
            private ["_marker"];
            for "_i" from 0 to ((count wmt_startPos_marker)-1) do {
                _marker = wmt_startPos_marker select _i;
                _marker setMarkerAlphaLocal 0.7;
            };
            (wmt_startPos_marker select _nearestMarker) setMarkerAlphaLocal 1.0;

            [wmt_startPos_param, _nearestMarker] call wmt_startPos_setIndex;

            private _display = uiNamespace getVariable ['WMT_StartPos_Disaplay', displayNull];
            private _ctrlText = _display displayCtrl IDC_STARTPOS_TEXT;
            private _textMarker = markerText (wmt_startPos_marker select _nearestMarker);
            if (_textMarker=="") then {
                _textMarker = str(_nearestMarker+1);
            };

            _ctrlText ctrlSetText format [localize "STR_WMT_SP_ChosenPosition", _textMarker];

            ["net_activity", []] spawn WMT_fnc_chooseMarker_handler;
        };
        ["hdd_activity", [0.1, 0.03, ceil(random 2)]] spawn WMT_fnc_chooseMarker_handler;
    };
    case "net_activity":
    {
        disableSerialization;
        private _intervalOn  = [_arg, 0, 0.2] call BIS_fnc_param;
        private _intervalOff = [_arg, 1, 0.08] call BIS_fnc_param;
        private _count       = [_arg, 2, 7] call BIS_fnc_param;
        private _stayOn      = [_arg, 3, false] call BIS_fnc_param;

        private _display = uiNamespace getVariable ['WMT_StartPos_Disaplay', displayNull];
        private _ctrlLed = _display displayCtrl IDC_STARTPOS_LEDNET;

        if !(isNil "wmt_startPos_netactivity_mutex") exitWith {
            wmt_startPos_netactivity_mutex = [_intervalOn, _intervalOff, _count, _stayOn];
        };

        wmt_startPos_netactivity_mutex = [_intervalOn, _intervalOff, _count, _stayOn];
        sleep (random 0.5);
        while {(wmt_startPos_netactivity_mutex select 2)>0} do {
            _ctrlLed ctrlShow true;
            sleep (wmt_startPos_netactivity_mutex select 0);
            _ctrlLed ctrlShow false;
            sleep (wmt_startPos_netactivity_mutex select 1);

            wmt_startPos_netactivity_mutex set [2, (wmt_startPos_netactivity_mutex select 2)-1];
        };

        _ctrlLed ctrlShow (wmt_startPos_netactivity_mutex select 3);

        wmt_startPos_netactivity_mutex = nil;
    };
    case "hdd_activity":
    {
        disableSerialization;
        private _intervalOn  = [_arg, 0, 0.2] call BIS_fnc_param;
        private _intervalOff = [_arg, 1, 0.1] call BIS_fnc_param;
        private _count       = [_arg, 2, 2] call BIS_fnc_param;
        private _stayOn      = [_arg, 3, false] call BIS_fnc_param;

        private _display = uiNamespace getVariable ['WMT_StartPos_Disaplay', displayNull];
        private _ctrlLed = _display displayCtrl IDC_STARTPOS_LEDHDD;

        if !(isNil "wmt_startPos_hddactivity_mutex") exitWith {
            wmt_startPos_hddactivity_mutex = [_intervalOn, _intervalOff, _count, _stayOn];
        };

        wmt_startPos_hddactivity_mutex = [_intervalOn, _intervalOff, _count, _stayOn];
        sleep (random 0.5);
        while {wmt_startPos_hddactivity_mutex select 2 > 0} do {
            _ctrlLed ctrlShow true;
            sleep (wmt_startPos_hddactivity_mutex select 0);
            _ctrlLed ctrlShow false;
            sleep (wmt_startPos_hddactivity_mutex select 1);

            wmt_startPos_hddactivity_mutex set [2, (wmt_startPos_hddactivity_mutex select 2)-1];
        };

        _ctrlLed ctrlShow (wmt_startPos_hddactivity_mutex select 3);

        wmt_startPos_hddactivity_mutex = nil;
    };

};
_return
