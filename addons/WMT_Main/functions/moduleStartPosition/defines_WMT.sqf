#define PR(x) private ['x']; x
#define PARAM(X,Y,Z) private ['X']; X=[_this, Y, Z] call BIS_fnc_param;
#define ERROR(x) x call BIS_fnc_error; x call BIS_fnc_log;
