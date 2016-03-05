/*
	Name: WMT_fnc_PrepareTime_client

	Author(s):
		Zealot

	Description:
		Client part of prepare time

	Parameters:
		0 - time
		1 - radius of start zone
		2 - time to remove markers

	Returns:
		Nothing
*/

private _freeztime = (_this select 0)*60;
private _distance = _this select 1;

waitUntil {not isNull player};

if (isNil "WMT_pub_frzState") then { WMT_pub_frzState = 0; };
if (isNil "WMT_pub_frzVoteWait") then { WMT_pub_frzVoteWait = []; };
if (isNil "WMT_pub_frzVoteStart") then { WMT_pub_frzVoteStart = []; };
if (isNil "WMT_pub_frzTimeLeftForced") then { WMT_pub_frzTimeLeftForced = 30; };
if (isNil "WMT_pub_frzTimeLeft") then { WMT_pub_frzTimeLeft = _freeztime; };
if (isNil "WMT_pub_frzBeginDate") then {WMT_pub_frzBeginDate = date;};


if (_freeztime == 0) then { WMT_pub_frzState = 3; };

if (WMT_pub_frzState == 0 and _freeztime > 0) then {
	WMT_pub_frzState = 1;
};

if (WMT_pub_frzState >= 3) exitWith {};

[_distance] spawn WMT_fnc_FreezePlayerClient;
[] spawn WMT_fnc_FreezeUI;
