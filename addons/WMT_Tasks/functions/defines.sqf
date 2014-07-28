#define PR(x) private ['x']; x

#define PARAM(X,Y,Z) private ['X']; X=[_this, Y, Z] call BIS_fnc_param;

#ifdef WMT_DEBUG

	if (isnil "wmt_debug_array") then {
		wmt_debug_array = [];
	};

	#define DBGMSG(X) wmt_debug_array set [ count wmt_debug_array, format ["T %1 TT %2 FN %3 FL %4 MSG %5",time,diag_tickTime, diag_frameno,__FILE__+":"+str(__LINE__),  X]];
#else
	#define DBGMSG(X)
#endif