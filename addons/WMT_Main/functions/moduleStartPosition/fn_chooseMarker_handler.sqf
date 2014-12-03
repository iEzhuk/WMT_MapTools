/*
 	Name: 
 	
 	Author(s):
		Ezhuk
*/

#include "defines_WMT.sqf"
#include "defines_IDC.sqf"
#include "defines_KEY.sqf"

PR(_event) = _this select 0;
PR(_arg) = _this select 1;
PR(_return) = false;

switch (_event) do 
{
	case "init":{		
		PR(_display) = _arg select 0;
		uiNamespace setVariable ['WMT_StartPos_Disaplay', _display];
		PR(_ctrl) = _display displayCtrl IDC_STARTPOS_TEXT;

		_ctrl ctrlSetText wmt_startPos_text;

		onMapSingleClick "['mapClick',_pos] call WMT_fnc_chooseMarker_handler";
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
		private ["_pos", "_nearestMarker", "_nearestDist", "_dist", "_marker"];

		_pos = _arg;
		_nearestMarker = -1;
		_nearestDist = 300;

		for "_i" from 0 to ((count wmt_startPos_marker)-1) do {
			_marker = wmt_startPos_marker select _i;
			_dist = _pos distance (getMarkerPos _marker);
			if (_dist < _nearestDist) then {
				_nearestDist = _dist;
				_nearestMarker = _i;
			};
		};

		if (_nearestMarker != -1) then {
			for "_i" from 0 to ((count wmt_startPos_marker)-1) do {
				_marker = wmt_startPos_marker select _i;
				_marker setMarkerAlphaLocal 0.7;
			};
			(wmt_startPos_marker select _nearestMarker) setMarkerAlphaLocal 1.0;

			[wmt_startPos_param, _nearestMarker] call wmt_startPos_setIndex;
		};
	};
};
_return