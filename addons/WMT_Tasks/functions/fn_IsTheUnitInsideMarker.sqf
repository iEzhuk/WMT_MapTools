/*
     Name: WMT_fnc_IsTheUnitInsideMarker
     
     Author(s):
        Ezhuk

     Description:
        Detect object in marker
    
    Parameters:
        0: OBJECT
        1: MARKER

     Returns:
        BOOL
*/
private ["_pointInCircle","_pointInEllipse","_pointInReactangle","_movePointByCenter"];

//===============================================================
// Move point around the center with angle 
// return: [x,y]
//===============================================================
_movePointByCenter = {
    private ["_pX0", "_pY0","_cX", "_cY","_a","_pX1", "_pY1"];
    _pX0 = _this select 0;
    _pY0 = _this select 1;
    _cX  = _this select 2;
    _cY  = _this select 3;
    _a   = _this select 4;

    _pX1 = _cX + (_pX0 - _cX)*cos(_a) - (_pY0 - _cY)*sin(_a);
    _pY1 = _cY + (_pY0 - _cY)*cos(_a) + (_pX0 - _cX)*sin(_a);
    
    [_pX1,_pY1]
};

//===============================================================
// Check position in circle
// return: bool
//===============================================================
_pointInCircle = {
    //    0 - point
    //    1 - center
    //  2 - radius
    private ["_dist"];
    _dist = [(_this select 0) select 0, (_this select 0) select 1, 0] distance [(_this select 1) select 0, (_this select 1) select 1, 0];

    (_dist <= _this select 2) //bool
};

//===============================================================
// Check position in ellipse
// return: bool
//===============================================================
_pointInEllipse = {
    private ["_pX","_pY","_cX","_cY","_rX","_rY","_dir","_m1","_m2"];
    _pX  = _this select 0;
    _pY  = _this select 1;
    _cX  = _this select 2;
    _cY  = _this select 3;
    _rX  = _this select 4;
    _rY  = _this select 5;
    _dir = _this select 6;

    _dir = -_dir;

    _m1 = (cos(_dir)*(_pX -_cX) + sin(_dir)*(_pY - _cY))/_rX;
    _m2 = (sin(_dir)*(_pX -_cX) - cos(_dir)*(_pY - _cY))/_rY;
    
    (_m1*_m1 + _m2*_m2 <= 1) 
};

//===============================================================
// Check position in rectagle
// return: bool
//===============================================================
_pointInReactangle = {
    private ["_p0", "_c","_w","_h","_dir","_p1"];
    _p0     = _this select 0;
    _c     = _this select 1;
    _w     = _this select 3;
    _h     = _this select 2;
    _dir = _this select 4;
    
    _dir = _dir + 90;

    _p1 = [_p0 select 0 , _p0 select 1 , _c select 0 , _c select 1 , _dir] call _movePointByCenter;

    ((abs ((_p1 select 0) - (_c select 0)) <= _w)  && (abs ((_p1 select 1) - (_c select 1)) <= _h))
};


//===============================================================


private ["_unit", "_marker", "_markerSize","_unitPos","_markerPos","_markerDir","_w","_h"];

_unit     = _this select 0;
_marker = _this select 1;

_unitPos       = getPosATL (vehicle _unit); // height above ground level
_markerPos     = markerPos _marker;
_markerDir     = markerDir _marker;
_markerSize    = markerSize _marker;

_w = _markerSize select 0;
_h = _markerSize select 1;

switch ( markerShape _marker) do {    
    case "ELLIPSE" : {
        if (_w == _h) then {
            //circle
            [_unitPos,  _markerPos, _h] call _pointInCircle 
        } else {
            //ellipce
            [_unitPos select 0, _unitPos select 1, _markerPos select 0 , _markerPos select 1, _w, _h, _markerDir] call _pointInEllipse
        };
    };
    case "RECTANGLE" : {
        [_unitPos, _markerPos, _w , _h, _markerDir] call _pointInReactangle
    };
    default {false};
};

