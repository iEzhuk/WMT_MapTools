/*
	Name: WMT_fnc_PrepareTime_server

	Author(s):
		Zealot

	Description:
		Server part for prepare time

	Parameters:
		0 - time

	Returns:
		Nothing
*/
private _freeztime = (_this select 0)*60;

waituntil {!isnil "bis_fnc_init"};

if (isNil "WMT_pub_frzState") then { WMT_pub_frzState = 0; };
if (isNil "WMT_pub_frzVoteWait") then { WMT_pub_frzVoteWait = []; };
if (isNil "WMT_pub_frzVoteStart") then { WMT_pub_frzVoteStart = []; };
if (isNil "WMT_pub_frzTimeLeftForced") then { WMT_pub_frzTimeLeftForced = 30; };
if (isNil "WMT_pub_frzTimeLeft") then { WMT_pub_frzTimeLeft = _freeztime; };
if (isNil "WMT_pub_frzBeginDate") then {WMT_pub_frzBeginDate = date; publicVariable "WMT_pub_frzBeginDate";};

if (_freeztime ==0 ) then { WMT_pub_frzState = 3; };

if (WMT_pub_frzState == 0 and _freeztime > 0) then {
	WMT_pub_frzState = 1;
};

if (WMT_pub_frzState >= 3) exitWith {};

sleep 0.1;

while {WMT_pub_frzState < 3} do
{
	if (WMT_pub_frzTimeLeftForced <= 0) then {[] call wmt_fnc_removeBots; WMT_pub_frzState = 3; publicVariable "WMT_pub_frzState";};
	if (WMT_pub_frzTimeLeft <= 0) then {[] call wmt_fnc_removeBots; WMT_pub_frzState = 3; publicVariable "WMT_pub_frzState";};
	if (WMT_pub_frzState==2) then {WMT_pub_frzTimeLeftForced = WMT_pub_frzTimeLeftForced - 1};
	if (round(WMT_pub_frzTimeLeftForced) % 10 == 0) then {publicVariable "WMT_pub_frzTimeLeftForced";};
	if (count WMT_pub_frzVoteStart != 0 and count WMT_pub_frzVoteWait == 0 ) then {
		if (WMT_pub_frzState < 3) then { WMT_pub_frzState = 2; publicVariable "WMT_pub_frzState";};
	} else {
		if (WMT_pub_frzState == 2) then { WMT_pub_frzState = 1; publicVariable "WMT_pub_frzState";};
	};
	WMT_pub_frzTimeLeft = WMT_pub_frzTimeLeft - 1;
	if (round(WMT_pub_frzTimeLeft) % 30 == 0) then {publicVariable "WMT_pub_frzTimeLeft";};
	sleep 1;
};

setDate WMT_pub_frzBeginDate;
