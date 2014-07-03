// by [STELS]Zealot
private ["_fuel","_freeztime","_infoStr1","_infoStr2","_infoString"];
_freeztime = [_this, 0, 60] call BIS_fnc_param;

_vehs = [];
_attObjs = [];
_attVehs = [];

if (isServer) then {
	{
		if (local _x) then {
			_fuel = fuel _x;
			_x setVariable ["freezefuel", _fuel];
			if (_fuel !=0) then {
				_vehs set [count _vehs, _x];
				if( not (isEngineOn _x and _x isKindOf "Air")) then {
					_x setFuel 0;
				} else {
					_x lock true;
					_attVehs set [count _attVehs, _x];
				};
			};
		};
	} forEach (vehicles); 
	waitUntil {time > 0};
	{
		_vd = vectorDir _x; _vu = vectorUp _x;
		_pos = _x modelToWorld [0,0,0];
		_x setVariable ["frzorigpos", getPosATL _x];
//				diag_log ["frz", _x,_pos];
		_sp = "Helper_Base_F" createVehicle _pos;
		_sp setPos _pos;
		_sp setVectorDirAndUp [_vd, _vu];
		[ [ [_x,false], {(_this select 0) allowDamage (_this select 1);} ],"bis_fnc_spawn",_x] call bis_fnc_mp;
		_x attachTo [_sp, [0,0,0]];
		_attObjs set [count _attObjs, _sp];
		_sp setVariable ["frzveh", _x];
		_vehs set [count _vehs, _x];
	} foreach _attVehs;
};
waitUntil {sleep 0.9; WMT_pub_frzState >= 3};
if (isServer) then {
	
	{
		_fuel = _x getVariable ["freezefuel", 1];
		if (isEngineOn _x and _x isKindOf "Air") then {
			[ [ [_x,false], {(_this select 0) lock (_this select 1);} ],"bis_fnc_spawn",_x] call bis_fnc_mp;
		};
		[ [ [_x, _fuel], {(_this select 0) setFuel (_this select 1);} ],"bis_fnc_spawn",_x] call bis_fnc_mp;
	} forEach _vehs; 

	{
		_veh = _x getVariable "frzveh";

		[ [ [_veh,true,_veh getVariable ["frzorigpos", getPos _x]], {
			_obj = (_this select 0);
			detach _obj;
			_obj lock false;
			//_obj setPosATL (_this select 2);
			_obj allowDamage (_this select 1);
		} ],"bis_fnc_spawn",_veh] call bis_fnc_mp;
		deleteVehicle _x;
	} foreach _attObjs;

	// if lags
	sleep 10;
	{
		_fuel = _x getVariable ["freezefuel", 1];
		if (isEngineOn _x and _x isKindOf "Air") then {
			[ [ [_x,false], {(_this select 0) lock (_this select 1);} ],"bis_fnc_spawn",_x] call bis_fnc_mp;
		};
		[ [ [_x, _fuel], {(_this select 0) setFuel (_this select 1);} ],"bis_fnc_spawn",_x] call bis_fnc_mp;
	} forEach _vehs; 


	{
		[ [ [_x,true], {
			_obj = (_this select 0);
			_obj lock false;
			_obj allowDamage (_this select 1);
		} ],"bis_fnc_spawn",_x] call bis_fnc_mp;
	} foreach _attVehs;
//		sleep 10;
//		{deleteVehicle _x;} foreach _attObjs;
};

