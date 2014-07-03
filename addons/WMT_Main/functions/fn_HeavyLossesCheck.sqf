 // by [STELS]Zealot

#include "defines.sqf"
private ["_losses","_westalive","_eastalive","_resalive","_reseastfriend","_reswestfriend","_sides","_inittotal", "_initialwest","_initialeast","_initialres","_i"];



PARAM(_losses, 0, 0.01);
PARAM(_freeztime, 1, 60);

waitUntil { sleep 0.67; time > _freeztime };

PR(_fnc_countAliveForSidesOnly) = {
	PR(_sides) =  [_this, 0, [east]] call BIS_fnc_param;
	PR(_res) = 0;
	{ _i = _x; _res = _res + ({(isPlayer _x) and (alive _x) and (side _x == _i)} count playableUnits); } foreach _sides;
	_res;
};

PR(_fnc_getBeginForSidesOnly) = {
	PR(_sides) =  [_this, 0, [east]] call BIS_fnc_param;
	PR(_res) = 0;
	{_res = _res + (wmt_hlsBeginUnitsCount select ([_x] call BIS_fnc_sideID)) } foreach _sides;
	_res;
};

wmt_hlsBeginUnitsCount = []; // без учета союзников
wmt_hlsSides = [east,west,resistance];
_nullSides = [civilian];

{
	_i = _x;
	_count = [[_x]] call _fnc_countAliveForSidesOnly;
	wmt_hlsBeginUnitsCount set [count wmt_hlsBeginUnitsCount, _count];
	if (_count == 0) then {_nullSides = _nullSides + [_x]};
} foreach wmt_hlsSides;

diag_log ("LOSSES.SQF INITIALIZED UNITS:"+str(wmt_hlsBeginUnitsCount) + " NULL:" + str(_nullSides)) ;  

wmt_hlsSides = wmt_hlsSides - _nullSides;

_winside = [east];
scopename "main";

while {true} do {
	sleep 5.5;
	
	// для каждой стороны - все их враги понесли потери
	{
		_enemies = [_x] call BIS_fnc_enemySides;
		_beginEnemies = [_enemies] call _fnc_getBeginForSidesOnly;
		_aliveEnemies = [_enemies] call _fnc_countAliveForSidesOnly;
		if (_beginEnemies > 0) then {
			if (_aliveEnemies / _beginEnemies < _losses ) then {
				diag_log ("LOSSES.SQF TRIGGERED BEGIN:"+str(_beginEnemies)+" ALIVE:"+str(_aliveEnemies)+" INITIAL:"+str(wmt_hlsBeginUnitsCount) + " NULL:"+str(_nullSides));
				_winside = ([_x] call BIS_fnc_friendlySides) - _nullSides ;
				breakTo "main";
			};
		};
	} foreach wmt_hlsSides;
};

_s = "";
{_s = _s +' ' +([_x]call BIS_fnc_sideName);} foreach _winside;
[[_winside select 0,format[localize "STR_WMT_HLSWinLoseMSG",_s]],"WMT_fnc_EndMission"] call BIS_fnc_MP;
