// by [STELS]Zealot

#define PR(x) private ['x']; x

PR(_playerratio) =  [_this, 0, 0.1] call BIS_fnc_param; 
PR(_aftertime) = [_this, 1, 30] call BIS_fnc_param; 

//if (_playerratio == 0) exitWith {};
if (not isServer) exitWith {diag_log "PALYERCOUNT.SQF NOT SERVER";};
waitUntil { time > _aftertime };


if (isNil "wmt_hl_sidelimits") then {
	wmt_hl_sidelimits = [0,0,0];
};

PR(_endtimer) = false;

wmt_playerCountInit = [
	{side _x == east and isPlayer _x} count playableUnits,
	{side _x == west and isPlayer _x} count playableUnits,
	{side _x == resistance and isPlayer _x} count playableUnits
];

PR(_resistanceFriendSide) = switch (true) do {
	case (west in ([resistance] call BIS_fnc_friendlySides)) : {west};
	case (east in ([resistance] call BIS_fnc_friendlySides)) : {east};
	default {sideUnknown};
	
};

wmtPlayerCountEmptySides = [civilian];
{
	if( (wmt_playerCountInit select _foreachindex) == 0) then {
		wmtPlayerCountEmptySides = wmtPlayerCountEmptySides + [_x];
	};
} foreach [east, west, resistance];



while {not _endtimer} do {
	wmt_PlayerCountNow = [
		{side _x == east and isPlayer _x} count playableUnits,
		{side _x == west and isPlayer _x} count playableUnits,
		{side _x == resistance and isPlayer _x} count playableUnits
	];
	{
		
		if ( not _endtimer and {_x in [east,west] or _resistanceFriendSide == sideUnknown} ) then {
			PR(_playersActualBegin) = (wmt_playerCountInit select _foreachindex) + ( if (_x == _resistanceFriendSide) then {wmt_playerCountInit select 2} else {0} );
			PR(_playersActualNow) = (wmt_PlayerCountNow select _foreachindex) + ( if (_x == _resistanceFriendSide) then {wmt_PlayerCountNow select 2} else {0} );

			if ( _playersActualBegin != 0 ) then {
				if ( _playerratio !=0 and {_playersActualNow / _playersActualBegin < _playerratio} ) then {_endtimer = true};
				if ( _playersActualNow <= ( wmt_hl_sidelimits select _foreachindex ) ) then {_endtimer = true};

				if (_endtimer) then {
					PR(_enemy) = if ( count (([_x] call BIS_fnc_enemySides) - wmtPlayerCountEmptySides) > 0) then {(([_x] call BIS_fnc_enemySides) - wmtPlayerCountEmptySides) select 0} else {sideUnknown};
					[[_enemy,format[localize "STR_WMT_HLSWinLoseMSG",([_enemy]call BIS_fnc_sideName)]],"wmt_fnc_endmission"] call BIS_fnc_MP;
				};
			};
		};
	} foreach [east,west,resistance];
	sleep 5.5;
};

