/*
 	Name: WMT_fnc_InitModuleStartPosition
 	
 	Author(s):
		Ezhuk

 	Description:
		Initialize main module
*/
#define ERROR(x) hint x; systemChat x; x call BIS_fnc_error; x call BIS_fnc_log; 

private ["_logic", "_units", "_activated", "_obj"];

_logic     = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units 	   = [_this,1,[],[[]]] call BIS_fnc_param;
_activated = [_this,2,true,[true]] call BIS_fnc_param;

if(_activated) then {
	private ["_owner", "_center", "_markerStr", "_markerSide" , "_arrMarkers", "_valid" , "_marker", "_pos", "_syncObjs"]; 

	_owner      = _logic getVariable ["Owner",""];
	_center     = _logic getVariable ["CenterObject",""];
	_markerStr  = _logic getVariable ["Positions",""];
	_time       = _logic getVariable ["Time",3];
	_text       = _logic getVariable ["Text",""];

	_markerSide = [sideLogic,east,west,resistance,civilian] select (_logic getVariable ["MarkerSide",0]);

	// Remove spaces 
	_markerStr = toString ((toArray _markerStr) - [32]);
	_center = toString ((toArray _center) - [32]);

	// Split on markers
	_arrMarkers = [_markerStr,","] call Bis_fnc_splitString;
	_logic setVariable ["Markers",_arrMarkers];
	
	// Check parameters
	_valid = true;
	if (_text == "") then {
		ERROR("WMT_fnc_InitModuleStartPosition: field text is empty");
		_valid = false;
	};

	// Checking objects and markers	 
	if (_owner != "") then {
		if(call compile format ["isNil {%1}",_owner]) then {
				ERROR(format ["WMT_fnc_InitModuleStartPosition: object <%1> is not exist", _owner]);
				_valid = false;
		};
	};

	_pos = getMarkerPos _center;
	if((_pos select 0) == 0 && (_pos select 1) == 0) then {
			ERROR(format ["WMT_fnc_InitModuleStartPosition: marker <%1> is not exist", _center]);
			_valid = false;
	};

	for "_i" from 0 to ((count _arrMarkers)-1) do {
		_marker = _arrMarkers select _i;
		_pos = getMarkerPos _marker;

		if ((_pos select 0) == 0 && (_pos select 1) == 0) then {
			ERROR(format ["WMT_fnc_InitModuleStartPosition: marker <%1> is not exist", _marker]);
			_valid = false;
		};
	};

	// Detect units from group
	_syncObjs = [];
	
	for "_i" from 0 to ((count _units)-1) do {
		_obj = _units select _i;
		switch (true) do {
			case (_obj isKindOf "Man") : {
				_syncObjs = _syncObjs + units group _obj;
			};
			default {
				_syncObjs pushBack _obj;
			};
		}
	};

	if(_valid) then {
		if(isServer) then {
			[_logic, _syncObjs, _owner, _center, _arrMarkers, _time] spawn WMT_fnc_startPosition_server;
		}; 

		if(!isDedicated) then {
			[_logic, _syncObjs, _owner, _arrMarkers, _time, _markerSide, _text] spawn WMT_fnc_startPosition_client;
		};
	};

};
