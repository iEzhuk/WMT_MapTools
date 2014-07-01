/*
 	Name: WMT_fnc_CreateLocalMarker
 	
 	Author(s):
		Ezhuk

 	Description:
		Creating local marker
	
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

_marker = _this select 0;
_pos 	= _this select 1;
_text 	= _this select 2;
_color 	= _this select 3;
_type 	= _this select 4;
_size 	= _this select 5;
_shape 	= _this select 6;
_dir 	= _this select 7;
_brush 	= _this select 8;

createMarkerLocal[_marker, _pos];

_marker setMarkerShapeLocal _shape;
_marker setMarkerTypeLocal 	_type;
_marker setMarkerTextLocal 	_text;
_marker setMarkerColorLocal _color;
_marker setMarkerDirLocal 	_dir;
_marker setMarkerBrushlocal _brush;
_marker setMarkerSizelocal 	_size;
_marker setMarkerPosLocal 	_pos;

_marker;