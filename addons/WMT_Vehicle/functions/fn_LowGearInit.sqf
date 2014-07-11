/*
 	Name: WMT_func_LowGearInit
 	
 	Author(s):
		Ezhuk

 	Description:
		Add action for high-climbing gear 

	Parameters:
		Nothing
 	
 	Returns:
		Nothing	
*/

if (isDedicated) exitWith {};
waitUntil {sleep 0.42; !(isNull (findDisplay 46))};
(findDisplay 46) displayAddEventHandler ["KeyDown",
{_key =_this select 1;
if(_key in actionKeys "carForward" or _key in actionKeys "carForward" or _key in actionKeys "carFastForward" or _key in actionKeys "carSlowForward")  then {wmt_carforward = true;};
}];
(findDisplay 46) displayAddEventHandler ["KeyUp"  , {_key =_this select 1;
if(_key in actionKeys "carForward" or _key in actionKeys "carForward" or _key in actionKeys "carFastForward" or _key in actionKeys "carSlowForward")  then {wmt_carforward = false;};
}];

WMT_LowGear_mutex = diag_tickTime;




WMT_func_LowGear = {
	private["_min","_max","_veh","_vecorS"];
	_veh = vehicle player;
	_vecorS = 1.8;
	_min = 20;
	_max = 35;

	if((["MBT",str(typeOf _veh)] call BIS_fnc_inString) || (["APC",str(typeOf _veh)] call BIS_fnc_inString) )then{
		_vecorS = 1.5;
		_min = 15;
		_max = 25;
	};

	if(WMT_Local_LowGearOn)exitWith{};

	WMT_Local_LowGearOn = true;

	while {(player==(driver _veh)) && WMT_Local_LowGearOn && (canMove _veh) && isEngineOn _veh} do {
		if (isTouchingGround _veh) then {
			_speed = speed _veh;
			_vel   = velocity _veh;
			_dir  = direction _veh;

			if (_speed < _min) then {
				if (wmt_carforward) then {
					if ( _speed >= -1 && _speed <= 0.5) then {			
						if(WMT_LowGear_mutex < diag_tickTime - 1) then {
							_vel= [(sin _dir)*_vecorS, (cos _dir)*_vecorS, 0];
							_veh setVelocity _vel;
							WMT_LowGear_mutex = diag_tickTime;
						};
					} else {
						if (_speed > 0.5) then {		
							_vel=[(_vel select 0)*1.015,(_vel select 1)*1.015,(_vel select 2)*1.01];
							_veh setVelocity _vel;
						} else {
							if (_speed > -20 && _speed <=-3) then {		
								_vel= [(_vel select 0)*0.995, (_vel select 1)*0.995, (_vel select 2)*0.995];
								_veh setVelocity _vel;
							} else {
								if ( _speed >=-3 && _speed<-1) then {		
									_vel=[(_vel select 0)*0.99,(_vel select 1)*0.99,(_vel select 2)*0.99];
									_veh setVelocity _vel;
								};
							};
						};
					};
				};		
			} else {	
				if (_speed > _max) then {		
					_vel=[(_vel select 0)*0.99,(_vel select 1)*0.985,(_vel select 2)*0.985];
					_veh setVelocity _vel;
				};
			};
			if((getPosASL _veh select 2) - (getPosATL _veh select 2) < -2) then {
				WMT_Local_LowGearOn = false;
			};
		};
		sleep 0.033;
	};

	WMT_Local_LowGearOn = false;
};


WMT_func_LowGearCond = {
	private ["_res","_veh"];
	_veh = vehicle player;
	_res = false;

	if(!WMT_Local_LowGearOn)then{
		if(player != _veh && player==(driver _veh))then{
			if(alive player && alive _veh && canMove _veh && isEngineOn _veh)then{
				if((["APC",str(typeOf _veh)] call BIS_fnc_inString) || {["MBT",str(typeOf _veh)] call BIS_fnc_inString} || {["Truck",str(typeOf _veh)] call BIS_fnc_inString} || {["MRAP",str(typeOf _veh)] call BIS_fnc_inString} || {["Offroad",str(typeOf _veh)] call BIS_fnc_inString})then{
					if( (getPosASL _veh select 2) - (getPosATL _veh select 2) > -2) then {
						if( (abs (speed _veh)) < 25)then{
							_res = true;
						};
					};
				};
			};
		};
	};
	_res
};

WMT_Local_LowGearOn = false;
player addAction[ format ["<t color='#ff0000'>%1</t>", (localize "STR_ACTION_LOWGEARON") ], WMT_func_LowGear, [], 1, false, false, '','[] call WMT_func_LowGearCond'];
player addAction[ format ["<t color='#ff0000'>%1</t>", (localize "STR_ACTION_LOWGEAROFF")], {WMT_Local_LowGearOn=false;}, [], 1, false, false, '','WMT_Local_LowGearOn'];


