/*
 	Name: WMT_fnc_InitModuleStartPosition
 	
 	Author(s):
		Ezhuk

 	Description:
		Initialize main module
*/
#define ERROR(x) systemChat x; x call BIS_fnc_error; x call BIS_fnc_log; 

private ["_logic", "_units", "_activated", "_obj"];

_logic     = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units 	   = [_this,1,[],[[]]] call BIS_fnc_param;
_activated = [_this,2,true,[true]] call BIS_fnc_param;

if(_activated) then {
	private ["_owner", "_center", "_markerStr", "_hideFromEnemy" , "_arrMarkers", "_valid" , "_marker", "_pos", "_syncObjs", "_moduleSide"]; 

	_owner         = _logic getVariable ["Owner",""];
	_center        = _logic getVariable ["CenterObject",""];
	_markerStr     = _logic getVariable ["Positions",""];
	_hideFromEnemy = _logic getVariable ["HideFromEnemy",0];
	_time          = _logic getVariable ["Time",3];
	_text          = _logic getVariable ["Text",""];

	// Remove spaces 
	_markerStr = toString ((toArray _markerStr) - [32]);
	_center = toString ((toArray _center) - [32]);
	// Split on markers
	_arrMarkers = [_markerStr,","] call Bis_fnc_splitString;
	_logic setVariable ["Markers",_arrMarkers];

	
	_valid = true;
	if (_text == "") then {
		ERROR("WMT_fnc_InitModuleStartPosition: field text is empty");
		_valid = false;
	};

	// Check owner and markers
	_moduleSide = sideLogic;
	if (_owner != "") then {
		if(call compile format ["isNil {%1}",_owner]) then {
				ERROR(format ["WMT_fnc_InitModuleStartPosition: object <%1> is not exist", _owner]);
				_valid = false;
		} else {
			_moduleSide = side (call compile format ["%1",_owner]);
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

				if (_moduleSide == sideLogic && side _obj != civilian) then {
					_moduleSide = side _obj; 
				};
			};
			default {
				_syncObjs pushBack _obj;
				if (_moduleSide == sideLogic && (_obj getVariable ["WMT_Side",side _obj]) != civilian) then {
					_moduleSide = _obj getVariable ["WMT_Side",side _obj]; 
				};
			};
		}
	};

	if(_valid) then {
		//================================================
		//					SERVER
		//================================================
		if(isServer) then {
			[_logic, _syncObjs, _owner, _center, _arrMarkers, _time, _moduleSide] spawn WMT_fnc_startPosition_server;
		}; 

		//================================================
		//					CLIENT
		//================================================
		if(!isDedicated) then {
			systemChat "CLIENT";
			[_logic, _syncObjs, _owner, _arrMarkers, _hideFromEnemy, _time, _moduleSide, _text] spawn WMT_fnc_startPosition_client;
		};
	};

};
