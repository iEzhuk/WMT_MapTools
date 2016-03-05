/*
    Name: WMT_fnc_BoundingBoxMarker

    Author(s):
        Ezhuk

    Description:
        Draw marker on object.
        Modifined BIS_fnc_BoundingBoxMarker.

    Parameters:
        0: object
        1: color (opt)
        2: alpha (opt)
    Returns:
        Nothing

    Example:
        [this] call WMT_fnc_BoundingBoxMarker
        [this,"ColorGrey",0.5] call WMT_fnc_BoundingBoxMarker
*/
private ["_obj","_id","_logic","_bbox","_b1","_b2","_bbx","_bby","_marker"];

if(!hasInterface)exitWith{};

_obj   = _this select 0;
_color = [_this, 1, "ColorGrey"] call BIS_fnc_param;
_alpha = [_this, 2, 1.0] call BIS_fnc_param;

_logic = bis_functions_mainscope;
_id    = if (isnil {_logic getvariable "bundingBoxMarker_id"}) then {_logic setvariable ["bundingBoxMarker_id",-1];-1} else {_logic getvariable "bundingBoxMarker_id"};

[_logic,"bundingBoxMarker_id",1] call bis_fnc_variablespaceadd;

_bbox   = boundingboxreal _obj;
_b1     = _bbox select 0;
_b2     = _bbox select 1;
_bbx    = (abs(_b1 select 0) + abs(_b2 select 0));
_bby    = (abs(_b1 select 1) + abs(_b2 select 1));

_marker = createmarkerlocal [format ["WMT_BundingBoxMarker_%1",_id],position _obj];

_marker setmarkerdir        direction _obj;
_marker setmarkershapelocal "rectangle";
_marker setMarkerBrushLocal "SolidFull";
_marker setmarkersizelocal  [_bbx/2,_bby/2];
_marker setmarkercolor      _color;
_marker setmarkeralphalocal _alpha;

_marker
