/*
 	Name: WMT_fnc_BoundingBoxMarker
 	
 	Author(s):
		Ezhuk

 	Description:
		Draw marker on object

	Parameters:
 		0: object
 		1: color (opt)

 	Returns:
		Nothing 

	Example:
		[this] call WMT_fnc_BoundingBoxMarker
		[this,"ColorGrey"] call WMT_fnc_BoundingBoxMarker
*/

private ["_obj","_id","_logic","_bbox","_b1","_b2","_bbx","_bby","_marker"];

if(!hasInterface)exitWith{};

_obj = _this select 0;
_color = [_this, 1, "ColorBlack"] call BIS_fnc_param;

_logic = bis_functions_mainscope;

//--- ID not defined yet
_id = if (isnil {_logic getvariable "bundingBoxMarker_id"}) then {_logic setvariable ["bundingBoxMarker_id",-1];-1} else {_logic getvariable "bundingBoxMarker_id"};
[_logic,"bundingBoxMarker_id",1] call bis_fnc_variablespaceadd;

_bbox = boundingboxreal _obj;
_b1 = _bbox select 0;
_b2 = _bbox select 1;
_bbx = (abs(_b1 select 0) + abs(_b2 select 0));
_bby = (abs(_b1 select 1) + abs(_b2 select 1));
_marker = createmarkerlocal [format ["WMT_BundingBoxMarker_%1",_id],position _obj];
_marker setmarkerdir direction _obj;
_marker setmarkershapelocal "rectangle";
_marker setmarkersizelocal [_bbx/2,_bby/2];
_marker setmarkercolor _color;
_marker setmarkeralphalocal 0.75;
_marker