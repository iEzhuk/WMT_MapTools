/*
 	Name: WMT_fnc_CreateGlobalMarker
 	
 	Author(s):
		Zealot

 	Description:
		Creating  marker
	
	Parameters:
		0 - name 
		1 - position
		2 - text 
		3 - color 
		4 - type 
		5 - size 
		6 - shape 
		7 - direction
		8 - brush
 	
 	Returns:
		Marker
*/

private ["_marker","_pos","_text","_color","_type","_size","_shape","_dir","_brush"];

_marker = [_this, 0, "mrk"			] call BIS_fnc_param;
_pos 	= [_this, 1, [0,0]			] call BIS_fnc_param;
_text 	= [_this, 2, ""				] call BIS_fnc_param;
_color 	= [_this, 3, "ColorOrange"	] call BIS_fnc_param;
_type 	= [_this, 4, "mil_dot"		] call BIS_fnc_param;
_size 	= [_this, 5, [1,1] 			] call BIS_fnc_param;
_shape 	= [_this, 6, "ICON"			] call BIS_fnc_param;
_dir 	= [_this, 7, 0				] call BIS_fnc_param;
_brush 	= [_this, 8, "Solid"		] call BIS_fnc_param;

createMarker [_marker, _pos];

_marker setMarkerShape _shape;
_marker setMarkerType 	_type;
_marker setMarkerText 	_text;
_marker setMarkerColor _color;
_marker setMarkerDir 	_dir;
_marker setMarkerBrush _brush;
_marker setMarkerSize 	_size;
_marker setMarkerPos 	_pos;

_marker;