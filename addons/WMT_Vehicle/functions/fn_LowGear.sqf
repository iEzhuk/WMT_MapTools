/*
 	Name: WMT_fnc_LowGear
 	
 	Author(s):
		Ezhuk

 	Description:
		Loop for lowgear action

	Parameters:
		Nothing

 	Returns:
		Nothing
*/
		
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
					if(WMT_Local_LowGear_mutex < diag_tickTime - 1) then {
						_vel= [(sin _dir)*_vecorS, (cos _dir)*_vecorS, 0];
						_veh setVelocity _vel;
						WMT_Local_LowGear_mutex = diag_tickTime;
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