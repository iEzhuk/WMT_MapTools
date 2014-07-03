/*
 	Name: WMT_fnc_PrepareTime_client
 	
 	Author(s):
		Zealot

 	Description:
		Server part of prepare time - immobilaze vehicles, timer.

	Parameters:
		0 - time 
		1 - radius of start zone 
 		2 - time to remove markers

 	Returns:
		Nothing 
*/
#include "defines.sqf"

_freeztime = (_this select 0)*60;
_distance = _this select 1;


waitUntil {not isNull player};

if (isNil "WMT_pub_frzState") then { WMT_pub_frzState = 0; };
if (isNil "WMT_pub_frzVoteWait") then { WMT_pub_frzVoteWait = []; };
if (isNil "WMT_pub_frzVoteStart") then { WMT_pub_frzVoteStart = []; };
if (isNil "WMT_pub_frzTimeLeftForced") then { WMT_pub_frzTimeLeftForced = 30; };
if (isNil "WMT_pub_frzTimeLeft") then { WMT_pub_frzTimeLeft = _freeztime; };


if (_freeztime ==0 ) then { WMT_pub_frzState = 3; };

if (WMT_pub_frzState == 0 and _freeztime > 0) then {
	WMT_pub_frzState = 1;
};

if (WMT_pub_frzState >= 3) exitWith {};

[_freeztime] spawn WMT_fnc_FreezeGrenadeClient;
[_freeztime, _distance] spawn WMT_fnc_FreezePlayerClient;
[_freeztime] spawn WMT_fnc_FreezeUI;	

PR(_vehs) = [];
if (not isDedicated) then {
	waitUntil {sleep 0.3; player == player};
	{ _evh = _x addEventHandler ["Fired",{
		if (WMT_pub_frzState < 3) then {
			deleteVehicle (_this select 6);
		};}];
		_x setVariable ["frz_evh", _evh];
		_vehs = _vehs + [_x];
	} foreach vehicles;
};
waitUntil {sleep 0.9; WMT_pub_frzState >= 3};
if (not isDedicated) then {
	{

		_evh = _x getVariable "frz_evh";
		if (!isNil "_evh") then {
			_x removeEventHandler ["Fired", _evh];
		};
	} foreach _vehs;

};