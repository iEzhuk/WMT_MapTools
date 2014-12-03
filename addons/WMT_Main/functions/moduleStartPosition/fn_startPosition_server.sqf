/*
 	Name: WMT_fnc_startPosition_server
 	
 	Author(s):
		Ezhuk
*/


private ["_logic", "_units", "_owner", "_center", "_markers" , "_time", "_moduleSide", "_indexPos", "_map", "_centerPos", "_centerDir", "_object", "_offset"];


_logic   = _this select 0;
_units   = _this select 1;
_owner   = _this select 2;
_center  = _this select 3;
_markers = _this select 4;
_time    = _this select 5;
_moduleSide = _this select 6;
//===================================================
// 					INIT
//===================================================

// Calculate offets by center for all bjects 
_map = [];
_centerPos = getMarkerPos _center;
_centerDir = getMarkerDir _center;

for "_i" from 0 to ((count _units)-1) do {
	_obj = _units select _i;
	_pos = getPos _obj;
	_offset = _centerPos vectorDiff (getPos _obj);
	_offset set [2, 0];
	_map pushBack [_obj, _offset];
};
_logic setVariable ["Map", _map];


//===================================================
// 					WAIT
//===================================================
sleep 1;
if (not isNil "WMT_pub_frzState") then {
	waitUntil {sleep 2; WMT_pub_frzState >= 3};
} else {
	sleep _time;
};



//===================================================
// 					TELEPORT
//===================================================
// Get selected start position
if (_owner == "") then {
	// Random position
	_indexPos = floor(random (count _markers-0.01));
} else {
	// Choosing position
	_indexPos = _logic getVariable ["IndexPosition",-1];
};
_indexPos = 0 max _indexPos;


// Get position of marker
_markerPos = getMarkerPos (_markers select _indexPos);
_markerdir = getMarkerDir (_markers select _indexPos);

// Teleport 
for "_i" from 0 to ((count _map)-1) do {
	_object = (_map select _i) select 0;
	_offset = (_map select _i) select 1;
	_offset = _offset 

	
	if (vehicle _object != _object) then {
		_object action ["getout", vehicle _object];
	};

	_object setPos (_markerPos vectorAdd _offset);
	_object setDir _markerdir;
};


// Remove markers
for "_i" from 0 to ((count _markers)-1) do {
	deleteMarker (_markers select _i);
};

_logic setVariable ["Finished", true, true];