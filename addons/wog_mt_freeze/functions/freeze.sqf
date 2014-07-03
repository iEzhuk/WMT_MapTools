// by [STELS]Zealot

_freeztime = [_this, 0, 60] call BIS_fnc_param;
_distance = [_this, 1, 150] call BIS_fnc_param;
_vehFrzMethod = [_this, 2, 0] call BIS_fnc_param;

// метод фризтайма для техники, 0 - слив топлива, 1 - аттач к объекту

private ["_cTime","_lastTime"];

if (not isDedicated) then {
	waitUntil {not isNull player};
} else {
	waituntil {!isnil "bis_fnc_init"};
};

if (isNil "zlt_pub_frz_state") then { zlt_pub_frz_state = 0; };
if (isNil "zlt_pub_frz_waitUsrs") then { zlt_pub_frz_waitUsrs = []; };
if (isNil "zlt_pub_frz_startUsrs") then { zlt_pub_frz_startUsrs = []; };
if (isNil "zlt_pub_frz_timeLeftForced") then { zlt_pub_frz_timeLeftForced = 30; };
if (isNil "zlt_pub_frz_timeLeft") then { zlt_pub_frz_timeLeft = _freeztime; };

if (_freeztime ==0 ) then { zlt_pub_frz_state = 3; };

if (zlt_pub_frz_state == 0 and _freeztime > 0) then {
	zlt_pub_frz_state = 1;
};

if (zlt_pub_frz_state >= 3) exitWith {};

if (not isDedicated) then {
	[_freeztime] execVM "freeze\grenade2.sqf";
	[_freeztime, _distance] execVM "freeze\freeze_player.sqf";
	[_freeztime] execVM "freeze\freeze_ui.sqf";
};

if (isServer) then {
	[_freeztime] execVM "freeze\freeze_vehicle.sqf";
};


if (isServer) then {
	waitUntil {sleep 0.75;time > 0};
	while {zlt_pub_frz_state < 3} do
	{
		if (zlt_pub_frz_timeLeft <= 0 or zlt_pub_frz_timeLeftForced <= 0) then {zlt_pub_frz_state = 3; publicVariable "zlt_pub_frz_state";};
		if (zlt_pub_frz_state==2) then {zlt_pub_frz_timeLeftForced = zlt_pub_frz_timeLeftForced - 1};
		if (round(zlt_pub_frz_timeLeftForced) % 5 == 0) then {publicVariable "zlt_pub_frz_timeLeftForced";};
		
		if (count zlt_pub_frz_startUsrs != 0 and count zlt_pub_frz_waitUsrs == 0 ) then {
			if (zlt_pub_frz_state < 3) then { 	zlt_pub_frz_state = 2; 	publicVariable "zlt_pub_frz_state";	};
		} else {
			if (zlt_pub_frz_state == 2) then { 	zlt_pub_frz_state = 1;	publicVariable "zlt_pub_frz_state"; };
		};
		sleep 1;
		zlt_pub_frz_timeLeft = zlt_pub_frz_timeLeft - 1;
		if (round(zlt_pub_frz_timeLeft) % 10 == 0) then {publicVariable "zlt_pub_frz_timeLeft";};
	};
};


