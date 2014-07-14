// by [STELS]Zealot

#define PR(x) private ['x']; x

PR(_playerratio) =  [_this, 0, 0.1] call BIS_fnc_param; 
PR(_aftertime) = [_this, 1, 30] call BIS_fnc_param; 

if (_playerratio == 0) exitWith {};
if (not isServer) exitWith {diag_log "PALYERCOUNT.SQF NOT SERVER";};
waitUntil { time > _aftertime };

wmt_playerCountInit = [0,0,0];
PR(_endtimer) = false;

{
	PR(_iside)=_x;
	PR(_isideind) = _foreachindex;
	{
		if (side _x == _iside and isPlayer _x) then {
			wmt_playerCountInit set [_isideind, (wmt_playerCountInit select _isideind) + 1];
		};
	} foreach playableUnits;
} foreach [east, west, resistance];

PR(_resistanceFriendSide) = switch (true) do {
	case (west in ([resistance] call BIS_fnc_friendlySides)) : {west};
	case (east in ([resistance] call BIS_fnc_friendlySides)) : {east};
	default {sideUnknown};
	
};

while {not _endtimer} do {
	wmt_PlayerCountNow = [0,0,0];
	{
			PR(_iside)=_x;
			PR(_isideind) = _foreachindex;
			{
				if (side _x == _iside and isPlayer _x) then {
					wmt_PlayerCountNow set [_isideind, (wmt_PlayerCountNow select _isideind) + 1];
				};
			} foreach playableUnits;
	} foreach [east, west, resistance];
	{
		
		if ( (wmt_playerCountInit select _foreachindex) != 0 and {_x in [east,west] or _resistanceFriendSide == sideUnknown}) then {
			PR(_playersActualBegin) = (wmt_playerCountInit select _foreachindex) + ( if (_x == _resistanceFriendSide) then {wmt_playerCountInit select 2} else {0} );
			PR(_playersActualNow) = (wmt_PlayerCountNow select _foreachindex) + ( if (_x == _resistanceFriendSide) then {wmt_PlayerCountNow select 2} else {0} );

			if (_playersActualNow / _playersActualBegin < _playerratio) then {
				PR(_enemy) = ([_x] call BIS_fnc_enemySides) select 0;
				if (not _endtimer) then {
					[[_enemy,format[localize "STR_WMT_HLSWinLoseMSG",([_enemy]call BIS_fnc_sideName)]],"wmt_fnc_endmission"] call BIS_fnc_MP;
					_endtimer = true;
				};
			};
		};
	} foreach [east,west,resistance];
	sleep 5.5;
};

