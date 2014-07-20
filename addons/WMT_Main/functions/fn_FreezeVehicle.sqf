/*
 	Name: WMT_fnc_FreezeVehicle
 	
 	Author(s):
		Zealot

 	Description:
		Immobilization vehicles
	
	Parameters:
		Nothing
 	
 	Returns:
		Nothing
*/

#include "defines.sqf"

private ["_fuel","_infoStr1","_infoStr2","_infoString","_vehs","_airVehs"];

_vehs 	 = [];
_airVehs = [];

{
	if (local _x) then {
		_fuel = fuel _x;
		_x setVariable ["freezefuel", _fuel];
		if (_fuel !=0) then {
			if( not (isEngineOn _x and _x isKindOf "Air")) then {
				_vehs set [count _vehs, _x];
				_x setFuel 0;
			} else {
				_airVehs set [count _airVehs, _x];
				_x lock true;
			};
		};
	};
} forEach (vehicles); 

waitUntil {sleep 0.9; WMT_pub_frzState >= 3};

{
	_fuel = _x getVariable ["freezefuel", 1];
	[ [ [_x, _fuel], {(_this select 0) setFuel (_this select 1);} ],"bis_fnc_spawn",_x] call bis_fnc_mp;
} forEach _vehs; 

{ [ [ [_x,false], {(_this select 0) lock (_this select 1);} ],"bis_fnc_spawn",_x] call bis_fnc_mp; } foreach _airVehs;

// if lags
sleep 10;
{
	_fuel = _x getVariable ["freezefuel", 1];
	[ [ [_x, _fuel], {(_this select 0) setFuel (_this select 1);} ],"bis_fnc_spawn",_x] call bis_fnc_mp;
} forEach _vehs; 

{ [ [ [_x,false], {(_this select 0) lock (_this select 1);} ],"bis_fnc_spawn",_x] call bis_fnc_mp; } foreach _airVehs;






