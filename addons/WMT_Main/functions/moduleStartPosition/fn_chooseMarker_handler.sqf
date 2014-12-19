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

		PR(_ctrlText) = _display displayCtrl IDC_STARTPOS_TEXT;
		_ctrlText ctrlSetText wmt_startPos_text;

		// Show selected position on map 
		PR(_selectedMarker) = wmt_startPos_param getVariable ["IndexPosition",-1];
		if (_selectedMarker!=-1) then {
			PR(_ctrlMap) = _display displayCtrl IDC_STARTPOS_MAP;
			_ctrlMap ctrlMapAnimAdd [0.5, 0.3, getMarkerPos (wmt_startPos_marker select _selectedMarker)];
			ctrlMapAnimCommit _ctrlMap;


			PR(_textMarker) = markerText (wmt_startPos_marker select _selectedMarker);
			if (_textMarker=="") then {
				_textMarker = str(_selectedMarker+1);
			};
			_ctrlText ctrlSetText format ["You have chosen a new position - %1.",_textMarker];
		};

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
		PR(_pos) = _arg;
		PR(_nearestMarker) = -1;
		PR(_nearestDist) = 300;

		for "_i" from 0 to ((count wmt_startPos_marker)-1) do {
			PR(_marker) = wmt_startPos_marker select _i;
			PR(_dist) = _pos distance (getMarkerPos _marker);
			if (_dist < _nearestDist) then {
				_nearestDist = _dist;
				_nearestMarker = _i;
			};
		};

		if (_nearestMarker != -1) then {
			for "_i" from 0 to ((count wmt_startPos_marker)-1) do {
				PR(_marker) = wmt_startPos_marker select _i;
				_marker setMarkerAlphaLocal 0.7;
			};
			(wmt_startPos_marker select _nearestMarker) setMarkerAlphaLocal 1.0;

			[wmt_startPos_param, _nearestMarker] call wmt_startPos_setIndex;



			PR(_display) = uiNamespace getVariable ['WMT_StartPos_Disaplay', displayNull];
			PR(_ctrlText) = _display displayCtrl IDC_STARTPOS_TEXT;

			PR(_textMarker) = markerText (wmt_startPos_marker select _nearestMarker);
			if (_textMarker=="") then {
				_textMarker = str(_nearestMarker+1);
			};

			_ctrlText ctrlSetText format ["You have chosen a new position - %1.",_textMarker];
		};
	};
};
_return