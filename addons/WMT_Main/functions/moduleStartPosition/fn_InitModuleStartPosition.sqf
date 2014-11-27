/*
 	Name: WMT_fnc_InitModuleStartPosition
 	
 	Author(s):
		Ezhuk

 	Description:
		Initialize main module
*/
#define ERROR(x) x call BIS_fnc_error; x call BIS_fnc_log;
		
private ["_logic", "_units", "_activated"];

_logic     = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units 	   = [_this,1,[],[[]]] call BIS_fnc_param;
_activated = [_this,2,true,[true]] call BIS_fnc_param;

if(_activated) then {
	private ["_owner", "_center", "_markerStr", "_hideFromEnemy" , "_arrMarkers", "_valid" , "_marker", "_pos"]; 

	_owner         = _logic getVariable ["Owner",""];
	_center        = _logic getVariable ["CenterObject",""];
	_markerStr     = _logic getVariable ["Positions",""];
	_hideFromEnemy = _logic getVariable ["HideFromEnemy",0];
	_time          = _logic getVariable ["Time",3];

	systemChat str(_units);
	_logic setVariable ["Units",_units];

	// Remove spaces 
	_markerStr = toString ((toArray _markerStr) - [32]);
	// Split on markers
	_arrMarkers = [_markerStr,","] call Bis_fnc_splitString;

	// Check owner and markers
	_valid = true;
	if(call compile format ["isNil {%1}",_center]) then {

			ERROR(format ["WMT_fnc_InitModuleStartPosition: object <%1> is not exist", _center]);
	};

	if(call compile format ["isNil {%1}",_owner]) then {
			ERROR(format ["WMT_fnc_InitModuleStartPosition: object <%1> is not exist", _owner]);
	};

	for "_i" from 0 to ((count _arrMarkers)-1) do {
		_marker = _arrMarkers select _i;
		_pos = getMarkerPos _marker;

		if ((_pos select 0) == 0 && (_pos select 1) == 0) then {
			ERROR(format ["WMT_fnc_InitModuleStartPosition: marker <%1> is not exist", _marker]);
			_valid = false;
		};
	};


	if(_valid) then {
		// String to object
		_owner = call compile _owner;

		//================================================
		//					SERVER
		//================================================
		if(isServer) then {
			[_logic, _units, _owner, _center, _arrMarkers, _hideFromEnemy] spawn WMT_fnc_startPosition_server;
		}; 

		//================================================
		//					CLIENT
		//================================================
		if(!isDedicated) then {
			[_logic, _units, _owner, _center, _arrMarkers, _hideFromEnemy] spawn WMT_fnc_startPosition_server;
		};
	};

};
